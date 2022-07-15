#!/bin/bash

################################ Slurm options #################################
#SBATCH -o slurm.%N.BBMO_CC_RV.out
#SBATCH -e slurm.%N.%j.err

#SBATCH --partition fast
#SBATCH --mem 100GB
##SBATCH --cpus 16

##############SCRIPT#################
module load r/3.6.3
Rscript Escouffier_BBMO.r


