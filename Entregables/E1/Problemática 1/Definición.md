# Problemática
El cáncer de piel se clasifica principalmente en cáncer de piel no melanoma y melanoma cutáneo. Aunque el melanoma representa una menor cantidad de casos, presenta mayor capacidad de invasión y diseminación. Según GLOBOCAN 2022, se estimaron 331 722 nuevos casos y 58 667 muertes por melanoma a nivel mundial [1]. El melanoma puede presentarse como una lesión nueva o desarrollarse a partir de un nevo melanocítico (lunar), por lo que diferenciar lesiones benignas de lesiones sospechosas constituye un desafío importante.

La evaluación mediante imágenes permite analizar características como asimetría, bordes, color, tamaño y textura. Como complemento, el infrarrojo cercano (NIR, Near-Infrared) permite estudiar las propiedades ópticas del tejido mediante la iluminación de la lesión y el análisis de la radiación reflejada. Estudios de imagen multiespectral han utilizado regiones visible y NIR para diferenciar melanomas y nevos, demostrando que la información espectral puede aportar características adicionales a la imagen convencional [2].

Por otro lado, el infrarrojo térmico (IR) permite estimar la temperatura superficial de la piel a partir de la radiación térmica emitida. La termografía ha sido investigada como técnica complementaria para estudiar lesiones relacionadas con melanoma; sin embargo, su sensibilidad depende de características como el tamaño de la lesión, por lo que no debe considerarse un método diagnóstico independiente [3].

Por ello, este proyecto propone desarrollar un sistema multimodal que combine imágenes RGB, reflectancia NIR y medición térmica IR. La información obtenida será procesada mediante técnicas de procesamiento de imágenes y aprendizaje automático para evaluar si la combinación de estas modalidades mejora la diferenciación entre nevos benignos y melanomas respecto al uso exclusivo de imágenes.

Para el entrenamiento inicial del modelo se podría utilizar el ISIC Archive, que proporciona imágenes de lesiones cutáneas con diagnósticos asociados. Posteriormente, los datos NIR y térmicos podrían obtenerse experimentalmente con el prototipo, permitiendo estudiar la utilidad de estas variables como información complementaria.

## Referencias IEEE

[1] International Agency for Research on Cancer, Global Cancer Observatory: Melanoma of Skin, GLOBOCAN 2022. Lyon, France: IARC/WHO, 2024. GLOBOCAN 2022 – Melanoma of skin

[2] L. Rey-Barroso et al., “Visible and Extended Near-Infrared Multispectral Imaging for Skin Cancer Diagnosis,” Sensors, vol. 18, no. 5, p. 1441, 2018, doi: 10.3390/s18051441. Artículo en PubMed

[3] A. L. Shada et al., “Infrared thermography of cutaneous melanoma metastases,” Journal of Surgical Research, vol. 182, no. 1, pp. e9–e14, 2013, doi: 10.1016/j.jss.2012.09.022. Artículo en PubMed

[4] International Skin Imaging Collaboration, ISIC Archive. ISIC Archive

## Propuesta
### Sistema multimodal portátil para la caracterización de lesiones melanocíticas mediante imágenes RGB, infrarrojo cercano (NIR) y termografía infrarroja

La propuesta consiste en desarrollar un prototipo portátil y no invasivo capaz de adquirir diferentes tipos de información de una lesión cutánea, principalmente nevos (lunares) y melanomas. El sistema combinará una cámara RGB, un sistema de infrarrojo cercano (NIR) y un sensor infrarrojo térmico (IR).

La finalidad es determinar si la incorporación de información óptica y térmica permite obtener características adicionales a las observadas en una fotografía convencional y, posteriormente, utilizar estas características en un modelo de aprendizaje automático para diferenciar lesiones benignas de lesiones sospechosas.
- Cámara RGB: La imagen permite analizar características visibles como: Asimetría, Bordes, Color, Distribución del pigmento, Tamaño, Forma, Textura
- NIR: En lugar de solamente tomar una fotografía, el dispositivo ilumina la lesión con luz NIR y mide la radiación que regresa.
- IR térmico: El cuerpo emite radiación infrarroja debido a su temperatura, y el sensor puede utilizar esa radiación para estimar la temperatura superficial.

(https://pubmed.ncbi.nlm.nih.gov/23043862/)
(https://www.journalofsurgicalresearch.com/article/S0022-4804(12)00823-2/abstract)
(https://opg.optica.org/abstract.cfm?URI=Cancer-2016-JTu3A.26)
(https://pmc.ncbi.nlm.nih.gov/articles/PMC11329730/)
(https://pmc.ncbi.nlm.nih.gov/articles/PMC5982599/pdf/sensors-18-01441.pdf)
(https://pubmed.ncbi.nlm.nih.gov/10843103/)
(https://iopscience.iop.org/article/10.1088/0031-9155/45/5/312)
