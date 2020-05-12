# Metagenómica
### Miguel Amaro, Mayo 2020

Este repositorio contiene el script `amptk.sh`, el cual ejecuta AMPtk para analizar 24 muestras de suelo rizosférico tanto de bosque nativo y bosque mixto de *Quercus* y *Juniperus*. 
En la carpeta `data` se encuentra el output final de la corrida, el cual consiste en una tabla de OTU's en formato `.biom` la cual se usará posteriormente para realizar análisis de diversidad. La tabla contiene a las OTU's con su frecuencia por muestra, su taxonomía, así como sus metadatos asociados.

## Resultados al corer min_length de 200 bp

El script realizado para esta tarea, consideró una longitud mínima de las secuencias de 200 bp durante el paso de procesamiento para retener las secuencias. Esto causó que el número de OTU's obtenido al final del análisis fuera de **1,536**. En comparación, durante el tutorial realizado en clase, la longitud mínima considerada fue de 300 bp, con lo cual se obtuvo un total de **258** OTU's. 

Como puede observarse, la selección de la longitud mínima tiene un alto impacto en los niveles de diversidad que se obtienen durante el análisis. En este aspecto es importante tener en cuenta que fijar el tamaño mínimo a la longitud esperada de las secuencias puede conllevar a la pérdida de diversidad, ya que se filtrarían muchas secuencias de longitud menor debido a aspectos como la calidad de la lectura. 

## Análisis de diversidad y composición de especies.

De acuerdo con las gráficas de diversidad, se observa que tanto en bosques nativos y mixtos, los Phyla predominantes son los Ascomycota y Basidiomycota. Sin embargo, en bosques mixtos se observa una mayor proporción de Ascomycota en el hospedero *Quercus* comparado con *Juniperus*, así como de algunos Phyla menor representados, como Chytrodiomycota y Zoopagomycota. Sin embargo, de acuerdo con los ANOVA realizados, las diferencias en los niveles de diversidad no son significativas para ningún efecto, es decir ni entre hospederos ni entre tratamientos.

En cuanto a las diferencias en la composición, la ordinacin NMDS reveló que hay una mayor agrupamiento por hospedero en los casos nativos, mientras que este agrupamiento fue menos claro en los mixtos. Sin embargo, ninguno de estos efectos fue significativo individualmente, y las diferencias solo fueron significativos cuando se consideraron ambos efectos combinados en el análisis Adonis.


