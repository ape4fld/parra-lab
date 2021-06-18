#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=4:00:00
#SBATCH --array=1-22
#SBATCH --job-name=gcta-mlma
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=8

module load gcc/9.3.0
module load gcta/1.26.0

gcta64 \
        --bfile /your-path-to-binary-plink-files/chr${SLURM_ARRAY_TASK_ID} \
        --grm-gz /your-path-to-the-GRM/GRM-cohort \
        --thread-num 8 \
        --mlma \
        --pheno /your-path-to-the-phenotype-file/PHENO-GCTA-MLMA.txt \
        --qcovar /your-path-to-the-quantitative-covariates/QCOV-GCTA-MLMA.txt \
        --covar /your-path-to-the-binary-covariates/COV-GCTA-MLMA.txt \
        --out /your-path-to-save-the-output/chr${SLURM_ARRAY_TASK_ID}-pheno
