#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=index-bgen
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem=1gb
#SBATCH --time=0:10:0
#SBATCH --output=index-bgen.out
#SBATCH --error=index-bgen.err

# Note: bgenix is installed in calculon.

module load bgenix/1.0

bgenix -g .bgen -index
