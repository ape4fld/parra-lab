#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=2:00:00
#SBATCH --job-name=make-grm-step2
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=8G
#SBATCH --ntasks=7

module load gcc/9.3.0
module load gcta/1.26.0

# In this step I merge the GRMs from all chromosomes into one.
# 'grm_chrs.txt' is a text file containing the name of the GRM for each chromosome, one per row. Check the GCTA-COJO page for details.

gcta64 \
  --mgrm grm_chrs.txt \
  --make-grm \
  --out GRM-all-chrs
