# Commands, scripts and comments relative to Homogenisation workflow

## Step 1:
* Removal of sequences with clustering similarity id < 80%:
```
awk -F ";" '!/^ASV_/ {print$0} ; /^ASV_/ {if($i>=80) print$0}' ASV_file1.csv > ASV_file2.csv
```

* Removal of multicellular taxa:
```
grep -v "Metazoa" ASV_file2.csv | grep -v "Streptophyta" | grep -v "Florideophyceae" | grep -v "Bangiophyceae" | grep -v "Phaeophyceae" | grep -v "Ulvophyceae" > ASV_file3.csv
```

Removal of sediment samples for BioMarKs.

Homogenisation of sample names and column headers:
```
awk -F ";" -v OFS=";" 'NR==1 {gsub("ASV", "Sequence", $i) ; print$0} ; /^ASV_/ {gsub("ASV_", "ASV_Dataset_") ; print$0}' ASV_file3.csv > ASV_file4.csv
awk -F ";" 'NR==1 {gsub("query", "ASV") ; gsub("sequence","Sequence") ; print$0} ; /^ASV_/ {print$0}' ASV_file4.csv > ASV_filt.csv
```

Creation of sub-files: from ASV_filt.csv => taxTable.csv (ASV_tax), ASVTable.csv (ASV_sample-abundance), Dataset.fasta (fasta)
```
# Example for taxTable
awk -F ";" 'NR==1 {for (i=0;i<=NF;i++) {if($i=="V1_pr2") print$i";"i}}' ASV_filt.csv
awk -F ";" 'NR==1 {for (i=0;i<=NF;i++) {if($i=="V8_pr2") print$i";"i}}' ASV_filt.csv
cut -d";" -f1,329-336 ASV_filt.csv > Dataset_taxTable.csv

# Fasta
cut -d";" -f1,3 ASV_filt.csv | awk -F ";" 'NR>1 {print">"$1"\n"$2}' > Dataset.fasta
```

Unassigned sequences were counted before proceeding to a novel taxonomic assignment by taking into accounts affiliations marked as "NA", "_X" and "_sp".

Undefined taxonomic ranks were taken annotated as "_X" to avoid any bias in counting unassigned sequences (i.e. annotated as "Unknown"): 
```
awk -F ";" '!/^ASV_/ {print$0} ; /^ASV_/ {for (i=1;i<NF;i++) {if($i!="Unknown" && $(i-1)=="Unknown")  $(i-1)=$i"_X"} {OFS=FS} ; print$0}' Dataset_taxTable.csv | awk -F ";" '!/^ASV_/ {print$0} ; /^ASV_/ {for (i=1;i<NF;i++) {if($i!="Unknown" && $(i-1)=="Unknown")  $(i-1)=$i"_X"} {OFS=FS} ; print$0}' > Dataset_taxTable2.csv
```

## Step 2:
* PR2 taxonomic assignment:

Version: pr2_version_4.12.0_18S_taxo_long.fasta

Scripts: mkdb_PR2.sh, PR2_blast.sh

Best hits were kept: 
```
awk '!x[$1]++' FS="\t" Dataset.blast.out > Dataset_blast_top_hit
awk -F "\t" '/^ASV/ {gsub("\t",";") ; print$0}' Dataset_blast_top_hit > Dataset_blast_top_hit.csv
```

ASV names were merged with their blast best hit with the script: merge_table.py
Via the command:
```
sbatch launch_short_working_script.sh merge_table.py -f1 ASV_names.csv -f2 Dataset_blast_top_hit.csv -cn ASV
```

Headers were added to names and top hit files before hand:
```
sed -i '1iASV;GenBank_id|rRNA|nucleus|Kingdom|Supergroup|Division|Class|Order|Family|Genus|Species' Dataset_blast_top_hit.csv
sed -i '1iASV' ASV_names.csv
```

## Step 3:
* Removal of sequences with length < 200 bp:
```
awk -F ";" 'NR==1 {print$0} ; NR>1 && length($i)>200 {print$0}' ASV_filt_PR2.csv > ASV_filt_PR2_f200.csv
```

## Step 4:
* SILVA taxonomic assignemnt of sequences unasssigned at the Kingdom level:

Vesrion: silva_nr99_v138_wSpecies_train_set.fa.gz

Scripts: Dada2_Freestyle.R

Sequences to be assigned were selected and linearised:
```
awk -F ";" '/^ASV_/ && $2=="Unknown" {print">"$1"\n"$11}' ASV_filt_PR2_f200.csv > ASV_NA_Kingdom.fa
awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' ASV_NA_Kingdom.fa > ASV_NA_Kingdom_lin.fa
```

The assignment and occurence (dataset and depth) of the sequences was studied (cf. Normalisation_Alpha_div_Abund.Rmd).

### All scripts and analysis were performed on ABiMS cluster of the Roscoff Marine station (http://abims.sb-roscoff.fr).
