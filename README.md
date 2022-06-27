# Exploring the marine realm of unassigned taxonomic protist diversity: parasites in the spotlight

Exploration of taxinomically unassigned protist barcode sequences across different V4-18S datasets. 


The goal of this study is to:
* Describe the overall proportion of protist sequences which lack taxinomic description from reference databases
* Identify protist lineages that are the least described across 6 metabarcoding datasets
* Reveal geographic distribution patterns of parasitic dinoflagellates that are unassigned at the genus level (i.e. 98% of sequences!)
* Get a list of most abundant and recurrent (through 10 years data) community-indicator parasite taxa to be prioritized for identification

By:
* Homogenising diverse metabarcoding datasets (time-series and oceanographic campaigns) into a global dataset
* Clustering the sequences of the global dataset together based on similarity with a Sequence Similarity Network
* Exploring spatial and temporal distribution patterns of unassigned sequence clusters at a selected taxonomic level and for a selected protist group


## Abstract


## Data





## Prerequisites


```
code
```

## What about your protist group of interest ?

This protocol can be freely re-used to explore the spatiotemporal patterns of any protist group in the network ! The steps are the following:
* Indicate the taxonomic level and id of the group (e.g. Class==Syndiniales) in the script: this will subtract from the netwrok only the clusters (Connected Components) composed of your chosen group along with their metadata.
* Run scripts XX...


It is also possible to implement your own sequences and see how they clusterise among the SSN. Just note that a computation time of 1 week is required (job run in parallel on X nodes, CPU, RAM...) to run the all-against-all alignment with the updated sequence dataset + 1-2h for network creation by igraph. After that, you can catch up the protocol from the clusterisation step (Script: XX).


