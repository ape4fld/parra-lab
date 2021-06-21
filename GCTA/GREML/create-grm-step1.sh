#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=1:00:00
#SBATCH --array=1-22
#SBATCH --job-name=vcf-to-bfile
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=15G
#SBATCH --ntasks=3

module load nixpkgs/16.09
module load plink/2.00-10252019-avx2

# can run it in Calculon server, may need to change the modules loaded.

# Convert the imputed VCF files into binary plink files, filtering out SNPs with INFO < 0.8:

plink2 \
        --vcf /your-path-to-the-vcf-imputed-files/${SLURM_ARRAY_TASK_ID}.vcf.gz 'dosage=DS' \
        --exclude-if-info "INFO < 0.8" \
        --make-bed \
        --out /your-path-to-save-output/chr${SLURM_ARRAY_TASK_ID}

module load gcc/9.3.0
module load gcta/1.26.0

# then use GCTA to obtain the GRM, one per chromosome:

gcta64 \
       --bfile chr${SLURM_ARRAY_TASK_ID} \
       --chr ${SLURM_ARRAY_TASK_ID} \
       --make-grm \
       --out grm_chr${SLURM_ARRAY_TASK_ID} \
       --thread-num 3
