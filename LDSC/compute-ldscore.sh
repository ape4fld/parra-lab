#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=ldsc-compute
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=2gb
#SBATCH --time=1:0:0
#SBATCH --output=ldsc-compute.out
#SBATCH --error=ldsc-compute.err

# Note: I ran this in the Calculon server

module load python/2.7.14
module load ldsc/1.0.1

ldsc.py \
        --h2 ldsc-summary-stats.sumstats.gz \
        --ref-ld-chr eur_w_ld_chr/ \
        --w-ld-chr eur_w_ld_chr/ \
        --out /your-path-to-save-output/LDScore-regression-gwas
