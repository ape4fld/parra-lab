#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=1:00:00
#SBATCH --array=1-22
#SBATCH --job-name=gcta_cojo
#SBATCH --output=gcta_cojo-%x.out
#SBATCH --error=gcta_cojo-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=8G
#SBATCH --cpus-per-task=3

module load nixpkgs/16.09
module load gcc/5.4.0
module load openmpi/2.0.2
module load gcta/1.26.0

# GCTA is also installed in the Calculon server, you may need to modify the loaded modules if you run it there.

gcta64 \
  --bfile /your-path-to-the-plink-genotype-files/chr${SLURM_ARRAY_TASK_ID}_INFO-0.8 \
  --chr ${SLURM_ARRAY_TASK_ID} \
  --cojo-file /your-path-to-gwas-summary-stats/gwas-pheno.out \
  --cojo-slct \
  --cojo-p 5e-8 \
  --out /your-path-to-save-the-output/chr${SLURM_ARRAY_TASK_ID}-GCTA-COJO
