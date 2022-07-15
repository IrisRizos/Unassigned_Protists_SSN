
## Spatial analysis, files list:
* ### Spatial_expl.Rmd : 
All the steps required for the analyses are included in the Rmarkdown document.

* ### Metadata_RDA.csv: 

The environmental parameters included in the RDA analysis.

* ### Anova_RDA.sh and Rscript_Anova_RDA.R:

The statistical significance of the Redundancy Analysis (RDA) was tested with an ANOVA at two levels, the global RDA and each RDA axis. 
For the global RDA the ANOVA was run through Rstudio and the commands are included in the Rmd lines 832-842.

For each RDA axis the computational ressources required are greater and was run with Rscript_Anova_RDA.R was run on ABiMs cluster through the bash script Anova_RDA.sh. The results of the ANOVA are pasted in the Rmd (lines 852-874).


## Temporal analysis:
