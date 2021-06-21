#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=ldsc-munge-sumstats
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=2gb
#SBATCH --time=1:0:0
#SBATCH --output=ldsc-munge-sumstats.out
#SBATCH --error=ldsc-munge-sumstats.err

module load python/2.7.14
module load ldsc/1.0.1

# Note: ran in Calculon server

munge_sumstats.py \
        --sumstats gwas-summary-stats.out \
        --merge-alleles w_hm3.snplist \
        --out ldsc-summary-stats \
        --chunksize 500000
