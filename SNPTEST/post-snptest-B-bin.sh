#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=post-snptest-B-bin
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem=2gb
#SBATCH --time=1:0:0
#SBATCH --output=post-snptest-B-bin.out
#SBATCH --error=post-snptest-B-bin.err

trait="myphenotype"

echo "Merging chromosomes..."
cat /scratch/tmp-${trait}-chr*.out > /scratch/tmp-${trait}.out

echo "Removing p-value = NAs..."
awk '$42 != "NA"' /scratch/tmp-${trait}.out > /scratch/tmp1-${trait}.out

echo "Creating .tar.gz file..."
tar -cvzf ${trait}.tar.gz /scratch/tmp1-${trait}.out

echo "Number of lines before removing pvalues == NA: "
wc -l tmp-${trait}.out

echo "Number of lines after removing pvalues == NA: "
wc -l tmp1-${trait}.out
