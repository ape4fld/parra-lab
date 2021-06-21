#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=2:00:00
#SBATCH --job-name=make-grm
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=8G
#SBATCH --ntasks=7

#module load StdEnv/2020
#module load plink/2.00-10252019-avx2

# first need to make a binary plink file from the VCF genotype (not-imputed) file.

plink2 \
       --vcf /your-path-to-the-genotype-file/genotype.vcf.gz \
       --make-bed \
       --out tmp-bfile

module load gcc/9.3.0
module load gcta/1.26.0

# then use GCTA to get the GRM:

gcta64 --bfile chr${SLURM_ARRAY_TASK_ID} --chr ${SLURM_ARRAY_TASK_ID} --make-grm --out grm_chr${SLURM_ARRAY_TASK_ID} --thread-num 10
