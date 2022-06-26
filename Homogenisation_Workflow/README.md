# Commands, scripts and comments relative to Homogenisation workflow

Step 1:
* Removal of sequences with clustering similarity id < 80%:
```
awk -F ";" '!/^ASV_/ {print$0} ; /^ASV_/ {if($i>=80) print$0}' ASV_file1.csv > ASV_file2.csv

```

* Removal of multicellular taxa
```
grep -v "Metazoa" ASV_file2.csv | grep -v "Streptophyta" | grep -v "Florideophyceae" | grep -v "Bangiophyceae" | grep -v "Phaeophyceae" | grep -v "Ulvophyceae" > ASV_file3.csv
```
