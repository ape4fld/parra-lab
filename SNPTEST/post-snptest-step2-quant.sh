#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=post-snptest-B-quant
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem=2gb
#SBATCH --time=2:0:0
#SBATCH --output=post-snptest-B-quant.out
#SBATCH --error=post-snptest-B-quant.err

trait="myphenotype"

# echo "Merging chromosomes..."
cat /scratch/tmp-${trait}-chr*.out > /scratch/tmp-${trait}.out

# echo "Removing p-value = NAs..."
awk '$21 != "NA"' /scratch/tmp-${trait}.out > /scratch/tmp1-${trait}.out

# echo "Creating .tar.gz file..."
tar -cvzf ${trait}.tar.gz /scratch/tmp1-${trait}.out

echo "Size of input file: "
wc -l /scratch/tmp-${trait}.out

echo "Size after removing p-values == NA: "
wc -l /scratch/tmp1-${trait}.out
