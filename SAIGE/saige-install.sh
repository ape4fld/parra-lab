#!/bin/bash

#SBATCH --account=
#SBATCH --time=05:00:00
#SBATCH --job-name=saige-install
#SBATCH --output=slurm-%x.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=5G

module load singularity/3.5

# the following command creates a docker image in the current directory 'saige_v0.44.2.sif', which will be used with Singularity to run the progam.
singularity build saige_v0.44.2.sif docker://wzhou88/saige:0.44.2
