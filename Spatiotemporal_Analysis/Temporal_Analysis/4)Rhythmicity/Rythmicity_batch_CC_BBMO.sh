#!/bin/bash

################################ Slurm options #################################
#SBATCH -o slurm.%N.%j.out
#SBATCH -e slurm.%N.%j.err

#SBATCH --partition fast
#SBATCH --mem 70GB
##SBATCH --cpus 8

##############SCRIPT#################
module load r/3.6.3
Rscript Rhythmicity_BBMO.Rmd


