##### Script para realizar los análisis de diversidad en las muestras de suelo.
##### Miguel Amaro, May 2020

library(vegan)
library(phyloseq)
library(ggplot2)


## Cargar datos (tabla biom obtenida de AMPtk)
suelo <- import_biom("../data/taxonomy.biom")
head(tax_table((suelo)))
## Cambiar nombres de la tabla de taxonomía
colnames(tax_table(suelo)) <- c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species")
## Contar número de reads por muestra
no.reads <- sort(sample_sums(suelo))

## Graficar diversidad alfa a nivel Phylum con reads.
p <- plot_bar(suelo, "Host", fill = "Phylum") +
  geom_bar(aes(color=Phylum, fill=Phylum), stat="identity", position = "stack" )
q <- p + facet_wrap("Treatment")
q
dir.create("../out")
ggsave("../out/alfa_reads.png", q)
## Convertir a binario la tabla de OTU's
otus<-as.data.frame(otu_table(suelo))
otu_bin <- decostand(otus, method="pa") 
otu_bin_phylo <- otu_table(otu_bin, taxa_are_rows = T)

## Nuevo objeto phyloseq con la tabla OTU en binario y las tablas de taxa y sample del pyloseq original
suelo_bin <- merge_phyloseq(otu_bin_phylo, suelo@tax_table, suelo@sam_data)
## Graficar diversidad alfa con tabla binaria.
p_bin <- plot_bar(suelo_bin, "Host", fill = "Phylum") +
  geom_bar(aes(color=Phylum, fill=Phylum), stat="identity", position = "stack" )
q_bin <- p_bin + facet_wrap("Treatment")
q_bin
ggsave("../out/alfa_bin.png", q_bin)

## Índices de diversidad: Observada y Fisher
diversidad <- estimate_richness(suelo_bin, measures = c("Observed", "Fisher"))
## Unir las columnas de diversidad a la tabla de sample del objeto suelo en un nuevo objeto
data <- cbind(sample_data(suelo), diversidad)

## Anova de diversidad alfa observada de dos vías: tratamiento y hospedero
anova <- aov(Observed ~ Host * Treatment, data = data)
anova
hospedero <- boxplot(Observed ~ Host, data = data)
tratamiento <- boxplot(Observed ~ Treatment, data = data)
ambos <- boxplot(Observed ~ Treatment * Host, data = data)

## Análisis de diversidad Beta

# Distancia de Raup-Crick para calcular disimilitud
raup <- distance(suelo_bin, method = "raup")
# Ordinación basada en la distanxia Raup-Crick con método NMDS
NMDS <- ordinate(suelo_bin, method = "NMDS", color="Host", shape="Treatment")
# Graficar ordinación
r <- plot_ordination(suelo_bin, NMDS, color = "Host") +
  geom_point(size=3)
s <- r + facet_wrap("Treatment")
ggsave("../out/ordination.png", s)
## Análisis ADONIS
adns_treat <- adonis(raup ~ Treatment,  data = data)
adns_treat
adns_host <- adonis(raup ~ Host,  data = data)
adns_host
adns_twoway <- adonis(raup ~ Host * Treatment,  data = data)
adns_twoway
