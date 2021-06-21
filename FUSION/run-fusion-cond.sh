#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=2:00:00
#SBATCH --job-name=fusion-cond
#SBATCH --output=run-fusion-cond.out
#SBATCH --error=run-fusion-cond.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=5G
#SBATCH --cpus-per-task=4

module load nixpkgs/16.09
module load gcc/7.3.0
module load r/3.6.1

# before running the following script, need to run extract the top results from the TWAS, this is the example given on the FUSION website:
# cat PGC2.SCZ.22.dat | awk 'NR == 1 || $NF < 0.05/3998' > PGC2.SCZ.22.top

Rscript FUSION.post_process.R \
        --sumstats ../GWAS/${trait}-M${model}-forTWAS.sumstats.v2 \
        --input ./TWAS_output-v2/TWAS_HC_M1.chr14.top \
        --ref_ld_chr ../LDREF/CPTP.chr \
        --chr 14 \
        --out ./TWAS_output-v2/TWAS_${trait}_M${model}.chr14.cond.analysis \
        --plot \
        --locus_win 100000
