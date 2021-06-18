#!/bin/bash

#SBATCH --account=def-eparra
#SBATCH --time=12:00:00
#SBATCH --array=1-22
#SBATCH --job-name=index-vcfs-tbi
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=frida.lonadurazo@mail.utoronto.ca
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G

# BGENIX is installed in the Calculon server, but not in Compute Canada. I have installed it on my CC directory.

bgenix -g /your-path-to-the-bgen-files/${SLURM_ARRAY_TASK_ID}.bgen -index
