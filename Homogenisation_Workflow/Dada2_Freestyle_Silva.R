
setwd("~/Downloads/")
library(dada2)
##modified from https://benjjneb.github.io/dada2/assign.html
seqs = read.table("NA_Kingdom_seq_nohead.csv", header = TRUE, sep = ",")
seqs[is.na(seqs)] <- 0
seqs_c <- as.data.frame(seqs)

#assign taxonomy
taxa <- assignTaxonomy(seqs_c, "/Users/name/Downloads/silva_nr99_v138_wSpecies_train_set.fa.gz", multithread=TRUE)

NA_Kingdom_seq_nohead <- as.data.frame(taxa)
sum(is.na(NA_Kingdom_seq_nohead$Kingdom)) 
write.csv(as.data.frame(NA_Kingdom_seq_nohead), file="NA_Kingdom_seq_nohead_annotated.csv")
