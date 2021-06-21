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

python munge_sumstats.py \
	--sumstats gwas-summary-stats-file.out \
	--merge-alleles bim-file-all-chrs.txt \
	--out summary-stats-adapted
