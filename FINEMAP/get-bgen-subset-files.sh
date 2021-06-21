#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=1:00:00
#SBATCH --job-name=qctool
#SBATCH --array=1-10
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=5G
#SBATCH --ntasks=3

# Note 1: I have installed qctool_v2 in Graham in Compute Canada locally in my account (no modules loaded). It was not possible to install it in Cedar (?).
# To install the program yourself: https://www.well.ox.ac.uk/~gav/qctool_v2/documentation/download.html (otherwise you can ask for installation on Calculon).

# Note 2: the number of batch arrays (see header of script above), corresponds to the number of regions or subset to finemap.

# extract the chromosome number for each region:
chr=$(sed -n ${SLURM_ARRAY_TASK_ID}p HC-M${model}-posminmax.txt | awk '{print $1}')

# Step 1: convert from VCF to BGEN, which retains the imputation information:
qctool_v2.0.7 \
        -g /your-path-to-the-imputed-genotype-data/${chr}.vcf.gz -vcf-genotype-field GP \
        -incl-rsids /path-to-lists-of-rsids-from-subsets/rsids-subset${SLURM_ARRAY_TASK_ID}.txt \
        -og /path-to-output-bgen-files/finemap-subset${SLURM_ARRAY_TASK_ID}.bgen \
        -os /path-to-output-bgen-files/finemap-subset${SLURM_ARRAY_TASK_ID}.sample

# Step 2: generate a file with the SNP information in the new files, to check that there is a full overlap between the SNPs in the BGEN subset files and the summary statistics subset files.
# this is important because LDstore requires a full overlap of the SNPs, otherwise it will generate errors.
qctool_v2.0.7 \
        -g /path-of-bgen-output-files/finemap-subset${SLURM_ARRAY_TASK_ID}.bgen -snp-stats -osnp /path-of-bgen-output-files/finemap-subset${SLURM_ARRAY_TASK_ID}.txt
