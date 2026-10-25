1. **Introducción al tema**  
   El melanoma es el cáncer de piel más agresivo, y en Perú presenta una tendencia claramente creciente: los casos registrados por el INEN pasaron de 439 en el año 2000 a 592 en 2011 \[1\], y las cifras más recientes confirman que la enfermedad sigue en aumento, con 898 muertes en 2025 y 339 fallecimientos sólo en lo que va de 2026, incluyendo un incremento notorio en personas jóvenes \[2\].  
   El problema principal no es solo la incidencia, sino lo tarde que se diagnostica. Un estudio del INEN sobre más de mil pacientes encontró que casi el 60% llegó en estadio III o IV, cuando el cáncer ya se había diseminado, mientras que solo 16.5% fue detectado en estadio I. Como consecuencia, apenas el 36% de los pacientes sobrevive cinco años después del diagnóstico \[3\]. Los propios investigadores señalan que esto refleja una desigualdad estructural del sistema de salud, no solo un problema médico \[3\].  
   Esta desigualdad tiene dos causas que afectan especialmente a la población de provincia:  
   Mayor exposición al riesgo: La radiación UV en el Perú es de las más altas del mundo, y se intensifica con la altitud. En zonas andinas como Junín, Cusco, Puno y Arequipa se han registrado índices UV "extremos" (hasta 18-20 puntos), muy por encima del nivel considerado peligroso \[4\].  
   Menor acceso a especialistas: Alrededor del 60% de los médicos especialistas del país ejerce en Lima \[5\], dejando a las regiones más expuestas al sol con muy poca cobertura dermatológica. Piura, por ejemplo, solo cuenta con 12 dermatólogos para toda la región \[6\].  
2. **Antecedentes**  
   El melanoma constituye un problema relevante en Perú. Un estudio realizado con 1000 pacientes atendidos durante 10 años encontró una mayor proporción de casos en estadios avanzados y peores resultados de supervivencia respecto a reportes internacionales, evidenciando la necesidad de mejorar la detección oportuna \[7\].  
     
   El seguimiento digital de lesiones melanocíticas se ha estudiado como estrategia para detectar cambios a lo largo del tiempo. Se analizaron 52 739 lesiones y encontraron que la probabilidad de detectar melanoma durante la vigilancia aumentaba con la duración del seguimiento \[8\].  
     
   Asimismo, se demostró que el seguimiento dermatoscópico tanto a corto como a largo plazo puede contribuir a detectar melanomas en pacientes con múltiples nevos atípicos \[9\].  
     
   La International Dermoscopy Society recomienda el monitoreo digital mediante fotografía corporal y dermatoscopia en pacientes seleccionados con múltiples nevos, debido a que la comparación de imágenes permite identificar cambios y reducir extirpaciones innecesarias \[10\].  
     
   Estos antecedentes sustentan la propuesta de desarrollar un dispositivo portátil que permita registrar una lesión periódicamente y comparar su evolución, incorporando además información NIR e IR térmica.  
     
3. **Tecnologías y metodologías utilizadas:**  
     
   **Imagen RGB**  
   Las imágenes RGB permiten registrar la apariencia visible de la lesión y analizar características como forma, asimetría, bordes, color, tamaño y textura. El seguimiento mediante imágenes permite además identificar cambios morfológicos a través del tiempo \[8\], \[9\].  
     
   **Infrarrojo cercano (NIR)**  
   El NIR permite iluminar la lesión con radiación cercana al infrarrojo y analizar la radiación reflejada o retrodispersada por el tejido. Rey-Barroso et al. utilizaron imágenes multiespectrales visible-NIR para obtener información adicional sobre las propiedades ópticas de las lesiones cutáneas \[11\].  
     
   **Infrarrojo térmico (IR)**  
   El IR térmico permite estimar la temperatura superficial de la piel a partir de la radiación infrarroja emitida. Shada et al. estudiaron la termografía en lesiones relacionadas con melanoma y encontraron que su sensibilidad dependía considerablemente del tamaño de la lesión \[12\].  
     
   **Aprendizaje automático**  
   Los modelos de aprendizaje automático y deep learning permiten analizar imágenes y clasificarlas según características asociadas a lesiones benignas o malignas. Un metaanálisis de 27 estudios encontró una sensibilidad agrupada del 82 %, especificidad del 87 % y AUC de 0.92 para modelos de deep learning aplicados a imágenes dermatoscopías \[13\].

4. **Resultados principales:**  
   Los estudios muestran que el seguimiento temporal puede mejorar la detección de cambios sospechosos en lesiones melanocíticas \[8\], \[9\].  
     
   La imagen NIR ha demostrado aportar información espectral adicional a la imagen visible. En el estudio de Rey-Barroso et al., la combinación de información visible y NIR permitió diferenciar melanomas y nevos mediante técnicas de análisis multiespectral \[11\].  
     
   La termografía IR puede proporcionar información complementaria relacionada con la temperatura de las lesiones, aunque su rendimiento disminuye considerablemente en lesiones pequeñas \[12\].  
     
   Finalmente, los modelos de deep learning han mostrado un alto potencial para la clasificación automática de lesiones, aunque todavía requieren validación clínica y datasets más diversos \[13\].  
 


5. **Comparación de estudios:**  
     
   

| Estudio  | Tecnología | Principal aporte  | Ventaja  | Limitación  |
| :---: | :---: | :---: | :---: | :---: |
| **Salerni *et al.* \[7\]** | Dermatoscopia digital  | Seguimiento temporal  | Detecta cambios progresivos  | Requiere seguimiento  |
| **Moscarella *et al.* \[8\]**  | Dermatoscopia  | Seguimiento corto y largo  | Detecta melanomas durante vigilancia  | Requiere especialista  |
| **Russo *et al.* \[9\]**  | Fotografía \+ dermatoscopia  | Protocolos de monitoreo  | Reduce extirpaciones innecesarias  | Aplicación limitada a determinados pacientes  |
| **Rey-Barroso *et al.* \[10\]**  | RGB \+ NIR  | Información espectral  | Aporta información adicional  | Requiere sistema especializado  |
| **Shada *et al.* \[11\]**  | IR térmico  | Diferencias térmicas  | No invasivo y sin contacto  | Sensibilidad depende del tamaño  |
| **Ye *et al.* \[12\]**  | Deep Learning  | Clasificación automática  | Alto potencial diagnóstico  | Requiere grandes datasets  |

   

   En conjunto, los estudios sugieren que ninguna modalidad debe considerarse suficiente por sí sola. La propuesta busca combinar información visual, óptica, térmica y temporal para evaluar si su integración mejora la estimación del riesgo. 

   

6. **Limitaciones:**  
     
* **RGB:** Depende de iluminación, enfoque, distancia y condiciones de captura.  
* **Seguimiento digital:** Requiere mediciones repetidas y generalmente personal especializado \[8\]–\[10\].  
* **NIR:** Los sistemas estudiados utilizan cámaras y fuentes de iluminación especializadas, lo que dificulta desarrollar dispositivos económicos \[11\].  
* **IR térmico:** Su sensibilidad puede ser baja en lesiones pequeñas y las mediciones pueden verse afectadas por las condiciones ambientales \[12\].  
* **IA:** Los resultados obtenidos en datasets controlados no garantizan el mismo rendimiento en pacientes reales; se necesitan datasets grandes, diversos y validación clínica \[13\].  
* **Principal limitación:** Existen pocos conjuntos de datos que combinen RGB \+ NIR \+ IR térmico \+ seguimiento temporal \+ diagnóstico confirmado. Por ello, tu propuesta tiene que generar o recopilar progresivamente los datos NIR y térmicos del prototipo.

7. **Brecha de investigación:**  
   A pesar de los avances en el análisis de lesiones melanocíticas mediante imágenes RGB, imágenes multiespectrales/NIR y termografía infrarroja, la mayoría de los estudios emplea estas modalidades de manera independiente o en sistemas especializados. Además, existen limitaciones relacionadas con el tamaño de los conjuntos de datos, la variabilidad de las condiciones de adquisición y la dificultad para obtener información multimodal de una misma lesión a lo largo del tiempo.  
   Por ello, existe una oportunidad de investigación en el desarrollo de un sistema portátil que integre simultáneamente información morfológica (RGB), óptica (NIR) y térmica (IR) y que permita analizar los cambios de una lesión mediante mediciones sucesivas. La principal brecha no consiste simplemente en "detectar melanoma con un nuevo sensor", sino en determinar si la combinación de estas modalidades y su evolución temporal proporciona información adicional para la evaluación del riesgo de una lesión melanocítica.  
8. **Innovación:**  
   El proyecto busca abordar esta brecha mediante el desarrollo de un dispositivo portátil multimodal que integre una cámara RGB, un sistema de iluminación y detección NIR y un sensor de temperatura infrarroja. El dispositivo permitirá obtener diferentes características de una misma lesión y registrarlas en una aplicación para construir un historial de mediciones.  
   Posteriormente, las características obtenidas como cambios en tamaño, forma, color, respuesta NIR y temperatura podrán ser integradas mediante un modelo de Machine Learning para estimar el nivel de riesgo de la lesión. De esta manera, el proyecto no busca reemplazar el diagnóstico dermatológico, sino proporcionar una herramienta complementaria para identificar cambios potencialmente relevantes y apoyar la decisión de realizar una evaluación especializada.  
9. **Referencias :**   
- \[1\] "Cáncer de piel y radiación solar: experiencia peruana en la prevención y detección temprana del cáncer de piel y melanoma," *Rev. Peru. Med. Exp. Salud Publica* / SciELO Perú,2013. [http://www.scielo.org.pe/scielo.php?script=sci\_arttext\&pid=S1726-46342013000100021](http://www.scielo.org.pe/scielo.php?script=sci_arttext&pid=S1726-46342013000100021)  
- \[2\] Ziegler-Rodriguez G. et al., "Cáncer de piel en Perú y un dato alarmante: el melanoma se detecta tarde y reduce drásticamente la supervivencia" (estudio INEN 2010–2019, 1136 pacientes), *Infobae*, 2026\. [https://www.infobae.com/peru/2026/02/03/cancer-de-piel-en-peru-y-un-dato-alarmante-el-melanoma-se-detecta-tarde-y-reduce-drasticamente-la-supervivencia/](https://www.infobae.com/peru/2026/02/03/cancer-de-piel-en-peru-y-un-dato-alarmante-el-melanoma-se-detecta-tarde-y-reduce-drasticamente-la-supervivencia/)  
- \[3\] "Cáncer de piel en Perú: Más del 50% de los casos de melanoma son detectados en fases avanzadas," Cientifica Divulga, 2026\. [https://divulga.cientifica.edu.pe/nuestra-ciencia/cancer-de-piel-en-peru-mas-del-50-de-los-casos-de-melanoma-son-detectados-en-fases-avanzadas/](https://divulga.cientifica.edu.pe/nuestra-ciencia/cancer-de-piel-en-peru-mas-del-50-de-los-casos-de-melanoma-son-detectados-en-fases-avanzadas/)  
- \[4\] "Cáncer de piel en Perú: 339 personas fallecieron en lo que va de 2026," *La República*, 2026\. [https://larepublica.pe/sociedad/2026/06/11/](https://larepublica.pe/sociedad/2026/06/11/)  
- \[5\] "Perú tiene el índice de rayos UV más alto del mundo," *Infobae*, 2024\. [https://www.infobae.com/peru/2024/01/27/](https://www.infobae.com/peru/2024/01/27/)  
- \[6\] Senamhi, "Alerta a nivel nacional: Perú presenta niveles de radiación UV entre 'alto' y 'extremadamente alto'," 2025\. [https://www.gob.pe/institucion/senamhi/noticias/1297626](https://www.gob.pe/institucion/senamhi/noticias/1297626)  
- \[7\] G. Ziegler-Rodriguez et al., “Melanoma in Peru: 1000 patients and 10 years of experience,” PLoS ONE, vol. 20, no.10, e0323636, 2025,doi: [10.1371/journal.pone.0323636](https://doi.org/10.1371/journal.pone.0323636)  
- \[8\] G. Salerni et al., “Meta-analysis of digital dermoscopy follow-up of melanocytic skin lesions: A study on behalf of the International Dermoscopy Society,” J. Eur. Acad. Dermatol. Venereol., vol. 27, no. 7, pp. 805–814, 2013, doi: [10.1111/jdv.12032](https://doi.org/10.1111/jdv.12032)  
- \[9\] E. Moscarella et al., “Both short-term and long-term dermoscopy monitoring is useful in detecting melanoma in patients with multiple atypical nevi,” J. Eur. Acad. Dermatol. Venereol., vol. 31, no. 2, pp. 247–251, 2017, doi: [10.1111/jdv.13840](https://doi.org/10.1111/jdv.13840)  
- \[10\] T. Russo et al., “Indications for Digital Monitoring of Patients With Multiple Nevi: Recommendations from the International Dermoscopy Society,” Dermatol. Pract. Concept., vol. 12, no. 4, e2022182, 2022, doi: [10.5826/dpc.1204a182](https://doi.org/10.5826/dpc.1204a182)  
- \[11\] L. Rey-Barroso et al., “Visible and Extended Near-Infrared Multispectral Imaging for Skin Cancer Diagnosis,” Sensors, vol. 18, no. 5, p. 1441, 2018, doi: [https://doi.org/10.3390/s18051441](https://doi.org/10.3390/s18051441)   
- \[12\] A. L. Shada et al., “Infrared thermography of cutaneous melanoma metastases,” J. Surg. Res., vol. 182, no. 1, pp. e9–e14, 2013, doi: [https://doi.org/10.1016/j.jss.2012.09.022](https://doi.org/10.1016/j.jss.2012.09.022)  
- \[13\] Z. Ye et al., “Deep learning algorithms for melanoma detection using dermoscopic images: A systematic review and meta-analysis,” Artif. Intell. Med., vol. 155, p. 102934, 2024, doi: [10.1016/j.artmed.2024.102934](https://doi.org/10.1016/j.artmed.2024.102934)


