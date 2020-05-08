# Metagenómica
### Miguel Amaro, Mayo 2020

Este repositorio contiene el script `amptk.sh`, el cual ejecuta AMPtk para analizar 24 muestras de suelo rizosférico tanto de bosque nativo y bosque mixto de *Quercus* y *Juniperus*. 
En la carpeta `data` se encuentra el output final de la corrida, el cual consiste en una tabla de OTU's en formato `.biom` la cual se usará posteriormente para realizar análisis de diversidad. La tabla contiene a las OTU's con su frecuencia por muestra, su taxonomía, así como sus metadatos asociados.

## Resultados al corer min_length de 200 bp

El script realizado para esta tarea, consideró una longitud mínima de las secuencias de 200 bp durante el paso de procesamiento para retener las secuencias. Esto causó que el número de OTU's obtenido al final del análisis fuera de **1,536**. En comparación, durante el tutorial realizado en clase, la longitud mínima considerada fue de 300 bp, con lo cual se obtuvo un total de **258** OTU's. 

Como puede observarse, la selección de la longitud mínima tiene un alto impacto en los niveles de diversidad que se obtienen durante el análisis. En este aspecto es importante tener en cuenta que fijar el tamaño mínimo a la longitud esperada de las secuencias puede conllevar a la pérdida de diversidad, ya que se filtrarían muchas secuencias de longitud menor debido a aspectos como la calidad de la lectura. 
