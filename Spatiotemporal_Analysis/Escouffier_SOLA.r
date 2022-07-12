#!/usr/bin/env Rscript
#CC/SOLA: Escouffier's equivalent vectors SOLA 

#Set the working directory 
setwd("/shared/projects/formaldark/testThomas/SOLA/CC_Synd/CC_final")

#library
library(readr)
library(readxl)
library(vegan)
library(magrittr)
library(pastecs)
library(tidyr)

#Importation of the raw cleaned data, on which we will compute the Escouffier's equivalent vectors 
Escouffier_SOLA<-read.table("CC_abund_Synd_SOLA_clean.csv",
                             header=TRUE, sep=',')

#We delete the first column
Escouffier_SOLA<-Escouffier_SOLA[,-1]

#Pivot the table 
Escouffier_SOLA<-Escouffier_SOLA%>% pivot_wider(!Month & !Year& !Genus_status & !Season,names_from = "CC_id", values_from = "abundance")

#Order the dataframe in the original chronology
Escouffier_SOLA<-Escouffier_SOLA[order(Escouffier_SOLA$Sample),]


#Select the Connected Component that have at least 5 occurences    

Escouffier_SOLA_NA<-Escouffier_SOLA
#convert the 0 to Na
Escouffier_SOLA_NA[Escouffier_SOLA_NA==0] <-NA

#Compute the sum of the rows
for (i in 2:length(Escouffier_SOLA)){
  Escouffier_SOLA_NA[116,i]<-sum(!is.na(Escouffier_SOLA_NA[1:115,i]))
}
#Select the sum 
Presence_sample<-subset(Escouffier_SOLA_NA[116,])
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
Escouffier_SOLA<- Escouffier_SOLA%>% dplyr::select(all_of(ASV_sel))
#Convert to dataframe
Escouffier_SOLA<-as.data.frame(Escouffier_SOLA)


#Computation of the Escouffier's vectors
selection_escoufier_all<-pastecs::escouf(Escouffier_SOLA, level=0.75)

#Extraction of the Escouffier's vectors
selection_escoufier_all_SOLA<- pastecs::extract(selection_escoufier_all, level=0.75)

write.csv(selection_escoufier_all_SOLA,"selection_escoufier_all_SOLA.csv")

