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
## Convertir a binario la tabla de OTU's
otus<-as.data.frame(otu_table(suelo))
otu_bin <- decostand(otus, method="pa") 
otu_bin_phylo <- otu_table(otu_bin, taxa_are_rows = T)
## Nuevo objeto phyloseq con la tabla OTU en binario y las tablas de taxa y sample del pyloseq original
suelo_bin <- merge_phyloseq(otu_bin_phylo, suelo@tax_table, suelo@sam_data)
## Graficar diversidad alfa con tabla binaria
p_bin <- plot_bar(suelo_bin, "Host", fill = "Phylum") +
  geom_bar(aes(color=Phylum, fill=Phylum), stat="identity", position = "stack" )
q_bin <- p_bin + facet_wrap("Treatment")
q_bin


## ïndices de diversidad: Observada y Fisher
diversidad <- estimate_richness(suelo_bin, measures = c("Observed", "Fisher"))
data <- cbind(sample_data(suelo), diversidad)

## Anova de diversidad alfa observada de dos vías: tratamiento y hospedero
anova <- aov(Observed ~ Host * Treatment, data = data)
anova
hospedero <- boxplot(Observed ~ Host, data = data)
tratamiento <- boxplot(Observed ~ Treatment, data = data)

## Análisis de diversidad Beta

# Distancia de Bray para calcular disimilitud
bray <- distance(suelo_bin, method = "bray")
# Ordinación basada en la distanxia Bray con método NMDS


