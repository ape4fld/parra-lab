#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=2:00:00
#SBATCH --array=1-22
#SBATCH --job-name=run-fusion
#SBATCH --output=%x.out
#SBATCH --error=%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=5G
#SBATCH --cpus-per-task=4

module load nixpkgs/16.09
module load gcc/7.3.0
module load r/3.6.1

Rscript FUSION.assoc_test.R \
        --sumstats GWAS-summary-stats-file-adapted \
        --weights /path-to-eQTL-weights/positions-file.P01.pos \
        --weights_dir /path-to-eQTL-weights \
        --ref_ld_chr /path-to-LDREF/LDREF.chr \
        --chr ${SLURM_ARRAY_TASK_ID} \
        --out /path-to-save-output/TWAS-pheno.dat
