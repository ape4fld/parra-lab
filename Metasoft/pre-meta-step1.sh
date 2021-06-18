#!/bin/bash
#SBATCH --account=your-CC-account
#SBATCH --time=02:00:00
#SBATCH --job-name=pre-meta-step1
#SBATCH --output=slurm-%x.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=5G

# this script will prepare the summary statistics from different studies (3 in this example) to run a meta-analysis.

# 1. Arrange the summary statistics, to output the following columns:
# CHR SNP BP A1 A2 FRQ INFO OR SE P
for study in study1 study2 study3
do
	awk 'NR>1 {print $2,$1,$3,$4,$5,$6,$8,$11,$13,$10}' ${study}-clean.out > tmp-study${study}-all.out
done

# 2. If need to, multiply SE by the squared root of the lambda value (if lambda is > 1):
# there may be a way to automate it, but otherwise, do it manually:

# Example:
# sqrt_l_study1=1.010643
# sqrt_l_study2=1.009851
# sqrt_l_study3=1.002247

study="study1" 
# here $9 must be the column with the SE.
awk '{$9=$9*1.010643;print}' tmp-${study}-all.out > tmp2-${study}-all.out

# 3. Separate the summary statistics for each study per chromosome.
# Create a file with the header named 'label.txt': CHR SNP BP A1 A2 FRQ INFO OR SE P
for study in study1 study2 study3
do
  for i in {1..22}
  do
          awk '{if ($1 == '$i') print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}' tmp2-${study}-all.out > tmp-${study}-chr${i}.out
          cat label.txt tmp-${study}-chr${i}.out > ${study}-chr${i}.out
  done
done

# if everything worked fine, remove the tmp files by: rm tmp*
