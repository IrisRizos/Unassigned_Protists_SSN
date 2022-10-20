#!/usr/bin/env Rscript
#CC/ASTAN: Escouffier's equivalent vectors ASTAN 

#Set the working directory 
setwd("path")

#library
library(readr)
library(readxl)
library(vegan)
library(magrittr)
library(dplyr)
library(pastecs)
library(tidyr)

#Importation of the raw cleaned data, on which we will compute the Escouffier's equivalent vectors 
Escouffier_ASTAN<-read.table("CC_abund_Synd_ASTAN_clean.csv",
                            header=TRUE, sep=',')

#We delete the first column
Escouffier_ASTAN<-Escouffier_ASTAN[,-1]

#Pivot the table 
Escouffier_ASTAN<-Escouffier_ASTAN%>% pivot_wider(!Month & !Year& !Genus_status & !Season,names_from = "CC_id", values_from = "abundance")

#Order the dataframe in the original chronology
Escouffier_ASTAN<-Escouffier_ASTAN[order(Escouffier_ASTAN$Sample),]


#Select the Connected Component that have at least 5 occurences

Escouffier_ASTAN_NA<-Escouffier_ASTAN
#convert the 0 to Na
Escouffier_ASTAN_NA[Escouffier_ASTAN_NA==0] <-NA

#Compute the sum of the rows
for (i in 2:length(Escouffier_ASTAN)){
  Escouffier_ASTAN_NA[375,i]<-sum(!is.na(Escouffier_ASTAN_NA[1:374,i]))
}
#Select the sum 
Presence_sample<-subset(Escouffier_ASTAN_NA[375,])
#Transpose it
Presence_sample<-t(Presence_sample)
colnames(Presence_sample)<-"Ech"
#Convert to dataframe and numeric
Presence_sample<-as.data.frame(Presence_sample)
Presence_sample$Ech<-as.numeric(Presence_sample$Ech)
#Select the CC that have at least 5 occurences
Presence_sample<-subset(Presence_sample,Presence_sample$Ech>4)
#Store the names of the selected CC
ASV_sel<-rownames(Presence_sample)

#Select the CC that are present at least 5 time
Escouffier_ASTAN<- Escouffier_ASTAN%>% dplyr::select(all_of(ASV_sel))
#Convert to dataframe
Escouffier_ASTAN<-as.data.frame(Escouffier_ASTAN)


#Computation of the Escouffier's vectors
selection_escoufier_all<-pastecs::escouf(Escouffier_ASTAN, level=0.75)
#Extraction of the Escouffier's vectors
selection_escoufier_all_utile<- pastecs::extract(selection_escoufier_all, level=0.75)

write.csv(selection_escoufier_all_utile,"selection_escoufier_all_ASTAN.csv")



