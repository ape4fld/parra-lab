#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=2:00:00
#SBATCH --array=1-22
#SBATCH --job-name=make-bfile
#SBATCH --output=make-bfile.out
#SBATCH --error=make-bfile.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=15G
#SBATCH --cpus-per-task=3

module load nixpkgs/16.09
module load plink/2.00-10252019-avx2

# also possible to run it in Calculon server, may need to change module loading in that case.
# this script creates a binary plink file from VCF imputed data to use for GCTA-COJO, using arrays to run all chromosomes in parallel.

plink2 \
        --vcf /your-path-for-VCF-imputed-files/${SLURM_ARRAY_TASK_ID}.vcf.gz 'dosage=DS' \
        --exclude-if-info "INFO < 0.8" \
        --make-bed \
        --out /your-path-to-save-output/${SLURM_ARRAY_TASK_ID}_INFO-0.8
