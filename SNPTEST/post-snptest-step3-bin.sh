#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=post-snptest-C-bin
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem=2gb
#SBATCH --time=1:0:0
#SBATCH --output=post-snptest-C-bin.out
#SBATCH --error=post-snptest-C-bin.err

trait="myphenotype"

# wrangle columns:
awk '{print $2,$3,$4,$3":"$4,$5,$6,(2*$12+$11)/(2*($10+$11+$12)),$18,$9,$29,$42,$39,$44,$45}' /scratch/tmp1-${trait}.out > /scratch/tmp2-${trait}.out

# create new header:
awk '{print $2,$3,$4,"chr:pos",$5,$6,"EAF","N",$9,$29,$42,$39,$44,$45}' /scratch/header-bin.out > /scratch/header2-bin.out #EAF = frequency of allele B

# include new header:
cat /scratch/header2-bin.out /scratch/tmp2-${trait}.out > /scratch/tmp3-${trait}.out

echo "Filtering file according to info column..."
awk '$9>0.3' /scratch/tmp3-${trait}.out > /scratch/tmp4-${trait}.out

# echo "Removing duplicated markers..."
# awk '!array[$2,$3]++' /scratch/tmp4-${trait}.out > /scratch/tmp5-${trait}.out

echo "Filtering file according to MAF..."
awk '$10>0.01' /scratch/tmp4-${trait}.out > /scratch/${trait}-clean.out

echo "Filtering by p-value..."
awk 'NR==1; $11<0.00001' /scratch/${trait}-clean.out > /scratch/${trait}-top.out

echo "Creating p=values file..."
awk '{print $11}' /scratch/${trait}-clean.out > /scratch/${trait}-pval.out
awk '{print $1,$2,$3,$11}' /scratch/${trait}-clean.out > /scratch/${trait}-clean2.out

echo "Number of lines in the clean file: "
wc -l /scratch/${trait}-clean.out | awk '{print $1}'

echo "Number of lines in the top file: "
wc -l /scratch/${trait}-top.out | awk '{print $1}'

# echo "Removing tmp files..."
# rm /scratch/tmp*.out
