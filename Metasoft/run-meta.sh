#!/bin/bash
#SBATCH --account=your-CC-account
#SBATCH --time=3:00:00
#SBATCH --array=1-22
#SBATCH --job-name=run-meta
#SBATCH --output=slurm-%x.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=10G

module load nixpkgs/16.09
module load java/13.0.1

java \
  -jar Metasoft.jar \
  -input /your-path-to-sumstats-input/chr${SLURM_ARRAY_TASK_ID}.meta \
  -output /your-path-to-save-output/meta-chr${SLURM_ARRAY_TASK_ID}.out \
  -log /your-path-to-save-output-log/meta-chr${SLURM_ARRAY_TASK_ID}.log \
  -binary_effects \
  -mvalue \
  -mvalue_p_thres 5E-8
