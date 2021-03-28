#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=my-snptest-job-1
#SBATCH --array=1-22
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --ntasks=3
#SBATCH --mem=5gb
#SBATCH --time=12:0:0
#SBATCH --output=/scratch/my-snptest-job-1.out
#SBATCH --error=/scratch/my-snptest-job-1.err

module load snptest/2.5.2

snptest_v2.5.2 \
        -data /scratch/chr${SLURM_ARRAY_TASK_ID}.vcf.gz /scratch/phenotype.sample \
        -o /scratch/GWAS-myphenotype-chr${SLURM_ARRAY_TASK_ID}.out \
        -genotype_field GP \
        -frequentist 1 \
        -method expected \
        -pheno myphenotype \
        -cov_names sex age pc1 pc2 pc3 pc4 pc5
