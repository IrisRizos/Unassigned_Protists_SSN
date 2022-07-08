#!/bin/sh
#
#SBATCH --job-name blast
#SBATCH --cpus-per-task=6 
#SBATCH -o o.Dataset_blast
#SBATCH -e e.Dataset_blast
#SBATCH --mail-user=iris.rizos@sb-roscoff.fr
#SBATCH --mail-type=BEGIN,FAIL,END

module load blast/2.2.31

blastn -query Dataset.fasta -db PR2_18S -out Dataset_080221.blast.out -evalue 0.01 -outfmt 6 -max_target_seqs 15

# Run on 08.02.2021
