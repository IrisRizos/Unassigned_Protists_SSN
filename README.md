# Exploring the marine realm of unassigned taxonomic protist diversity: parasites in the spotlight

Exploration of taxinomically unassigned protist genetic barcode sequences across different V4-18S datasets. 


The goal of this study is to:
* Describe the overall proportion of protist sequences which lack taxinomic assignment in PR2 reference database
* Identify protist lineages that are the least described across 6 metabarcoding datasets (including open-sea campaigns and coastal time-series)
* Reveal wide scale geographic distribution patterns of parasitic dinoflagellates (i.e. Syndiniales) that are unassigned at the genus level (i.e. 98% of Syndiniales sequences!)
* Highlight a list of recurrent (through at least 7 years of data) community-indicator parasite taxa to be prioritized for identification

By:
* Integrating diverse metabarcoding datasets into a global dataset with an homogenised taxonomy
* Clustering the gathered metabarcode sequences together based on sequence similarity with a Sequence Similarity Network, allowing to adress integrated ecological ascpects of clusters at low taxonomic resolution independent of their lack of taxonomic assignment
* Exploring spatial and temporal patterns of unassigned sequence clusters at a selected taxonomic level and for a selected protist group


## Abstract

Marine protists are major components of the oceanic microbiome that remain largely unrepresented in culture collections and genomic reference databases. The exploration of this uncharted protist diversity in oceanic communities relies essentially on the study of genetic markers as taxonomic barcodes. Nevertheless, we report that across 6 environmental planktonic surveys, ½ of genetic barcodes remain taxonomically unassigned at the genus level, limiting the understanding of the ecological implications of many protist lineages. Among them, parasitic Dinoflagellata (i.e. Syndiniales) appear as the least described protist group while being key actors in marine food webs at a global scale. We have developed a FAIR computational workflow integrating diverse metabarcoding datasets, in order to infer large scale ecological patterns at a fine-grained taxonomic resolution, bypassing the limitation of taxonomic assignment. We reveal novel geographic distribution patterns for unassigned Syndiniales genera including sequences shared between disconnected marine photic zones and ubiquitous Syndiniales sequences. From a temporal aspect, we have pinpointed recurrent and seasonally persistent parasite taxa that are also indicative of community dynamics, withholding a potential for ecosystem monitoring. Our results underline the importance of Syndiniales in structuring planktonic communities through space and time, raising questions regarding host-parasite association specificity and the trophic mode of persistent Syndiniales, while providing an innovative framework for prioritizing unassigned protist taxa for further description.


## Datasets

### Open Sea Campaigns:
* Malaspina Circumnavigation Expedition (2010-2011): Tropical/Subtropical Ocean, https://aslopubs.onlinelibrary.wiley.com/doi/10.1002/lob.10008


* MOOSE (2017, 2018): West Mediterranean, https://www.moose-network.fr

### Coastal European Sampling Project:
* BioMarKs - Biodiversity of Marine euKaryotes (2009-2010): https://www.biodiversa.org/122

### Time-series:
* ASTAN (2009-2016): https://www.sb-roscoff.fr/fr/observation/presentation/perimetre-d-etudes/somlit-astan, Roscoff, France

* SOLA (2007-2015): https://www.somlit.fr/banyuls/, Banyuls-sur-Mer, France

* BBMO (2004-2013): http://bbmo.icm.csic.es, Blanes Bay, Spain


## Prerequisites

### Data
Below are listed the data needed to re-run analysis included in this study. The README of each folder will guide you to the adequate scripts.
* Global homogenised V4-18S metabarcode dataset (343,165 OTUs): 
/Homogenisation workflow/ASV_all_18SV4_6MetaB.zip


* Syndiniales network (4,317 CCs): 
/SSN/Split_Igraph_Synd_id100_cov80.z01-3


### Computational ressources
* ABiMs cluster: http://abims.sb-roscoff.fr/resources/cluster


* ABiMs Rstudio instance: http://abims.sb-roscoff.fr/resources/tools

Demanding computations:
* All-against-all blast: 100 job parallelisation, computation time of 1 week

* ANOVA on each axis of RDA: 4 CPUs, mem 50GB

* Escoufier's equivalent vectors: 8-16 CPUs, mem 40-100GB

* Lomb-Scargle Periodogram algorithm: 8 CPUs, mem 70GB

## What about your protist group of interest ?

This protocol can be freely re-used to explore the spatiotemporal patterns of any protist group ! The steps are the following:
* ### Download the network including all protist groups: 


Folder SSN, files Split_Igraph_all_.z0 (see README of SSN folder)


* ### Select your target protist group: 

Indicate the taxonomic level and id of the group (e.g. Class==Syndiniales) in script SSN_Synd.Rmd (lines 101-109): this will subtract from the network only the clusters (Connected Components) composed of sequences of your chosen group along with their metadata.
N.b. if you are also curious about assigned / unassigned sequences at low taxonomic levels (e.g. genus) within your target group, you can further refine your cluster selection at lines 202-211.

* ### Spatiotemporal exploration:

After selecting clusters of your target protist group:
For spatial analysis run script /Spatiotemporal Analysis/Spatial_expl.Rmd

For temporal analysis follow guidelines of the /Spatiotemporal Analysis/ folder.

* ### V4-18S sequence implementation:

It is also possible to implement your own sequences and see how they clusterise among the SSN. Just note that a computation time of 1 week is required to run the all-against-all alignment with the updated sequence dataset + 1-2h for network creation by Igraph with R. After that, you can catch up the protocol from the network clusterisation step (Script: SSN_Synd.Rmd, line 68).


