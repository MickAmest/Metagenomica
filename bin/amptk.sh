#### Script to run AMPtk on the Ilumina MiSeq data from the cluster, using a minimum length of 200 bp
#### Miguel Amaro, May 2020

## Assemble forward and reverse reads and remove short sequences

amptk illumina -i ../../../../metagenomica/fastq/ -o amptk/ -f GTGARTCATCRARTYTTTG -r CCTSCSCTTANTDATATGC -l 300 --min_len 200 --full_length --cleanup

## Quality filter and grouping of OTU's 

amptk cluster -i amptk.demux.fq.gz -o cluster -m 2 --uchime_ref ITS

## Filter OTU's present with less than 0.005%

amptk filter -i cluster.otu_table.txt -o filter -f cluster.cluster.otus.fa -p 0.005 --min_reads_otu 2

## Assign taxonomy to each OTU

amptk taxonomy -i filter.final.txt -o taxonomy -f filter.filtered.otus.fa -m ../../../../metagenomica/amptk.mapping_file.txt -d ITS2 --tax_filter Fungi

