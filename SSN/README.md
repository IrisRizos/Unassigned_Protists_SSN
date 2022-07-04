# Sequence Similarity Network creation and extraction of Syndiniales Connected Components

A sequence Similarity Network is composed of sequences (network nodes) connected by their similarity % (network edges). It's input is the pairwise alignments of all-against-all blast of the sequences among our global dataset. Below are listed the steps of SSN creation and filtration.

## * Database creation:
```
makeblastdb -in Sequences.fasta -dbtype nucl -out SSN_db
```

The headers of sequences were modified to include abundance information so that it could retrieved later on in the network by calling a specific node.
This information was retrieved with an awk script.

```
#! /usr/bin/awk -f
#
# Each field of line 1 is assigned a name
# Each field of line > 1 is assigned a value
# For each ASV is printed its number and its abundance value in a sample (if > 0)

BEGIN { FS="," }
NR==1 { split($0,names,",")}
NR >1 { split($0,values,",");
     for (i=2; i <=NF; i++){
     if (values[i]>0 && values[i]!="NA") {print values[1]";"names[i]";"values[i]}
}
```

* All-against-all blast:

The blast was run by Atomic Blast+, an implementation of NCBI blast+ algorithm that is optimised for handling big files by splitting and parallelising jobs. The run took 1 week.

```
atomicblastplus.py -p blastn -i Sequences.fasta -o <output folder> -d SSN_db -n 1000 -m @gmail.com -e 1e-4 -c 100 --verbose --send_mails
```

-n: number of sequences per sub-file, intermediary files are concatenated by default at the end of the run
-c: number of running arrays


* Filtration of pairwise alignments:

Similarity threshold:
```
awk -F"\t" '/^ASV/ {if($3==100.00) print$0}' SSN.tab > SSN_filt1.tab
```

Removal of self-hits (A<->A):
```
awk -F"\t" '/^ASV/ {if($1!=$2) print$0}' SSN_filt1.tab > SSN_filt2.tab
```

Remove of multiple hits (A<->B, B<->A):
```
srun filter.py
```

Remove alignments with a coverage <80%:

Calculate coverage:
```
srun python filter_blast.py -b <blast-file> -f <fasta-file>
```

Filter:
```
awk -F"\t" '/^ASV/ {if($13>=80.00 && $14>=80.00) print$0}' SSN_filt3.tab > SSN_filt4.tab
```

* Network creation by Igraph in R: SSN_Synd.Rmd
Nodes are clustered in Connected Components (CCs) according to similarity threshold. Isolated nodes are removed.
CCs are filtered by taxonomy to select only clusters containing sequences assigmed to the Syndiniales order.
These clusters were further splitted into sequences with and without (i.e. unassigned) an affiliation at the genus level.

* Network creation output for downstream analysis: Syndiniales CCs: Split_.z0

This is a compressed R object (RDS file). To open it with R, first download the splitted compressed files and merge files in a single zip before unzipping:

```
zip -F Split_Igraph_Synd_id100_cov80.zip --out Igraph_Synd_id100_cov80.RDS.zip 
```

