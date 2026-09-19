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

Se presentan artículos científicos relacionados con la problemática y las soluciones existentes.

### 3.2 Patentes

Se presentan patentes relacionadas con las tecnologías y soluciones existentes para abordar la problemática.

### 3.3 Revistas y catálogos

Se revisan revistas, catálogos y otras fuentes especializadas relacionadas con las soluciones existentes en el mercado.

### 3.4 Páginas de fabricantes

Se presentan productos y soluciones desarrolladas por fabricantes relacionados con la problemática.

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

