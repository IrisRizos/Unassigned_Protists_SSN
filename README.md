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
* Download the network including all protist groups: 
Folder SSN, files Split_Igraph_all_.z0 (see README of SSN folder)

* Select your target group: 
Indicate the taxonomic level and id of the group (e.g. Class==Syndiniales) in script SSN_Synd.Rmd (lines 101-109): this will subtract from the network only the clusters (Connected Components) composed of sequences of your chosen group along with their metadata.
N.b. if you are also curious about assigned / unassigned sequences at low taxonomic levels (e.g. genus) within your target group, you can further refine your cluster selection at lines 202-211.

* Spatiotemporal exploration:
Run scripts XX...


It is also possible to implement your own sequences and see how they clusterise among the SSN. Just note that a computation time of 1 week is required (job run in parallel on X nodes, CPU, RAM...) to run the all-against-all alignment with the updated sequence dataset + 1-2h for network creation by Igraph with R. After that, you can catch up the protocol from the clusterisation step (Script: XX).


