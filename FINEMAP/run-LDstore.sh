#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=ldstore
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --cpus-per-task=3
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=1gb
#SBATCH --time=1:0:0
#SBATCH --output=ldstore.out
#SBATCH --error=ldstore.err

# Note: LDstore is installed in Calculon.

module load ldstore/2.0

ldstore --in-files masterfile-LDstore-example.txt --write-bcor --read-only-bgen --memory 5G --n-threads 3 --dataset 1-5

# the --dataset flag is to specificy which subsets (or lines) from the masterfile you want to run. You can remove this option if you want to run it for all subsets.
# the output will be files with the 'bcor' extension that will be used as they are for FINEMAP.
