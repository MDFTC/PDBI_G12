# Dispositivo Médico de Monitoreo Térmico y Piezorresistivo Plantar Bilateral para la Detección Precoz de Microtrauma e Inflamación Tisular Pre-Ulcerosa.

---

## 1. Problemática Sanitaria

La diabetes mellitus constituye una de las epidemias no transmisibles más severas en el Perú. La pérdida de sensibilidad por **neuropatía diabética periférica**, sumada a problemas de circulación (enfermedad arterial periférica), expone a los pacientes a presiones y fricciones continuas que no sienten, degenerando en ulceraciones severas y amputaciones de extremidades inferiores.
* **Prevalencia Elevada:** Según los registros del Ministerio de Salud (Minsa), la diabetes afecta a entre el **12% y 15% de la población adulta mayor** en zonas urbanas del Perú. Entre el **15% y 25%** de estos pacientes desarrollará una úlcera plantar a lo largo de su vida.
* **Carga en EsSalud (PADOMI y Redes Asistenciales):** De acuerdo con la *Guía de Práctica Clínica para el Manejo del Pie Diabético de EsSalud*, las amputaciones no traumáticas en el Perú son causadas en un **60% a 80% de los casos por complicaciones de pie diabético**. Tratar una úlcera avanzada (etapas Wagner 2 a 5) genera costos de hospitalización y curación hasta **10 veces mayores** que la atención ambulatoria preventiva, además de requerir estancias hospitalarias prolongadas (>21 días).
* **Diagnóstico Tardío (CDC Minsa):** El Centro Nacional de Epidemiología, Prevención y Control de Enfermedades (CDC Perú - Minsa) reporta que más del **70% de los pacientes** acude al centro de salud cuando la herida ya está infectada o con necrosis, reduciendo drásticamente las posibilidades de salvamento del pie.

---

## 2. Población Objetivo

El dispositivo está priorizado para la prevención secundaria y terciaria en los siguientes grupos dentro del sistema público de salud:

1. **Pacientes Diabéticos Tipo 1 y 2 con Neuropatía Confirmada:** Usuarios adscritos a los programas de Riesgo Cardiovascular en Centros de Salud Minsa (I-3, I-4) y Hospitales I y II de EsSalud.
2. **Adultos Mayores en Programas Domiciliarios (PADOMI - EsSalud):** Pacientes con movilidad reducida o baja visión (retinopatía diabética/cataratas) que no pueden realizar una autoevaluación física diaria.
3. **Pacientes con Alto Riesgo o Antecedentes:** Personas clasificadas en grado 2 o 3 del IWGDF (*International Working Group on the Diabetic Foot*) con antecedentes de úlceras previas o deformidades estructurales (como pie de Charcot o dedos en garra).

---

## 3. ¿Qué Ayuda a Detectar y Cómo?

El dispositvo evalúa continuamente variables físicas para identificar el **Riesgo Inminente de Úlcera Plantar** semanas antes de la apertura de la herida.

### A. Fenómenos Fisiológicos Detectados:
1. **Hipertermia Inflamatoria Localizada ("Hot Spots"):** El choque de fuerzas o microtraumas profundos destruyen capilares y generan respuesta inflamatoria, elevando la temperatura de la piel entre 2.0 °C y 3.0 °C respecto a la zona simétrica del pie sano.
2. **Picos de Presión Mecánica Excesiva:** Zonas de apoyo anormal (>200 kPa) que comprometen el flujo sanguíneo tisular.
3. **Maceración por Humedad:** Ambientes internos con saturación de humedad que debilitan la epidermis frente a infecciones micóticas o bacterianas.

### B. Criterio Algorítmico de Alerta:
El sistema procesa la asimetría térmica bilateral mediante:
$$\Delta T = T_{punto_izq} - T_{punto_der}$$

Una asimetría sostenida de $\Delta T \ge 2.2 ^\circ\text{C}$ ($4^\circ\text{F}$) durante 2 días consecutivos activa la **Alerta Roja de Inflamación Pre-Ulcerosa**.

---

## 4. Dimensiones de Sensores Integrados


| Tipo de Sensor | Componente / Modelo | Ubicación en Plantilla | Dimensiones del Sensor | Función Técnica |
| :--- | :--- | :--- | :--- | :--- |
| **Arreglo Térmico (x6)** | NTC Thermistor Flexible Film (10kΩ) | 1° Metatarso, 3°/5° Metatarso, Talón, Dedo Gordo y Arco. | **Grosor:** 0.5 mm<br>**Superficie:** 3.5 mm x 1.2 mm | Mide temperatura local cutánea con precisión de 0.1 °C. |
| **Arreglo de Presión (x4)** | FlexiForce A201 (Tekscan) / FSR 402 | Cabeza de metatarsos y calcáneo. | **Grosor:** 0.208 mm (208 µm)<br>**Área activa:** 9.53 mm ∅ | Mide picos de carga mecánica (0-50 N/cm²) y pasos. |
| **Sensor de Humedad (x1)** | SHT31-DIS (Sensirion) / BME280 | Mediopié (zona central del arco). | **Grosor:** 0.9 mm<br>**Superficie:** 2.5 mm x 2.5 mm | Monitorea el microclima e hidratación interna (0-100% RH). |
| **Inercial IMU (x1)** | LSM6DSO / MPU-6050 | Talón (encapsulado rígido de control). | **Grosor:** 0.83 mm<br>**Superficie:** 2.5 mm x 3.0 mm | Identifica marcha vs. reposo para filtrar interferencias del entorno. |

---

## 5. Enlaces y Fuentes:
### A. Informacion:
1. https://iwgdfguidelines.org/wp-content/uploads/2020/11/Bus_et_al-2020-IWGDF-prevention-guideline.pdf
2. https://scielo.isciii.es/scielo.php?script=sci_arttext&pid=S0003-31702023000400006
3. https://ulceras.net/monografico/94/79/pie-diabetico-diagnostico.html
### B. Sensores:
1. https://www.electromania.pe/producto/sensor-de-temperatura-ntc-10k/
2. https://mtlab.pe/producto/sensor-de-fuerza-resistivo-fsr402-fsr406/?srsltid=AfmBOoqomRfMooTpbYqKFzB9WPKlado5quaBVPwjQf0t7SfGsxbBJeie
3. https://naylampmechatronics.com/sensores-temperatura-y-humedad/363-sensor-de-temperatura-y-humedad-relativa-sht31.html
4. https://www.electromania.pe/producto/modulo-mpu6050/
