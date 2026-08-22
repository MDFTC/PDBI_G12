# 1. Problemática
## 1.1. Contexto Global
<p align="justify">
Anualmente, aproximadamente 20 millones de personas requieren ingreso a Unidades de Cuidados Intensivos (UCI) y Ventilación Mecánica Invasiva (VMI) (Del Bono et al., 2025). Durante esta intervención, la Asincronía Paciente-Ventilador (APV) —la falta de coordinación entre los esfuerzos del paciente y el soporte de la máquina— se presenta en hasta el 80% de los casos, alcanzando un grado severo en el 35% de los pacientes (Del Bono et al., 2025). Las APV abarcan patrones complejos como el esfuerzo ineficaz, doble disparo, ciclado prematuro o retardado, disparo inverso, privación de flujo y autociclado (Murias et al., 2016).
A pesar de su frecuencia, la monitorización gráfica de las ondas de presión y flujo en la pantalla del ventilador es considerada una competencia avanzada de alta complejidad para el personal asistencial (Murias et al., 2016). En países de ingresos bajos y medianos, la tasa de detección correcta de APV por parte del personal médico es inferior al 15% (en comparación con un modesto 21% en Norteamérica) (Del Bono et al., 2025; Chelbi et al., 2024). Esta ineficiencia del personal para identificar asincronías visualmente desencadena un círculo vicioso: mayor necesidad de sedación, ventilación prolongada, daño pulmonar (barotrauma/volutrauma), aumento en días de estancia hospitalaria y una mayor mortalidad (Subirà et al., 2018; Bulleri et al., 2018).
</p>

## 1.2. Contexto Nacional
### 1.2.1. Saturación crítica en camas UCI
<p align="justify">
Datos del Repositorio Único Nacional de Información en Salud muestran que la ocupación de camas UCI para adultos alcanza el 85% a nivel nacional. En Lima, la situación es extrema: de 214 camas UCI instaladas, el 95% se encuentra ocupado, dejando únicamente 11 camas disponibles para toda la región. 

### 1.2.2. Mortalidad e impacto clínico
<p align="justify">
La mortalidad de pacientes que ingresan a UCI en el Perú alcanza el 38% (Zegarra Piérola et al., 2022), situando al índice de asincronía elevado como un factor de riesgo directo para el fallecimiento en instituciones como el Hospital Nacional Dos de Mayo (Canchari Martínez, 2024). 
  
### 1.2.3. Costo y estancia crónica
<p align="justify">
Las estancias prolongadas en UCI por mala interacción máquina-paciente derivan en cuidados intensivos de estancia crónica (Moncada Mapelli et al., 2025), costando mucho mas de lo necesario por paciente. La falta de calibración interna de parámetros ambientales (temperatura, presión barométrica y humedad) modifica el volumen entregado e incrementa picos de presión incontrolados que provocan barotrauma sin que las alarmas del ventilador lo asocien a una asincronía real.
  
# 2. Objetivos
## 2.1. Objetivo General
<p align="justify">
Diseñar e implementar un sistema embebido de bajo costo para la calibración externa de parámetros físicos, detección de asincronías mediante Machine Learning y emisión de alertas tempranas en ventiladores mecánicos, validado en un entorno de simulación  sin intervención de sujetos humanos. 
  
## 2.2. Objetivo Específico
### 2.2.1. Diseñar
<p align="justify">
Diseñar una placa PCB personalizada de bajo costo que integre etapas de acondicionamiento de señal para sensores de presión diferencial, temperatura/humedad y biopotenciales/fuerza de disparo.
  
### 2.2.2. Fabricar
<p align="justify">
Fabricar mediante impresión 3D un acople proximal tipo Venturi con bajo espacio muerto para la captura continua de ondas de flujo y presión en el circuito respiratorio.
  
### 2.2.3. Desarrollar
<p align="justify">
Desarrollar un modelo de Machine Learning para series temporales (TinyML) ejecutable en microcontrolador, capaz de clasificar patrones de APV (p. ej., esfuerzo ineficaz, doble disparo) y errores de calibración térmica.
  
### 2.2.4. Idear
<p align="justify">
Idear un módulo de actuación y alerta inteligente que active alarmas audiovisuales (buzzer + matriz LED/pantalla) ante detección de APV y accione una válvula de alivio física ante riesgo inminente de barotrauma.
  
### 2.2.5. Validar 
<p align="justify">
Validar experimentalmente el sistema en un periodo de 4 meses empleando un simulador pulmonar pasivo (modelo hidráulico con botella de agua) y un prototipo de ventilador de pruebas.
  
# 3. Propuesta
<p align="justify">
Sistema de bajo costo para la calibración externa de parámetros físicos, detección de asincronías mediante Machine Learning y emisión de alertas tempranas en ventiladores mecánicos, validado en un entorno de simulación sin intervención de sujetos humanos. 
  
## 3.1. Sensar
1. Ondas de presión y flujo proximal: Sensor conectado al tubo Venturi impreso en 3D para extraer series temporales.
2. Parámetros ambientales: Sensor para registrar la temperatura y humedad del gas, recalculando el volumen real a condiciones BTPS.
3. Esfuerzo del paciente (simulado): Pulsador analógico o sensor piezoeléctrico en la botella para registrar el momento exacto de la "inspiración" del paciente.
  
## 3.2. Procesar
<p align="justify">
Un modelo entrenado en Python y exportado mediante Edge Impulse a un microcontrolador. El modelo analiza la forma de onda de la serie temporal (presión vs. tiempo) y detecta los patrones de asincronía que el ojo humano no logra identificar con facilidad (Chelbi et al., 2024). 
  
## 3.3. Actuar
1. Sistema de alarmas inteligente: Si la PCB identifica una asincronía o una falla de calibración, activa un sistema de alerta y una pantalla que muestran el APV al personal médico en tiempo real.
2. Protección mecánica (barotrauma): Una válvula solenoide o servo-mecanismo purga inmediatamente el exceso de presión si el pito de presión supera el límite seguro antes de dañar el pulmón simulado.
  
# Referencias
1. Chelbi, R., Thabet, F., Ennouri, E., Meddeb, K., Toumi, R., Zghidi, M., Ben Saida, I., & Boussarsar, M. (2024). The Ability of Critical Care Physicians to Identify Patient-Ventilator Asynchrony Using Waveform Analysis: A National Survey. Respiratory care, 69(2), 176–183. https://doi.org/10.4187/respcare.11360
2. Subirà, C., de Haro, C., Magrans, R., Fernández, R., & Blanch, L. (2018). Minimizing Asynchronies in Mechanical Ventilation: Current and Future Trends. Respiratory care, 63(4), 464–478. https://doi.org/10.4187/respcare.05949
3. Murias, G., Lucangelo, U., & Blanch, L. (2016). Patient-ventilator asynchrony. Current opinion in critical care, 22(1), 53–59. https://doi.org/10.1097/MCC.0000000000000270
4. Bulleri, E., Fusi, C., Bambi, S., & Pisani, L. (2018). Patient-ventilator asynchronies: types, outcomes and nursing detection skills. Acta bio-medica : Atenei Parmensis, 89(7-S), 6–18. https://doi.org/10.23750/abm.v89i7-S.7737
5. Del Bono, M. R., Damiani, L. F., Plotnikow, G. A., Consalvo, S., Di Salvo, E., & Murias, G. (2025). Ineffective respiratory efforts and their potential consequences during mechanical ventilation. Medicina intensiva, 49(5), 502133. https://doi.org/10.1016/j.medine.2025.502133
6. Canchari Martinez, E. G. (2024). Índice de asincronía de ventilación mecánica invasiva elevado como factor de riesgo para mortalidad en pacientes críticos en la unidad de cuidados intensivos del Hospital Nacional Dos de Mayo periodo noviembre 2021 a abril 2022.
7. https://www.minsa.gob.pe/reunis/?niv=3&op=3&tbl=1
8. Zegarra Piérola, Jaime, Fernández Merjildo, Diana, Lévano Díaz, Lady, & Ticona Salazar, José. (2022). Ventilación mecánica en pacientes con síndrome de dificultad respiratoria aguda por la Covid-19 en una unidad de cuidados intensivos de Lima, Perú. Revista Médica Herediana, 33(2), 81-90. Epub 06 de julio de 2022.https://doi.org/10.20453/rmh.v33i2.4241
9. Moncada Mapelli E, Casanova Arias A, Echenique Martinez S. Cuidados intensivos de estancia crónica: un desafío creciente en la realidad peruana. Rev Fac Med Hum. 2025;25(1):xx-xx. doi:10.25176/RFMH.v25i4.7842
