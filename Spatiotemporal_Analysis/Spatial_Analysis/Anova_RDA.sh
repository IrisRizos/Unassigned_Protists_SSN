#!/bin/sh
#
#SBATCH --job-name anova
#SBATCH --cpus-per-task=4
#SBATCH -o o.Anova_RDA
#SBATCH -e e.Anova_RDA
#SBATCH --mail-user=iris.rizos@sb-roscoff.fr
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --mem-per-cpu=50GB
#SBATCH --partition=fast

# Script to run ANOVA test on each axis of RDA

module load r/4.1.1

R CMD BATCH Rscript_Anova_RDA.R



