#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=2:00:00
#SBATCH --array=1-22
#SBATCH --job-name=get-LDref
#SBATCH --output=get-LDref.out
#SBATCH --error=get-LDref.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=15G
#SBATCH --ntasks=3

# Note: I ran this in Compute Canada

# Step 1: convert from VCF to binary plink file

module load nixpkgs/16.09
module load plink/2.00-10252019-avx2

plink2 \
  --vcf /path-to-imputed-VCF-files/${SLURM_ARRAY_TASK_ID}.vcf.gz 'dosage=DS' \
  --exclude-if-info "INFO < 0.3" \
  --make-bed \
  --out LDref-chr${SLURM_ARRAY_TASK_ID}

# Step 2: filter genotype file based on FUSION recommendations

module load StdEnv/2020
module load plink/1.9b_6.21-x86_64

plink \
  --bfile LDref-chr${SLURM_ARRAY_TASK_ID} \
  --maf 0.01 \
  --geno 0.01 \
  --hwe 10e-7 \
  --make-bed \
  --out /path-to-save-LDREF-files/LDref-filtered-chr${SLURM_ARRAY_TASK_ID}
