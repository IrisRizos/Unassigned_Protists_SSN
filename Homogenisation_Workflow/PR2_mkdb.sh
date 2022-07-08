#!/bin/sh
#
#SBATCH --job-name mkdb
#SBATCH --cpus-per-task=4 
#SBATCH -o o.mkdb
#SBATCH -e e.mkdb
#SBATCH --mail-user=iris.rizos@sb-roscoff.fr
#SBATCH --mail-type=BEGIN,FAIL,END

module load blast/

makeblastdb -in /shared/projects/formaldark/PR2_blast/pr2_version_4.12.0_18S_taxo_long_nostrain.fasta -dbtype nucl -out PR2_18S

# Run on 03.02.2021
