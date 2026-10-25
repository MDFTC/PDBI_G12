import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

// ======================= CONFIGURACIÓN =======================
// Deben coincidir EXACTAMENTE con los del firmware del ESP32 (v2).
const serviceUuid = '4fafc202-1fb5-459e-8fcc-c5c9c331914b';
const dataUuid = 'beb5483e-36e1-4688-b7f5-ea07361b26a8'; // ESP32 -> app (notify)
const cmdUuid = 'beb5483e-36e1-4688-b7f5-ea07361b26a9'; // app -> ESP32 (write)

const nombreApp = 'QaraSkin';
const lema = 'Tamizaje cutáneo cerca de ti'; // cámbienlo por su lema
const versionApp = 'v2.4'; // sirve para confirmar qué versión está instalada

// Umbrales de ejemplo para la recomendación. Ajústenlos con su equipo
// según el desempeño real del modelo.
const umbralProbabilidad = 0.50;
const umbralConfianza = 0.70;
// =============================================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cargarPerfil();
  runApp(const QaraSkinApp());
}

class QaraSkinApp extends StatelessWidget {
  const QaraSkinApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: nombreApp,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}

// ----------------------- MODELOS -----------------------
class Medicion {
  final double? prob;
  final double? conf;
  final Uint8List? foto;
  final Uint8List? grad;
  const Medicion({this.prob, this.conf, this.foto, this.grad});

  Medicion copyWith({Uint8List? foto, Uint8List? grad}) => Medicion(
        prob: prob,
        conf: conf,
        foto: foto ?? this.foto,
        grad: grad ?? this.grad,
      );
}

class Paciente {
  final String nombre, documento, edad, zona;
  const Paciente(this.nombre, this.documento, this.edad, this.zona);
}


// Datos del establecimiento y del profesional (se piden una vez y se guardan
// en el celular; aparecen en todos los informes).
class Perfil {
  final String establecimiento, codigo, profesional, colegiatura;
  const Perfil({
    this.establecimiento = '',
    this.codigo = '',
    this.profesional = '',
    this.colegiatura = '',
  });

  bool get completo =>
      (establecimiento.trim().isNotEmpty || codigo.trim().isNotEmpty) &&
      profesional.trim().isNotEmpty;

  Map<String, String> toJson() => {
        'establecimiento': establecimiento,
        'codigo': codigo,
        'profesional': profesional,
        'colegiatura': colegiatura,
      };

  factory Perfil.fromJson(Map<String, dynamic> j) => Perfil(
        establecimiento: (j['establecimiento'] ?? '').toString(),
        codigo: (j['codigo'] ?? '').toString(),
        profesional: (j['profesional'] ?? '').toString(),
        colegiatura: (j['colegiatura'] ?? '').toString(),
      );
}

final perfilActual = ValueNotifier<Perfil>(const Perfil());

Future<File> _archivoPerfil() async {
  final base = await getApplicationDocumentsDirectory();
  return File('${base.path}/perfil.json');
}

Future<void> cargarPerfil() async {
  try {
    final f = await _archivoPerfil();
    if (await f.exists()) {
      perfilActual.value = Perfil.fromJson(
          jsonDecode(await f.readAsString()) as Map<String, dynamic>);
    }
  } catch (_) {}
}

Future<void> guardarPerfil(Perfil p) async {
  perfilActual.value = p;
  final f = await _archivoPerfil();
  await f.writeAsString(jsonEncode(p.toJson()));
}

class Ubicacion {
  final double lat, lon;
  final double? precision;
  final String origen;
  const Ubicacion(this.lat, this.lon, this.precision, this.origen);
}

// Pide la ubicación GPS del celular. Devuelve null si no se pudo obtener
// (permiso negado, GPS apagado o sin señal).
Future<Ubicacion?> obtenerUbicacion() async {
  try {
    if (!await Geolocator.isLocationServiceEnabled()) return null;
    var permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }
    if (permiso == LocationPermission.denied ||
        permiso == LocationPermission.deniedForever) {
      return null;
    }
    try {
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );
      return Ubicacion(pos.latitude, pos.longitude, pos.accuracy, 'GPS');
    } catch (_) {
      final ult = await Geolocator.getLastKnownPosition();
      if (ult != null) {
        return Ubicacion(ult.latitude, ult.longitude, ult.accuracy,
            'ultima posicion conocida, puede ser antigua');
      }
      return null;
    }
  } catch (_) {
    return null;
  }
}

// CRC32 estándar (mismo algoritmo que el firmware del ESP32).
int crc32(List<int> data) {
  var crc = 0xFFFFFFFF;
  for (final b in data) {
    crc ^= b;
    for (var k = 0; k < 8; k++) {
      crc = (crc & 1) != 0 ? (crc >> 1) ^ 0xEDB88320 : (crc >> 1);
    }
  }
  return (crc ^ 0xFFFFFFFF) & 0xFFFFFFFF;
}

// ----------------------- SERVICIO BLE -----------------------
// Paquetes ESP32 -> app (canal DATA). Primer byte = tipo:
//   'T' + texto:
//     PEND|n|idMasAntiguo        capturas sin guardar en el dispositivo
//     NEW|id|n                   captura nueva registrada
//     REC|id|prob|conf|nImg|nGrd inicio de una captura
//     STREAM|id|IMG|N            inicio de un flujo de N bytes (IMG o GRD)
//     ENDSTREAM|id|IMG|crc32hex  fin del flujo con su CRC32
//     DONE|id                    captura enviada completa
//     FULL|max / ERR|detalle     avisos
//   'B' + seq(2 bytes) + bytes   trozo de imagen numerado
// Comandos app -> ESP32 (canal CMD): SYNC | GET|id | DEL|id | SAVED|id
class BleService {
  BleService._();
  static final instance = BleService._();

  final estado = ValueNotifier<String>('Desconectado');
  final ultimoMensaje = ValueNotifier<String>('-');
  final alerta = ValueNotifier<String>('');
  final pendientes = ValueNotifier<int>(0);
  final medicion = ValueNotifier<Medicion>(const Medicion());
  final completo = ValueNotifier<bool>(false);
  final progreso = ValueNotifier<String>('');
  final errorTransferencia = ValueNotifier<String>('');

  int idMasAntiguo = 0;
  int idActual = 0;
  bool esperandoCaptura = false;

  BluetoothCharacteristic? _data;
  BluetoothCharacteristic? _cmd;
  StreamSubscription? _subScan, _subRx, _subConn;
  bool _conectando = false;

  // Estado de la transferencia de imagen en curso
  final List<int> _buf = [];
  String _kind = '';
  int _esperadoN = 0;
  int _seq = 0;
  bool _falloSeq = false;

  bool get conectado => _data != null && _cmd != null;

  // ---------- Conexión ----------
  String _nombreDe(ScanResult r) => r.advertisementData.advName.isNotEmpty
      ? r.advertisementData.advName
      : r.device.platformName;

  Future<void> conectar() async {
    if (_conectando || conectado) return;
    estado.value = 'Buscando... (0 dispositivos cerca)';

    final permisos = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
    // Solo informativo: no se bloquea la búsqueda por estos valores.
    ultimoMensaje.value =
        'Permisos: escaneo=${permisos[Permission.bluetoothScan]?.name} '
        'conexion=${permisos[Permission.bluetoothConnect]?.name} '
        'ubicacion=${permisos[Permission.locationWhenInUse]?.name} | '
        'Bluetooth=${FlutterBluePlus.adapterStateNow.name}';

    // Se escanea sin filtro y se reconoce el ESP32 por su UUID o por su nombre.
    final vistos = <String, String>{};
    _subScan?.cancel();
    _subScan = FlutterBluePlus.scanResults.listen((lista) async {
      for (final r in lista) {
        vistos[r.device.remoteId.str] = _nombreDe(r);
      }
      if (_conectando) return;
      estado.value = 'Buscando... (${vistos.length} dispositivos cerca)';
      for (final r in lista) {
        final tieneUuid =
            r.advertisementData.serviceUuids.contains(Guid(serviceUuid));
        if (tieneUuid || _nombreDe(r) == 'ESP32-Melanoma') {
          _conectando = true;
          await FlutterBluePlus.stopScan();
          await _conectarA(r.device);
          return;
        }
      }
    });

    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 12));
    } catch (e) {
      estado.value = 'Error al iniciar la búsqueda: $e';
      return;
    }

    await Future.delayed(const Duration(seconds: 13));
    if (estado.value.startsWith('Buscando')) {
      final nombres =
          vistos.values.where((n) => n.isNotEmpty).take(5).join(', ');
      estado.value = vistos.isEmpty
          ? 'La búsqueda no devolvió ningún dispositivo (0 vistos).'
          : 'No se encontró el ESP32. Vistos: ${vistos.length} '
              '(${nombres.isEmpty ? 'sin nombre' : nombres}).';
    }
  }

  Future<void> _conectarA(BluetoothDevice d) async {
    _subScan?.cancel();
    try {
      estado.value = 'Conectando...';
      await d.connect(license: License.nonprofit);
      if (Platform.isAndroid) {
        await d.requestMtu(247);
      }
      final servicios = await d.discoverServices();
      for (final s in servicios) {
        if (s.uuid == Guid(serviceUuid)) {
          for (final c in s.characteristics) {
            if (c.uuid == Guid(dataUuid)) _data = c;
            if (c.uuid == Guid(cmdUuid)) _cmd = c;
          }
        }
      }
      if (!conectado) {
        _data = null;
        _cmd = null;
        estado.value = 'Servicio no encontrado (apague y encienda el Bluetooth del celular)';
        return;
      }
      await _data!.setNotifyValue(true);
      _subRx?.cancel();
      _subRx = _data!.onValueReceived.listen(_alRecibir);
      _subConn?.cancel();
      _subConn = d.connectionState.listen((st) {
        if (st == BluetoothConnectionState.disconnected) {
          _data = null;
          _cmd = null;
          _resetTransferencia();
          pendientes.value = 0;
          idMasAntiguo = 0;
          progreso.value = '';
          if (idActual != 0 && !completo.value) {
            errorTransferencia.value =
                'Se perdió la conexión durante la transferencia.';
          }
          estado.value = 'Desconectado';
        }
      });
      estado.value = 'Conectado';
      await enviar('SYNC'); // pregunta cuántas capturas hay sin guardar
    } catch (e) {
      estado.value = 'Error: $e';
    } finally {
      _conectando = false;
    }
  }

  // ---------- Recepción ----------
  void _alRecibir(List<int> d) {
    if (d.isEmpty) return;
    final tipo = d[0];
    if (tipo == 0x54) {
      // 'T' texto
      final texto = utf8.decode(d.sublist(1), allowMalformed: true);
      ultimoMensaje.value = texto;
      _procesarTexto(texto);
    } else if (tipo == 0x42 && d.length > 3) {
      // 'B' trozo de imagen
      if (_kind.isEmpty) return;
      final seq = (d[1] << 8) | d[2];
      if (seq != _seq) _falloSeq = true;
      _seq = seq + 1;
      _buf.addAll(d.sublist(3));
      if (_esperadoN > 0) {
        final pct = (100 * _buf.length / _esperadoN).clamp(0, 100).round();
        progreso.value =
            '${_kind == 'IMG' ? 'Imagen' : 'Grad-CAM'}: $pct %';
      }
    }
  }

  int _i(List<String> p, int k) => k < p.length ? (int.tryParse(p[k]) ?? 0) : 0;

  void _procesarTexto(String t) {
    final p = t.split('|');
    switch (p[0]) {
      case 'PEND':
        {
          pendientes.value = _i(p, 1);
          idMasAntiguo = _i(p, 2);
        }
      case 'NEW':
        {
          final id = _i(p, 1);
          pendientes.value = _i(p, 2);
          if (esperandoCaptura) {
            esperandoCaptura = false;
            pedirRegistro(id);
          } else if (idMasAntiguo == 0) {
            idMasAntiguo = id;
          }
        }
      case 'REC':
        {
          _resetTransferencia();
          idActual = _i(p, 1);
          final prob = double.tryParse(p.length > 2 ? p[2] : '');
          final conf = double.tryParse(p.length > 3 ? p[3] : '');
          medicion.value = Medicion(prob: prob, conf: conf);
          completo.value = false;
          errorTransferencia.value = '';
        }
      case 'STREAM':
        {
          _buf.clear();
          _kind = p.length > 2 ? p[2] : '';
          _esperadoN = _i(p, 3);
          _seq = 0;
          _falloSeq = false;
          progreso.value = 'Recibiendo imagen...';
        }
      case 'ENDSTREAM':
        {
          final crcEsperado =
              int.tryParse(p.length > 3 ? p[3] : '', radix: 16) ?? -1;
          final ok = !_falloSeq &&
              _buf.length == _esperadoN &&
              crc32(_buf) == crcEsperado;
          if (ok) {
            final bytes = Uint8List.fromList(_buf);
            medicion.value = _kind == 'IMG'
                ? medicion.value.copyWith(foto: bytes)
                : medicion.value.copyWith(grad: bytes);
          } else {
            errorTransferencia.value =
                'Una imagen llegó dañada o incompleta. Pulse "Reintentar".';
          }
          _buf.clear();
          _kind = '';
          progreso.value = '';
        }
      case 'DONE':
        {
          progreso.value = '';
          if (errorTransferencia.value.isEmpty) completo.value = true;
        }
      case 'FULL':
        alerta.value =
            'Memoria del dispositivo llena. Resuelva las capturas pendientes.';
      case 'ERR':
        alerta.value = 'Error del dispositivo: ${p.skip(1).join(' ')}';
    }
  }

  void _resetTransferencia() {
    _buf.clear();
    _kind = '';
    _esperadoN = 0;
    _seq = 0;
    _falloSeq = false;
  }

  // ---------- Comandos ----------
  Future<bool> enviar(String comando) async {
    if (_cmd == null) return false;
    await _cmd!.write(utf8.encode(comando));
    return true;
  }

  void _limpiarLocal() {
    _resetTransferencia();
    medicion.value = const Medicion();
    completo.value = false;
    progreso.value = '';
    errorTransferencia.value = '';
  }

  void nuevaMedicion() {
    _limpiarLocal();
    idActual = 0;
  }

  // Flujo normal: la app espera que el dispositivo capture.
  void iniciarEspera() {
    nuevaMedicion();
    esperandoCaptura = true;
  }

  void detenerEspera() => esperandoCaptura = false;

  // Pide al dispositivo una captura concreta de su cola.
  Future<void> pedirRegistro(int id) async {
    esperandoCaptura = false;
    _limpiarLocal();
    idActual = id;
    if (!conectado) {
      errorTransferencia.value =
          'Sin conexión con el dispositivo. Reconecte y pulse "Reintentar".';
      return;
    }
    await enviar('GET|$id');
  }

  // Foto incorrecta: borra esa captura de la memoria del ESP32.
  Future<void> eliminarEnDispositivo() async {
    final id = idActual;
    if (id > 0) await enviar('DEL|$id');
    nuevaMedicion();
  }

  // Informe guardado: el ESP32 libera esa captura.
  Future<void> marcarGuardado() async {
    final id = idActual;
    if (id > 0) await enviar('SAVED|$id');
    nuevaMedicion();
  }

  // Desde el aviso de pendientes: borra la más antigua.
  Future<void> eliminarMasAntigua() async {
    if (idMasAntiguo > 0) await enviar('DEL|$idMasAntiguo');
  }

  // Solo para pruebas sin dispositivo.
  void simularResultado() {
    idActual = 0;
    medicion.value = const Medicion(prob: 0.82, conf: 0.91);
    completo.value = true;
  }
}

// ----------------------- PDF -----------------------
String recomendacion(Medicion m) {
  final prob = m.prob ?? 0, conf = m.conf ?? 0;
  if (conf < umbralConfianza) {
    return 'Resultado no concluyente. Repetir captura o derivar para evaluacion clinica.';
  }
  if (prob >= umbralProbabilidad) {
    return 'Posible melanoma. Se recomienda derivar a dermatologia.';
  }
  return 'Baja probabilidad de melanoma. Mantener seguimiento clinico.';
}

Future<Directory> carpetaInformes() async {
  final base = await getApplicationDocumentsDirectory();
  final dir = Directory('${base.path}/informes');
  if (!dir.existsSync()) dir.createSync(recursive: true);
  return dir;
}

Future<File> generarPdf(Paciente p, Medicion m, int idCaptura,
    Perfil perfil, Ubicacion? ubic, String notaUbic) async {
  final doc = pw.Document();
  final ahora = DateTime.now();
  final fecha = ahora.toString().substring(0, 16);

  pw.Widget imagen(Uint8List? bytes, String titulo) => pw.Expanded(
        child: pw.Column(children: [
          pw.Text(titulo),
          pw.SizedBox(height: 4),
          bytes != null
              ? pw.Image(pw.MemoryImage(bytes), height: 160)
              : pw.Container(
                  height: 160,
                  alignment: pw.Alignment.center,
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Text('Sin imagen'),
                ),
        ]),
      );

  doc.addPage(pw.Page(
    build: (c) => pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('QaraSkin - Informe de tamizaje de lesion pigmentada',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Text('Fecha: $fecha'),
        pw.Text(
            'Establecimiento de salud: ${perfil.establecimiento.isEmpty ? '-' : perfil.establecimiento}'),
        pw.Text(
            'Codigo del establecimiento: ${perfil.codigo.isEmpty ? '-' : perfil.codigo}'),
        pw.Text(
            'Profesional que tomo la imagen: ${perfil.profesional}${perfil.colegiatura.isEmpty ? '' : ' (Col. ${perfil.colegiatura})'}'),
        pw.Text(ubic == null
            ? 'Ubicacion GPS: no disponible'
            : 'Ubicacion GPS: ${ubic.lat.toStringAsFixed(6)}, ${ubic.lon.toStringAsFixed(6)} (precision ${ubic.precision == null ? '?' : ubic.precision!.round()} m; ${ubic.origen})'),
        if (ubic != null)
          pw.Text(
              'Mapa: https://www.google.com/maps?q=${ubic.lat.toStringAsFixed(6)},${ubic.lon.toStringAsFixed(6)}',
              style: const pw.TextStyle(fontSize: 8)),
        if (ubic != null)
          pw.Text(notaUbic, style: const pw.TextStyle(fontSize: 8)),
        if (idCaptura > 0) pw.Text('Captura del dispositivo: #$idCaptura'),
        pw.Text('Paciente: ${p.nombre}'),
        pw.Text('Documento: ${p.documento}'),
        pw.Text('Edad: ${p.edad}'),
        pw.Text('Zona de la lesion: ${p.zona}'),
        pw.Divider(),
        pw.Text(
            'Probabilidad de melanoma: ${((m.prob ?? 0) * 100).toStringAsFixed(1)} %'),
        pw.Text(
            'Valor de confianza: ${((m.conf ?? 0) * 100).toStringAsFixed(1)} %'),
        pw.SizedBox(height: 6),
        pw.Text('Recomendacion: ${recomendacion(m)}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 12),
        pw.Row(children: [
          imagen(m.foto, 'Imagen capturada'),
          pw.SizedBox(width: 12),
          imagen(m.grad, 'Mapa de activacion (Grad-CAM)'),
        ]),
        pw.Spacer(),
        pw.Text(
            'Aviso: este resultado es una herramienta de apoyo al tamizaje y no '
            'constituye un diagnostico. Requiere verificacion por personal medico.',
            style: const pw.TextStyle(fontSize: 9)),
      ],
    ),
  ));

  final dir = await carpetaInformes();
  final nombreArchivo =
      'informe_${p.documento}_${ahora.millisecondsSinceEpoch}.pdf';
  final file = File('${dir.path}/$nombreArchivo');
  await file.writeAsBytes(await doc.save());

  // Copia de los mismos datos en formato estructurado (servirá para la nube).
  final datos = {
    'version_app': versionApp,
    'fecha': ahora.toIso8601String(),
    'captura_dispositivo': idCaptura,
    'establecimiento': perfil.toJson(),
    'paciente': {
      'nombre': p.nombre,
      'documento': p.documento,
      'edad': p.edad,
      'zona_lesion': p.zona,
    },
    'resultado': {
      'probabilidad': m.prob,
      'confianza': m.conf,
      'recomendacion': recomendacion(m),
    },
    'ubicacion': ubic == null
        ? null
        : {
            'lat': ubic.lat,
            'lon': ubic.lon,
            'precision_m': ubic.precision,
            'origen': ubic.origen,
            'nota': notaUbic,
          },
  };
  final jsonFile = File(file.path.replaceAll(RegExp(r'\.pdf$'), '.json'));
  await jsonFile
      .writeAsString(const JsonEncoder.withIndent('  ').convert(datos));
  return file;
}

// ----------------------- ACCIONES SOBRE LOS PDF -----------------------
void _aviso(BuildContext context, String texto) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
}

// Abre el PDF con el lector de PDF del celular.
Future<void> verPdf(BuildContext context, File f) async {
  final r = await OpenFilex.open(f.path, type: 'application/pdf');
  if (r.type != ResultType.done) {
    _aviso(context,
        'No se pudo abrir el PDF (${r.message}). Instale un lector de PDF o use Compartir.');
  }
}

// Abre el selector de Android para elegir carpeta y guardar una copia.
Future<void> guardarPdfEnArchivos(BuildContext context, File f) async {
  try {
    final bytes = await f.readAsBytes();
    final destino = await FilePicker.saveFile(
      dialogTitle: 'Guardar informe',
      fileName: f.path.split('/').last,
      bytes: bytes,
    );
    _aviso(
        context,
        destino == null
            ? 'Guardado cancelado o no confirmado.'
            : 'Informe guardado en Archivos.');
  } catch (e) {
    _aviso(context, 'No se pudo guardar: $e');
  }
}

// Menú que aparece al tocar un informe del historial.
void menuInforme(BuildContext context, File f) {
  showModalBottomSheet(
    context: context,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(f.path.split('/').last,
                style: Theme.of(context).textTheme.labelLarge),
          ),
          ListTile(
            leading: const Icon(Icons.visibility),
            title: const Text('Ver PDF'),
            onTap: () {
              Navigator.pop(sheetContext);
              verPdf(context, f);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Guardar en Archivos'),
            onTap: () {
              Navigator.pop(sheetContext);
              guardarPdfEnArchivos(context, f);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Compartir'),
            onTap: () {
              Navigator.pop(sheetContext);
              SharePlus.instance.share(ShareParams(files: [XFile(f.path)]));
            },
          ),
        ],
      ),
    ),
  );
}


// ----------------------- PERFIL DEL ESTABLECIMIENTO -----------------------
Future<bool> asegurarPerfil(BuildContext context) async {
  if (perfilActual.value.completo) return true;
  _aviso(context, 'Primero complete los datos del establecimiento y del profesional.');
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PerfilScreen()),
  );
  return perfilActual.value.completo;
}

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});
  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late final TextEditingController est, cod, prof, col;

  @override
  void initState() {
    super.initState();
    final p = perfilActual.value;
    est = TextEditingController(text: p.establecimiento);
    cod = TextEditingController(text: p.codigo);
    prof = TextEditingController(text: p.profesional);
    col = TextEditingController(text: p.colegiatura);
  }

  @override
  Widget build(BuildContext context) {
    Widget campo(String label, TextEditingController c) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextField(
            controller: c,
            decoration: InputDecoration(
                labelText: label, border: const OutlineInputBorder()),
          ),
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Establecimiento y profesional')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                  'Estos datos aparecen en todos los informes. Cámbielos cuando '
                  'cambie el profesional o el establecimiento.'),
            ),
          ),
          const SizedBox(height: 12),
          campo('Nombre del establecimiento de salud', est),
          campo('Código del establecimiento', cod),
          campo('Nombre del profesional que toma la imagen', prof),
          campo('N.° de colegiatura (opcional)', col),
          FilledButton(
            onPressed: () async {
              final p = Perfil(
                establecimiento: est.text.trim(),
                codigo: cod.text.trim(),
                profesional: prof.text.trim(),
                colegiatura: col.text.trim(),
              );
              if (!p.completo) {
                _aviso(context,
                    'Indique el nombre o el código del establecimiento y el nombre del profesional.');
                return;
              }
              await guardarPerfil(p);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

// ----------------------- LOGO Y SPLASH -----------------------
// Logo provisional dibujado con widgets. Para usar su logo real:
// 1) guarden la imagen en assets/logo.png
// 2) en pubspec.yaml agreguen:  flutter:  assets:  - assets/logo.png
// 3) reemplacen el contenido de LogoQara por Image.asset('assets/logo.png', width: size)
class LogoQara extends StatelessWidget {
  final double size;
  const LogoQara({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset('assets/logo.png',
          width: size, height: size, fit: BoxFit.cover),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InicioScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LogoQara(size: 120),
            const SizedBox(height: 20),
            const Text(nombreApp,
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(lema,
                style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }
}

// ----------------------- PANTALLAS -----------------------
class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});
  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final ble = BleService.instance;
  List<File> informes = [];

  @override
  void initState() {
    super.initState();
    _cargarInformes();
  }

  Future<void> _cargarInformes() async {
    final dir = await carpetaInformes();
    final lista = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.pdf'))
        .toList()
      ..sort((a, b) => b.path.compareTo(a.path));
    if (mounted) setState(() => informes = lista);
  }

  Future<void> _nuevoRegistro({bool conservar = false}) async {
    if (!conservar && ble.pendientes.value > 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Primero resuelva las capturas pendientes del dispositivo.')));
      return;
    }
    if (!await asegurarPerfil(context)) return;
    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RegistroScreen(conservar: conservar)),
    );
    _cargarInformes();
  }

  Future<void> _confirmarEliminar() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar captura'),
        content: const Text(
            'Se borrará del dispositivo la captura más antigua sin guardar. '
            'Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar')),
        ],
      ),
    );
    if (ok == true) await ble.eliminarMasAntigua();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          LogoQara(size: 30),
          SizedBox(width: 10),
          Text('$nombreApp $versionApp'),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Nuevo registro'),
        onPressed: () => _nuevoRegistro(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Establecimiento y profesional
            ValueListenableBuilder<Perfil>(
              valueListenable: perfilActual,
              builder: (_, p, __) => Card(
                child: ListTile(
                  dense: true,
                  leading: const Icon(Icons.local_hospital_outlined),
                  title: Text(p.completo
                      ? '${p.establecimiento.isNotEmpty ? p.establecimiento : p.codigo} · ${p.profesional}'
                      : 'Configure el establecimiento y el profesional'),
                  trailing: const Icon(Icons.edit_outlined),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PerfilScreen()),
                  ),
                ),
              ),
            ),
            // Estado de conexión + último mensaje
            ValueListenableBuilder<String>(
              valueListenable: ble.estado,
              builder: (_, e, __) => Card(
                child: ListTile(
                  leading: Icon(
                    e == 'Conectado'
                        ? Icons.bluetooth_connected
                        : Icons.bluetooth_searching,
                    color: e == 'Conectado' ? Colors.green : Colors.grey,
                  ),
                  title: Text('Dispositivo: $e'),
                  subtitle: ValueListenableBuilder<String>(
                    valueListenable: ble.ultimoMensaje,
                    builder: (_, m, __) => Text('Ultimo mensaje: $m'),
                  ),
                  trailing: TextButton(
                    onPressed: ble.conectar,
                    child: const Text('Conectar'),
                  ),
                ),
              ),
            ),
            // Avisos del dispositivo (memoria llena, errores)
            ValueListenableBuilder<String>(
              valueListenable: ble.alerta,
              builder: (_, a, __) {
                if (a.isEmpty) return const SizedBox.shrink();
                return Card(
                  color: Colors.red.shade100,
                  child: ListTile(
                    leading: const Icon(Icons.warning_amber),
                    title: Text(a),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => ble.alerta.value = '',
                    ),
                  ),
                );
              },
            ),
            // Capturas sin guardar en el ESP32
            ValueListenableBuilder<int>(
              valueListenable: ble.pendientes,
              builder: (_, n, __) {
                if (n == 0) return const SizedBox.shrink();
                return Card(
                  color: Colors.amber.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            n == 1
                                ? 'El dispositivo tiene 1 captura sin guardar'
                                : 'El dispositivo tiene $n capturas sin guardar',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text(
                            'Se atienden de la más antigua a la más reciente. '
                            'Ingrese los datos del paciente para generar el informe, '
                            'o elimine la captura.'),
                        const SizedBox(height: 8),
                        Wrap(spacing: 8, children: [
                          FilledButton(
                            onPressed: () => _nuevoRegistro(conservar: true),
                            child: const Text('Ingresar datos'),
                          ),
                          OutlinedButton(
                            onPressed: _confirmarEliminar,
                            child: const Text('Eliminar captura'),
                          ),
                        ]),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Text('Historial de informes',
                style: Theme.of(context).textTheme.titleMedium),
            Expanded(
              child: informes.isEmpty
                  ? const Center(child: Text('Aun no hay informes'))
                  : ListView(
                      children: informes
                          .map((f) => ListTile(
                                leading: const Icon(Icons.picture_as_pdf),
                                title: Text(f.path.split('/').last),
                                trailing: const Icon(Icons.more_vert),
                                onTap: () => menuInforme(context, f),
                              ))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistroScreen extends StatefulWidget {
  final bool conservar; // true: atender la captura pendiente más antigua
  const RegistroScreen({super.key, this.conservar = false});
  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final nombre = TextEditingController();
  final documento = TextEditingController();
  final edad = TextEditingController();
  final zona = TextEditingController();
  Future<Ubicacion?>? _ubic;

  @override
  void initState() {
    super.initState();
    _ubic = obtenerUbicacion(); // el GPS se va activando mientras se llena el formulario
  }

  @override
  Widget build(BuildContext context) {
    Widget campo(String label, TextEditingController c,
            {TextInputType tipo = TextInputType.text}) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextField(
            controller: c,
            keyboardType: tipo,
            decoration: InputDecoration(
                labelText: label, border: const OutlineInputBorder()),
          ),
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Datos del paciente')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (widget.conservar)
            Card(
              color: Colors.amber.shade100,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                    'Está atendiendo una captura guardada en el dispositivo. '
                    'Verifique que los datos correspondan a ese paciente.'),
              ),
            ),
          campo('Nombre completo', nombre),
          campo('DNI / documento', documento, tipo: TextInputType.number),
          campo('Edad', edad, tipo: TextInputType.number),
          campo('Zona de la lesion (ej. espalda, brazo)', zona),
          FilledButton(
            onPressed: () {
              if (nombre.text.trim().isEmpty || documento.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Nombre y documento son obligatorios')));
                return;
              }
              final ble = BleService.instance;
              final id = (widget.conservar && ble.idMasAntiguo > 0)
                  ? ble.idMasAntiguo
                  : null;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CapturaScreen(
                    Paciente(nombre.text.trim(), documento.text.trim(),
                        edad.text.trim(), zona.text.trim()),
                    idObjetivo: id,
                    ubicacion: _ubic,
                  ),
                ),
              );
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }
}

class CapturaScreen extends StatefulWidget {
  final Paciente paciente;
  final int? idObjetivo; // null: esperar una captura nueva
  final Future<Ubicacion?>? ubicacion;
  const CapturaScreen(this.paciente,
      {super.key, this.idObjetivo, this.ubicacion});
  @override
  State<CapturaScreen> createState() => _CapturaScreenState();
}

class _CapturaScreenState extends State<CapturaScreen> {
  final ble = BleService.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.idObjetivo != null) {
        ble.pedirRegistro(widget.idObjetivo!);
      } else {
        ble.iniciarEspera();
      }
    });
  }

  @override
  void dispose() {
    ble.detenerEspera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Captura: ${widget.paciente.nombre}')),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          ble.medicion,
          ble.completo,
          ble.progreso,
          ble.errorTransferencia,
        ]),
        builder: (context, _) {
          final m = ble.medicion.value;
          final error = ble.errorTransferencia.value;

          if (m.prob == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (error.isEmpty) const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      error.isNotEmpty
                          ? error
                          : (widget.idObjetivo != null
                              ? 'Recuperando la captura #${widget.idObjetivo} del dispositivo...'
                              : 'Esperando la captura del dispositivo...'),
                      textAlign: TextAlign.center,
                    ),
                    if (error.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(spacing: 8, children: [
                        OutlinedButton(
                            onPressed: ble.conectar,
                            child: const Text('Reconectar')),
                        FilledButton(
                          onPressed: () => ble.pedirRegistro(
                              widget.idObjetivo ?? ble.idActual),
                          child: const Text('Reintentar'),
                        ),
                      ]),
                    ],
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: ble.simularResultado,
                      child: const Text('Modo prueba: simular resultado'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (ble.idActual > 0)
                Text('Captura del dispositivo #${ble.idActual}',
                    style: Theme.of(context).textTheme.labelLarge),
              if (ble.progreso.value.isNotEmpty) ...[
                const SizedBox(height: 8),
                const LinearProgressIndicator(),
                const SizedBox(height: 4),
                Text(ble.progreso.value),
              ],
              if (error.isNotEmpty)
                Card(
                  color: Colors.red.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(error),
                        const SizedBox(height: 8),
                        Wrap(spacing: 8, children: [
                          OutlinedButton(
                              onPressed: ble.conectar,
                              child: const Text('Reconectar')),
                          FilledButton(
                            onPressed: () => ble.pedirRegistro(
                                widget.idObjetivo ?? ble.idActual),
                            child: const Text('Reintentar'),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: _img(m.foto, 'Imagen capturada')),
                const SizedBox(width: 8),
                Expanded(child: _img(m.grad, 'Grad-CAM')),
              ]),
              const SizedBox(height: 16),
              Text(
                  'Probabilidad de melanoma: ${((m.prob ?? 0) * 100).toStringAsFixed(1)} %',
                  style: Theme.of(context).textTheme.titleMedium),
              Text('Confianza: ${((m.conf ?? 0) * 100).toStringAsFixed(1)} %'),
              const SizedBox(height: 8),
              Text(recomendacion(m)),
              const SizedBox(height: 20),
              const Text(
                  '¿La imagen corresponde al lunar completo y a la zona correcta?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              FilledButton.icon(
                icon: const Icon(Icons.check),
                label: Text(ble.completo.value
                    ? 'Si, confirmar y generar PDF'
                    : 'Esperando imágenes completas...'),
                onPressed: ble.completo.value ? () => _confirmar(m) : null,
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: const Text('No, eliminar foto del dispositivo'),
                onPressed: _eliminar,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _img(Uint8List? bytes, String titulo) => Column(children: [
        Text(titulo),
        const SizedBox(height: 4),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: bytes != null
              ? Image.memory(bytes, fit: BoxFit.contain)
              : const Center(child: Text('Sin imagen')),
        ),
      ]);

  // Foto incorrecta: NO se genera PDF, se borra esa captura del ESP32.
  Future<void> _eliminar() async {
    await ble.eliminarEnDispositivo();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Captura eliminada del dispositivo.')));
    Navigator.popUntil(context, (r) => r.isFirst);
  }

  // Foto correcta: se genera el PDF, queda en el historial y se puede
  // compartir / guardar en Archivos.
  Future<void> _confirmar(Medicion m) async {
    final id = ble.idActual;
    final ubic = await (widget.ubicacion ?? Future<Ubicacion?>.value(null))
        .timeout(const Duration(seconds: 25), onTimeout: () => null);
    final nota = widget.idObjetivo != null
        ? 'Ubicacion registrada al procesar una captura pendiente; puede diferir del lugar de la captura.'
        : 'Ubicacion registrada al iniciar el registro del paciente.';
    final archivo = await generarPdf(
        widget.paciente, m, id, perfilActual.value, ubic, nota);
    await ble.marcarGuardado();
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Informe generado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('El PDF quedó guardado en el historial de la app.'),
            const SizedBox(height: 8),
            ListTile(
              dense: true,
              leading: const Icon(Icons.visibility),
              title: const Text('Ver PDF'),
              onTap: () => verPdf(context, archivo),
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.save_alt),
              title: const Text('Guardar en Archivos'),
              onTap: () => guardarPdfEnArchivos(context, archivo),
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.share),
              title: const Text('Compartir'),
              onTap: () => SharePlus.instance.share(ShareParams(files: [XFile(archivo.path)])),
            ),
            // La subida a la nube se implementa en una etapa posterior (Firebase).
            const ListTile(
              dense: true,
              enabled: false,
              leading: Icon(Icons.cloud_upload_outlined),
              title: Text('Subir a la nube (próxima etapa)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
    if (mounted) Navigator.popUntil(context, (r) => r.isFirst);
  }
}
