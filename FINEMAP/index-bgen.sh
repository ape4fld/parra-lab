#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=index-bgen
#SBATCH --array=1-10
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem=1gb
#SBATCH --time=0:10:0
#SBATCH --output=index-bgen.out
#SBATCH --error=index-bgen.err

# Note: bgenix is installed in calculon.

module load bgenix/1.0

# This is a very simple and quick script to index the BGEN file using bgenix, which is necessary for LDstore and FINEMAP.
# Note that the sbatch arrays correspond to the number of subsets that you are going to finemap.

bgenix -g /path-of-bgen-output-files/finemap-subset${SLURM_ARRAY_TASK_ID}.bgen -index
