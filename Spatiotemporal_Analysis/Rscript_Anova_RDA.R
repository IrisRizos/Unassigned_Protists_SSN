rda <- readRDS("RDA_Synd_Med_Trop.RDS")

library(vegan)

anova.cca(rda, by="axis", model="direct", step=1000, cutoff=1, parallel = getOption("mc.cores"))
