#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=post-snptest-A-bin
#SBATCH --array=1-22
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem=2gb
#SBATCH --time=1:0:0
#SBATCH --output=post-snptest-A-bin.out
#SBATCH --error=post-snptest-A-bin.err

# set the variable name as in the SNPTEST output:
trait="myphenotype"

# create file for label:
awk '$1 != "#"' /scratch/${trait}-chr22.out > /scratch/tmp1-lines.out
awk 'NR==1' /scratch/tmp1-lines.out > /scratch/header-bin.out

# remove first lines for all files:
awk '$1 != "#"' /scratch/${trait}-chr${SLURM_ARRAY_TASK_ID}.out > /scratch/tmp1_${SLURM_ARRAY_TASK_ID}.out

# remove header line:
awk 'NR > 1' /scratch/tmp1_${SLURM_ARRAY_TASK_ID}.out > /scratch/tmp-${trait}-chr${SLURM_ARRAY_TASK_ID}.out
