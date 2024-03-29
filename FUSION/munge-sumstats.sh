#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=ldsc-munge-sumstats
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1gb
#SBATCH --time=1:0:0
#SBATCH --output=ldsc-munge-sumstats.out
#SBATCH --error=ldsc-munge-sumstats.err

module load python/2.7.14
module load ldsc/1.0.1

# Note: I have run LDSC in the Calculon server.

# The munge_sumstats.py script used here is available at the LDSC github page: https://github.com/bulik/ldsc/blob/master/munge_sumstats.py
# This script is included in the LDSC package available in Calculon.
# More about munge sumstats: https://github.com/bulik/ldsc/wiki/Summary-Statistics-File-Format
# Note 2: Some common errors arise due to misalignment of A1 and A2 in the sumstats compared to the LD reference file!

python munge_sumstats.py \
	--sumstats gwas-summary-stats.out \
	--merge-alleles bim-file-all-chrs.txt \
	--chunksize 500000 \    # this flag is optional, but I had memory errors if I didn't include it
	--out GWAS-summary-stats-file-adapted

# the script outputs a gzipped file, and it needs to be unzipped to use it on TWAS:
gunzip GWAS-summary-stats-file-adapted.sumstats.gz
