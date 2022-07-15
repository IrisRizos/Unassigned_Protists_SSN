#!/usr/bin/env Rscript
#CC/BBMO: Escouffier's equivalent vectors BBMO 

#Set the working directory 
setwd("/shared/projects/formaldark/testThomas/BBMO/CC_Synd/CC_final")

#library
library(readr)
library(readxl)
library(vegan)
library(magrittr)
library(dplyr)
library(pastecs)
library(tidyr)

#Importation of the raw cleaned data, on which we will compute the Escouffier's equivalent vectors 
Escouffier_BBMO<-read.table("CC_abund_Synd_BBMO_clean.csv",
                           header=TRUE, sep=',')

#We delete the first column
Escouffier_BBMO<-Escouffier_BBMO[,-1]

#Pivot the table 
Escouffier_BBMO<-Escouffier_BBMO%>% pivot_wider(!Month & !Year& !Genus_status & !Season,names_from = "CC_id", values_from = "abundance")

#Order the dataframe in the original chronology
Escouffier_BBMO<-Escouffier_BBMO[order(Escouffier_BBMO$Sample),]


#Select the Connected Component that have at least 5 occurences

Escouffier_BBMO_NA<-Escouffier_BBMO
#convert the 0 to Na
Escouffier_BBMO_NA[Escouffier_BBMO_NA==0] <-NA

#Compute the sum of the rows
for (i in 2:length(Escouffier_BBMO)){
  Escouffier_BBMO_NA[321,i]<-sum(!is.na(Escouffier_BBMO_NA[1:320,i]))
}
#Select the sum 
Presence_sample<-subset(Escouffier_BBMO_NA[321,])
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
Escouffier_BBMO<- Escouffier_BBMO%>% dplyr::select(all_of(ASV_sel))
#Convert to dataframe
Escouffier_BBMO<-as.data.frame(Escouffier_BBMO)


#Computation of the Escouffier's vectors 
selection_escoufier_all<-pastecs::escouf(Escouffier_BBMO, level=0.75)

#Extraction of the Escouffier's vectors
selection_escoufier_all_utile<- pastecs::extract(selection_escoufier_all, level=0.75)

write.csv(selection_escoufier_all_utile,"selection_escoufier_all_BBMO.csv")



