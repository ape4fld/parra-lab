#!/bin/bash
#SBATCH --account=def-eparra
#SBATCH --time=02:00:00
#SBATCH --array=1-22
#SBATCH --job-name=pre-meta-step2
#SBATCH --error=slurm-%x.err
#SBATCH --output=slurm-%x.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=3

module load nixpkgs/16.09 gcc/5.4.0
module load python/3.8.0
module load r/3.3.3

# This script uses the python script that comes along when you download Metasoft. The first line is calling the python script, the second line is the output name,
# followed by lines with the summary statistics for each study.

python plink2metasoft2.py \
  /your-path-to-save-output/chr${SLURM_ARRAY_TASK_ID} \
  /your-path-with-summary-stats/study1-chr${SLURM_ARRAY_TASK_ID}.out \
  /your-path-with-summary-stats/study2-chr${SLURM_ARRAY_TASK_ID}.out \
  /your-path-with-summary-stats/study3-chr${SLURM_ARRAY_TASK_ID}.out
