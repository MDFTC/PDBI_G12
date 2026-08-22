# Problemática

La insuficiencia cardíaca ocurre cuando el corazón no puede bombear la sangre de manera adecuada. Cuando el corazón, especialmente el lado izquierdo, no logra recibir y expulsar correctamente la sangre que viene de los pulmones, esta comienza a acumularse en los vasos sanguíneos pulmonares. Como consecuencia, aumenta la presión dentro de estos vasos y parte del líquido de la sangre puede pasar hacia el tejido pulmonar. Esta acumulación de líquido se conoce como congestión pulmonar y puede dificultar progresivamente la respiración.
La congestión pulmonar es especialmente preocupante porque no siempre desaparece por completo después del tratamiento. En un estudio realizado en 1,572 pacientes hospitalizados por insuficiencia cardíaca aguda, el 28,7 % todavía presentaba una congestión importante después de siete días de hospitalización o al momento del alta, mientras que el 47,8 % presentaba una congestión leve. [1]
Además, esta congestión residual está relacionada con una mayor probabilidad de que el paciente vuelva a enfermar. Los pacientes que mantenían una congestión importante presentaron un 88 % más riesgo de ser rehospitalizados por insuficiencia cardíaca durante los siguientes 60 días y un 54 % más riesgo de mortalidad durante los siguientes 180 días. [1]
Esta problemática también representa una carga importante para el sistema de salud peruano. Entre 2018 y 2023 se registraron 38,931 atenciones hospitalarias por insuficiencia cardíaca en el Perú, y estas aumentaron aproximadamente 2.78 % cada año. [2]
Por ello, uno de los principales retos es identificar oportunamente la acumulación de líquido en los pulmones antes de que progrese y provoque una nueva descompensación o una hospitalización.

## Referencias IEEE
[1] https://pubmed.ncbi.nlm.nih.gov/29544928/
[2] https://pubmed.ncbi.nlm.nih.gov/39828110/

## Propuesta
### Sistema para el Monitoreo No Invasivo de la Congestión Pulmonar

El proyecto propone desarrollar un dispositivo no invasivo y de uso continuo, colocado sobre el tórax del paciente, que permita monitorear cambios relacionados con la acumulación de líquido en los pulmones en personas con insuficiencia cardíaca.
El dispositivo utilizará principalmente bioimpedancia torácica, mediante electrodos colocados sobre la piel. Se aplicará una corriente alterna de muy baja intensidad que es percibido como un cosquilleo (0,5 mA a 50 kHz como referencia inicial) y se medirá cómo responde el tejido del tórax. Debido a que los líquidos corporales conducen la electricidad mejor que el aire, los cambios en la cantidad de líquido presente en el tórax pueden producir variaciones en la impedancia medida.
Para mejorar la interpretación de esta señal, el sistema también incorporará frecuencia respiratoria, frecuencia cardíaca y movimiento/postura. Estas variables permitirán distinguir cambios asociados a la congestión de aquellos producidos por actividades normales como caminar, cambiar de posición o modificar la respiración.
Finalmente, los datos serán procesados para establecer el estado basal de cada paciente y detectar cambios persistentes respecto a ese comportamiento normal. El objetivo no será diagnosticar directamente un edema pulmonar, sino identificar tempranamente cambios que puedan indicar un aumento de la congestión y generar una alerta para una posterior evaluación médica.
