# Proyecto de Biodiseño 1
**<p align="center">
¡Bienvenidos al repositorio del grupo 12 de Proyectos de Biodiseño 1!**
</p>

# Conoce a nuestro equipo

<p align="center"> 
 
| Cargo | Apellidos y nombres | 
|-------|---------------------|
| Modelador en 3D | Angie Xiomara Huánuco Vásquez |
| Electrónica | Angel Gabriel Morales Mayanga |
| Programador | Carlos Andres Ramos Guzmán |
| Investigación y Redacción| Aniball Harnaldo Panta Navarro |
| Gestor de Repositorio de GitHub | Micaela de Fátima Tassara Camarena  |

</p>

<p align="center">
  <img src="Images/IMG-20260822-WA0020.jpg" width="500">
</p>

## 2. Problemática

El melanoma cutáneo constituye una problemática relevante de salud debido a su capacidad de progresión y a la importancia de su identificación oportuna. En el Perú, según las estimaciones del Global Cancer Observatory para el año 2024, se registraron aproximadamente 1 965 nuevos casos de melanoma y 356 defunciones asociadas a esta enfermedad [1]. Estas cifras evidencian la necesidad de fortalecer las estrategias de evaluación y seguimiento de lesiones cutáneas sospechosas.

La importancia de una evaluación temprana se refleja en las diferencias de supervivencia según la extensión de la enfermedad. De acuerdo con la American Cancer Society, la supervivencia relativa a cinco años supera el 99 % cuando el melanoma se encuentra localizado, disminuye al 76 % cuando existe propagación regional y alcanza el 36 % ante metástasis a distancia [2]. Esta variación resalta la relevancia de identificar oportunamente lesiones que requieran valoración especializada.

En el contexto peruano, el acceso a una atención dermatológica oportuna puede ser limitado, lo que dificulta la evaluación temprana de lesiones cutáneas. El estudio de Ziegler-Rodriguez et al., realizado en 1136 pacientes con melanoma en el Perú, reportó que el 77.7% residía fuera de las áreas metropolitanas [3]. Esta distribución pone de manifiesto la necesidad de considerar herramientas que puedan facilitar la evaluación inicial de lesiones cutáneas en contextos donde la atención especializada puede no encontrarse disponible de manera inmediata.

Asimismo, la diferenciación entre lesiones melanocíticas benignas y lesiones potencialmente sospechosas puede resultar compleja durante una evaluación inicial, especialmente cuando esta se realiza sin la participación directa de un especialista en dermatología. En este escenario, el uso de imágenes digitales estandarizadas y técnicas de aprendizaje automático representa una alternativa de investigación para analizar patrones visuales de las lesiones y brindar información complementaria al personal de salud.

De esta manera, el proyecto pretende contribuir al desarrollo de una herramienta tecnológica accesible para la evaluación preliminar de lesiones cutáneas, sin reemplazar el diagnóstico médico ni la confirmación especializada, que continuará siendo responsabilidad del profesional de dermatología.


## 3. Estado del arte

### 3.1 Artículos académicos
- Multimodal skin lesion classification for early cancer diagnosis using deep learning
  - El artículo presenta un sistema inteligente capaz de analizar fotografías convencionales de la piel para detectar señales tempranas de cáncer con una efectividad cercana al 98%, utilizando la técnica Grad-CAM para ofrecer explicabilidad visual mediante mapas de calor. Además, establece una hoja de ruta metodológica estructurada por etapas que sirve como guía sólida para diseñar la arquitectura de un nuevo sistema de desarrollo. Para más detalles, puedes consultar la fuente original del artículo [4].
</p>

<p align="center">
  <img width="623" height="270" alt="image" src="https://github.com/user-attachments/assets/161cf156-4f93-46c9-ad13-c4958bd73313" width="300" >
</p>

- Comprehensive analysis of clinical images contributions for melanoma classification using convolutional neural networks
  - El estudio evalúa la efectividad de entrenar un sistema inteligente para identificar melanoma usando fotos convencionales frente a imágenes dermatoscópicas, encontrando que estas últimas permiten un diagnóstico muy superior. No obstante, concluye que la limitación no radica en el modelo matemático, sino en la baja calidad (enfoque, luz y aumento) de las fotos clínicas tradicionales, sugiriendo que un protocolo de captura adecuado para cámaras convencionales ofrecería una base sólida de análisis [5].
</p>
<p align="center">
  <img width="661" height="335" alt="image" src="https://github.com/user-attachments/assets/ea5c018e-0081-400c-8581-4269ed31b4ab" width="300" >
</p>

- Active Versus Passive Infrared Thermography for Skin Cancer Detection
  - El estudio demuestra cómo la termografía activa facilita la detección del cáncer de piel mediante un estímulo frío que reduce temporalmente su temperatura basal. La sospecha de malignidad se determina si la lesión se recalienta al menos 0.70 °C más que el tejido sano circundante, aportando además la velocidad de recuperación térmica —impulsada por la angiogénesis tumoral— como una métrica clave basada en el tiempo de respuesta para el proyecto [6].
</p>
<p align="center">
  <img width="627" height="341" alt="image" src="https://github.com/user-attachments/assets/b4914aac-d093-4e93-ae21-e80b4e157bfa" width="300" >
</p>

- A heatmap-based deep learning framework for multi-modal registration of VIS, NIR, and thermal images in dermatological imaging
  - El estudio propone un modelo de inteligencia artificial para alinear geométricamente imágenes visibles, infrarrojas cercanas (NIR) y térmicas de una misma lesión cutánea, combinando la captura de color y bordes externos de la luz visible, la estructura profunda expuesta por el espectro NIR y las variaciones de temperatura ligadas al flujo sanguíneo captadas por la termografía. A través de la detección automática de puntos clave, el sistema supera a los métodos tradicionales de alineamiento y demuestra que la correspondencia entre imágenes visibles e infrarrojas es más precisa que con las térmicas debido a los bordes difusos de estas últimas. Además de aportar la primera base de datos pública tri-modal, esta investigación ofrece una referencia técnica directa para el prototipo al brindar estrategias prácticas para el recorte automático de la región de interés y la reducción de ruido en el análisis multimodal [7].

</p>
<p align="center">
  <img width="541" height="521" alt="image" src="https://github.com/user-attachments/assets/535c48dd-ff1c-4dfd-b2e7-74a6eb58a13f" width="300" >
</p>

### 3.2 Patentes
- Imaging Skin Cancer Detection Device
  - Esta patente describe un dispositivo portátil que combina fotografía superficial e iluminación subcutánea mediante emisores de luz (visibles e infrarrojos) dispuestos alrededor de una estructura cónica opaca; al proyectar luz fuera de la boquilla, esta se dispersa dentro del tejido e ilumina la lesión desde adentro, permitiendo que una cámara (que puede ser de un smartphone) capture la estructura interna, profundidad y oximetría del tumor. Su principal aporte a nuestro proyecto radica en el uso de iluminación perimetral para revelar cromóforos profundos y vascularización, demostrando cómo adaptadores de bajo costo para cámaras móviles pueden capturar capas de información interna de la piel de forma no invasiva [8].

</p>
<p align="center">
  <img width="516" height="338" alt="image" src="https://github.com/user-attachments/assets/2691d0de-4c2b-4d1f-aec9-0bb7395120f4" width="300" >
</p>

- Smartphone-based multispectral dermascope
  - Esta patente detalla un dermatoscopio portátil de bajo costo que se conecta a un dispositivo móvil para ilumina la piel con diferentes colores de luz (visibles e infrarrojos) y calcular automáticamente la concentración de componentes clave como la melanina. El invento se relaciona directamente con el proyecto al demostrar que es técnicamente factible integrar iluminación de varios tipos y sensores de imagen compactos en una unidad portátil, ejecutando procesamiento automático para extraer información fisiológica de las manchas y ayudar en la caracterización de lesiones de forma rápida [9].


### 3.3 Revistas y catálogos
Lista de componentes que se usarán para el desarrollo del prototipo:

<p align="center">
  <b>ESP32-S3-CAM-OV3660</b><br>
  <img width="206" height="202" alt="ESP32-S3-CAM-OV3660" src="https://github.com/user-attachments/assets/676968ba-0b71-4a99-8a79-7a2f9c047f5b" /><br>
  <b>Descripción y funcionamiento:</b> Microcontrolador principal con módulo de cámara y conectividad Wi-Fi/Bluetooth integrada. Encargado del procesamiento central del sistema, el control de periféricos, la captura de imágenes de las lesiones cutáneas y la transmisión inalámbrica de datos hacia la aplicación móvil [10].
</p>


<p align="center">
  <b>Lector de memoria Micro SD Card 74LVC125A</b><br>
  <img width="280" height="202" alt="Lector de memoria Micro SD Card 74LVC125A" src="https://github.com/user-attachments/assets/5c7d9bcc-751f-4ab4-82eb-feba13a8e08e" /><br>
  <b>Descripción y funcionamiento:</b> Módulo de almacenamiento masivo con adaptador de niveles lógicos. Permite guardar de manera local y segura las fotografías capturadas junto con los datos de las lesiones en una tarjeta MicroSD para su posterior respaldo o descarga sin requerir conexión a internet [13].
</p>


<p align="center">
  <b>Módulo TP4056</b><br>
  <img width="181" height="220" alt="Módulo TP4056" src="https://github.com/user-attachments/assets/96cd25f8-1b12-423c-a19c-b57e41abc5a8" /><br>
  <b>Descripción y funcionamiento:</b> Sistema de gestión de carga para baterías de litio con circuito de protección integrado. Regula la recarga segura de la batería del dispositivo a través de una entrada USB, protegiéndola contra sobrecargas, sobredescargas y cortocircuitos [14].
</p>


<p align="center">
  <b>Módulo LED RGB WS2812B</b><br>
  <img width="210" height="143" alt="Módulo LED RGB WS2812B" src="https://github.com/user-attachments/assets/9ffeeaff-6394-4002-923a-960da2c3d4d1" /><br>
  <b>Descripción y funcionamiento:</b> Iluminación LED direccionable y programable. Proporciona una luz blanca y estandarizada sobre la zona de interés para garantizar la consistencia en la toma de fotos, además de actuar como indicador luminoso del estado del dispositivo [15].
</p>


<p align="center">
  <b>Display LCD TFT 2.4" SPI táctil</b><br>
  <img width="245" height="145" alt="Display LCD TFT 2.4 SPI táctil" src="https://github.com/user-attachments/assets/14172031-c7cf-4e4e-a593-4805c35e63a4" /><br>
  <b>Descripción y funcionamiento:</b> Pantalla de interfaz de usuario con panel táctil. Permite la visualización en tiempo real de la imagen capturada por la cámara, así como la navegación e interacción con las opciones del sistema mediante menús en pantalla [16].
</p>


<p align="center">
  <b>Batería de LiPo (3.7 V / 5000 mAh)</b><br>
  <img width="282" height="200" alt="Batería de LiPo (3.7 V / 5000 mAh)" src="https://github.com/user-attachments/assets/8a704ca1-eeb0-43f7-9c8a-6ea203bf4d42" /><br>
  <b>Descripción y funcionamiento:</b> Fuente de alimentación portátil de alta densidad energética. Suministra energía eléctrica continua a todo el sistema electrónico para permitir el funcionamiento autónomo del prototipo durante jornadas prolongadas en campo [17].
</p>


### 3.4 Páginas de fabricantes
* **HEINE iC1 Dermatoscope – HEINE Optotechnik:** Es un equipo portátil de dermatoscopía digital que utiliza lentes de gran aumento, iluminación uniforme y conexión a teléfonos inteligentes para capturar imágenes detalladas de la piel. Ofrece la capacidad de cambiar entre luz normal y luz polarizada para eliminar el brillo de la piel, además de un diseño ergonómico y fácil de sujetar. El prototipo integraría esta misma idea de dispositivo manual y maniobrable, ofreciendo una captura clara en alta resolución e iluminación controlada para examinar la superficie de las lesiones en el canal visible [18].

* **Sistemas de dermatoscopía digital Visiomed – Canfield Scientific:** Es una línea de cámaras dermatológicas de alta precisión diseñadas para tomar fotos estandarizadas de la piel y gestionarlas mediante programas informáticos especializados. Incluyen sistemas para calibrar el color y la intensidad de la luz con el fin de garantizar que las imágenes tomadas en distintas fechas sean idénticas. El dispositivo propuesto adoptaría esta función de estandarización y almacenamiento ordenado de datos, asegurando que las fotografías tomadas en los diferentes canales de luz mantengan siempre la misma calidad para comparar la evolución del paciente [19].

* **Cámara termográfica infrarroja Optris PI 450i – Optris GmbH:** Es una cámara térmica de tamaño reducido que mide el calor con gran sensibilidad, capturando variaciones de temperatura menores a medio grado en tiempo real y dentro del rango de temperatura del cuerpo humano. El proyecto busca replicar esta funcionalidad de lectura de calor, permitiendo que el prototipo identifique zonas con mayor flujo sanguíneo o inflamación a través del canal térmico para detectar firmas de calor inusuales en la piel [20].

---

## 4. Lista de Exigencias

En esta sección se establecen los requisitos y exigencias que deberá cumplir la solución propuesta.

## Lista de exigencias

| Categoría | Tipo | Exigencia / Descripción |
|---|:---:|---|
| **Función principal** | E | Analizar características de una posible lesión mediante IA embebida y enviar el resultado a una aplicación móvil mediante Bluetooth. |
| **Funciones secundarias** | D | Recolectar diferenciales térmicos IR y de reflectancia NIR para la base de datos. |
| | D | Almacenar datos para su descarga posterior. |
| | E | Controlar la iluminación y distancia a la piel mediante un diseño ergonómico. |
| **Geometría** | E | Dimensiones máximas de 150 × 120 × 80 mm y peso máximo de 250 g. |
| **Fuerza** | D | Resistir caídas accidentales sin fracturas ni desalineación de los sensores. |
| | E | Resistir la presión de contacto con la piel sin deformarse. |
| **Materia** | E | Utilizar materiales resistentes, lavables y biocompatibles para el contacto indirecto con la piel. |
| **Energía** | E | Alimentación continua mediante batería accesible. |
| | D | Batería recargable para uso sin conexión eléctrica. |
| **Señales** | E | Obtener imágenes de calidad y estandarizables. |
| | D | Capturar la reflectancia NIR para comparar lesiones y piel sana. |
| | D | Capturar la temperatura para comparar lesiones y piel sana. |
| **Control de usuario** | E | Visualizar cambios y estados del dispositivo y la aplicación. |
| | D | Capacitar al usuario en el uso del dispositivo y la aplicación. |
| **Hardware** | E | Hardware adecuado para obtener imágenes analizables. |
| | D | Hardware adecuado para medir reflectancia y temperatura. |
| **Software** | E | Programa de código abierto para controlar el sistema e interpretar las señales. |
| | D | Mantenimiento y actualización del código para mejorar su rendimiento. |
| | E | Aplicación intuitiva con funciones básicas para el dispositivo. |
| **Inteligencia Artificial** | E | IA implementada mediante código abierto. |
| | E | Entrenamiento y evaluación con bases de datos públicas y etiquetadas. |
| **Comunicaciones** | E | Comunicación cableada entre controlador, sensores y actuadores mediante PCB. |
| | E | Procesamiento adecuado de señales para generar resultados. |
| | E | Conexión Bluetooth con la aplicación, sin necesidad de Internet. |
| **Seguridad** | E | Protección contra cortocircuitos. |
| | D | Materiales en contacto con la piel biocompatibles según ISO. |
| **Ergonomía** | D | Uso y manipulación con una sola mano. |
| **Fabricación** | D | Fabricación reproducible mediante impresión 3D y hardware accesible. |
| **Transporte** | D | Resistencia al transporte y fijación segura de los sensores. |
| **Mantenimiento** | D | Boquilla distal extraíble e intercambiable para desinfección. |
| | D | Limpieza del lente de la cámara después de cada uso. |
| **Costos** | D | Costo máximo del prototipo: S/ 500, sin incluir horas-hombre. |
| **Plazos** | E | Desarrollo, fabricación, entrenamiento y ensamblaje en un máximo de 4 meses. |

---

## 5. Estructura de Funciones Óptima

### 5.1 Black Box

Se presenta la representación de la caja negra del sistema, identificando las entradas, procesos y salidas principales.
</p>

<p align="center">
  <img src="Funciones/Caja negra.png" width="500">
</p>

La caja negra se divide en dos principales bloques del wearable y de la aplicación móvil.
</p>

<p align="center">
  <img src="Funciones/Caja negra específica.png" width="500">
</p>

### 5.2 Secuencia de operaciones

Se describe la secuencia de operaciones que debe realizar el sistema para cumplir con su función principal.
</p>

<p align="center">
  <img src="Funciones/Secuencia de operaciones.png" width="500">
</p>

### 5.3 Estructura de funciones

Se presenta la descomposición de la función principal en funciones parciales y sus relaciones.
</p>

<p align="center">
  <img src="Funciones/Funciones (3).png" width="500">
</p>
Se clasifica el esquema de funciones en el bloque del wearable.

</p>

<p align="center">
  <img src="Funciones/Funciones (4).png" width="500">
</p>

Se clasifica el esquema de funciones en el bloque de la aplicación móvil.
</p>

<p align="center">
  <img src="Funciones/Esquema de funciones aplicación.png" width="500">
</p>
---

## 6. Gantt

Se presenta el cronograma de actividades del proyecto mediante un diagrama de Gantt.

| Actividad | Inicio | Fin | Estado |
|---|---|---|---|
| Problemática y necesidades | 21/08/2026 | 22/08/2026 | Completado |
| Estado del arte | 21/08/2026 | 04/09/2026 | Completado |
| Marco teórico | 22/08/2026 | 04/09/2026 | Completado |
| Lista de exigencias | 28/08/2026 | 05/09/2026 | Completado |
| Estructura de funciones | 04/09/2026 | 11/09/2026 | Completado |
| Matriz morfológica | 11/09/2026 | 12/09/2026 | En proceso |
| Presentación y sustentación H1 | 17/09/2026 | 19/09/2026 | Pendiente |
| Correcciones H1 | 20/09/2026 | 26/09/2026 | Pendiente |

---

## 7. Referencias

[1] International Agency for Research on Cancer, Global Cancer Observatory: Cancer Today — Peru, Lyon, France: IARC, 2024. https://gco.iarc.who.int/media/globocan/factsheets/populations/604-peru-fact-sheet.pdf

[2] American Cancer Society, “Tasas de supervivencia para el cáncer de piel tipo melanoma por etapas,” 2026. https://www.cancer.org/content/dam/CRC/PDF/Public/9931.00.pdf

[3] G. Ziegler-Rodriguez et al., “Melanoma in Peru: 1000 patients and 10 years of experience,” PLoS ONE, vol. 20, no. 10, 2025, Art. no. e0323636. https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0323636

[3] G. Ziegler-Rodriguez et al., “Melanoma in Peru: 1000 patients and 10 years of experience,” PLoS ONE, vol. 20, no. 10, 2025, Art. no. e0323636. https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0323636[cite: 1]

[4] V. Gabani, T. M. Navamani, K. Shyamala, and V. K. V. Rajpal, "Multimodal skin lesion classification for early cancer diagnosis using deep learning," Front. Physiol., vol. 17, art. no. 1717517, Feb. 2026, doi: 10.3389/fphys.2026.1717517.

[5] J. A. Rios-Duarte, A. C. Diaz-Valencia, G. Combariza, M. Feles, and R. A. Peña-Silva, "Comprehensive analysis of clinical images contributions for melanoma classification using convolutional neural networks," Skin Res. Technol., vol. 30, no. 5, art. no. e13607, May 2024, doi: 10.1111/srt.13607. 

[6] F. Malheiros et al., "Active versus passive infrared thermography for skin cancer detection: A diagnostic accuracy study," Cancers, vol. 18, no. 5, art. no. 829, Mar. 2026, doi: 10.3390/cancers18050829. 

[7] M. Oniga et al., "A heatmap-based deep learning framework for multi-modal registration of VIS, NIR, and thermal images in dermatological imaging," Front. Artif. Intell., vol. 9, art. no. 1807482, May 2026, doi: 10.3389/frai.2026.1807482

[8] Gabani, V., Navamani, T. M., Shyamala, K., & Rajpal, V. K. V. (2026b). Multimodal skin lesion classification for early cancer diagnosis using deep learning. Frontiers in Physiology, 17, 1717517. https://doi.org/10.3389/fphys.2026.1717517

[9] R. Uthoff and R. Liang, "Smartphone-based multispectral dermascope," U.S. Patent 12 376 786, 2025.

[10] ESP32-S3 AIOT Camera Development Board, integrated audio input and output module, supports connecting external display, image capture & recognition and AI Speech Interaction support | ESP32-S3-CAM-OV5640. (n.d.-b). https://www.waveshare.com/esp32-s3-cam-ov5640.htm?srsltid=AU7gw4UVk0EGLa6DnyXBswOguPKZSEBjClJdSKNWe9ZlD_zBmsKOOton 

[11] Raspberry Pi Ltd., "Raspberry Pi 3 Model B," Raspberry Pi Products. [En línea]. Disponible en: raspberrypi.com. [Accedido: 19-sep-2026]. 

[12] Raspberry Pi Camera v2 - Sony 8Mpx. (n.d.). Naylamp Mechatronics - Perú. https://naylampmechatronics.com/raspberry-pi/277-camara-v2-raspberry-pi-sony-8mpx.html 

[13] Módulo lector de memoria Micro SD Card - SPI. (n.d.). Naylamp Mechatronics - Perú. https://naylampmechatronics.com/almacenamiento/104-modulo-lector-de-memoria-micro-sd-card-lvc125a.html 

[14] Módulo TP4056 - Cargador de batería litio USB-C con protección. (n.d.). Naylamp Mechatronics - Perú. https://naylampmechatronics.com/baterias/867-cargador-de-bateria-litio-tp4056-con-proteccion-usb-c.html 

[15] Módulo LED RGB WS2812B. (n.d.). Naylamp Mechatronics - Perú. https://naylampmechatronics.com/luces-iluminacion/1073-modulo-led-rgb-ws2812b.html 

[16] Display LCD TFT 2.4" SPI táctil. (n.d.). Naylamp Mechatronics - Perú. https://naylampmechatronics.com/lcd-color/144-display-lcd-tft-2pulg-rgb-spi-240x320-tactil.html 

[17] Mercado Libre. (n.d.). https://www.mercadolibre.com.pe/bateria-recargable-polimero-de-litio--lipo--37v-5000mah/up/MPEU2462794576 

[18] HEINE Optotechnik, "HEINE iC1 Dermatoscope," HEINE Shop US. Accessed: Sep. 19, 2026. [Online]. Available: https://shop.heine.com/us-en/HEINE-iC1-Dermatoscope/235235

[19] Visiomed | Canfield Scientific. (n.d.). https://www.canfieldsci.com/imaging-systems/categories/visiomed/ 

[20] International. (n.d.). Non-Contact Infrared Fever Screening for Post-Pandemic public health archives. https://optris.com/application/pharmaceutical-medical/non-contact-infrared-thermography-for-fever-screening-in-post-pandemic-public-health-strategy/ 

[21] D. R. P. Cupu, N. Syamza, and M. E. U. R. Indonesia, “Design of disc on disc wear test equipment using VDI 2221 method,” Journal of Ocean Mechanical and Aerospace -science and Engineering- (JOMAse), vol. 65, no. 3, pp. 100–106, Nov. 2021, doi: 10.36842/jomase.v65i3.255. 

[22] J. Gausemeier and S. Moehringer, “VDI 2206- A new guideline for the design of mechatronic systems,” IFAC Proceedings Volumes, vol. 35, no. 2, pp. 785–790, Dec. 2002, doi: 10.1016/s1474-6670(17)34035-1.
