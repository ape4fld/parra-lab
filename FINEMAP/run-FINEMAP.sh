#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=finemap
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --cpus-per-task=5
#SBATCH --ntasks=3
#SBATCH --mem-per-cpu=5gb
#SBATCH --time=1:0:0
#SBATCH --output=finemap.out
#SBATCH --error=finemap.err

# Note: FINEMAP is installed in Calculon server.

module load finemap/1.4

# you can change the --n-causal-snps for any value between 1 and 20.
# similar to LDstore, you can specify --dataset the subset you want to run.
# the --force-n-samples is used when the sample size in the BGEN file is different from the GWAS sample size (indicated in the masterfiles for LDstore and FINEMAP).

finemap --sss --in-files masterfile-FINEMAP-example.txt --log --n-causal-snps 10 --std-effects --n-threads 5 --force-n--samples

# there are various outputs for each subset, check out the FINEMAP website for details and how to interpret them.
