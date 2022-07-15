#!/bin/bash

################################ Slurm options #################################
#SBATCH -o slurm.%N.SOLA_CC_RV.out
#SBATCH -e slurm.%N.%j.err

#SBATCH --partition fast
#SBATCH --mem 40GB
##SBATCH --cpus 8

##############SCRIPT#################
module load r/3.6.3
Rscript Escouffier_SOLA.r

