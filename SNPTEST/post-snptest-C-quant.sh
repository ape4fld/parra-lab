#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=post-snptest-C-quant
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem=1gb
#SBATCH --time=1:0:0
#SBATCH --output=post-snptest-C-quant.out
#SBATCH --error=post-snptest-C-quant.err

trait="myphenotype"

# echo "Processing new files..."
# columns as follow: rsid, chr, pos, chr:pos, alleleA, alleleB, EAF (frequency of allele B), N, info, MAF, p-value, beta, se
awk '{print $2,$3,$4,$3":"$4,$5,$6,(2*$12+$11)/(2*($10+$11+$12)),$18,$9,$19,$21,$23,$24}' /scratch/tmp1-${trait}.out > /scratch/tmp2-${trait}.out

awk '{print $2,$3,$4, "chr:pos",$5,$6,"EAF","N",$9,$19,$21,$23,$24}' /scratch/${trait}-header-quant.out > /scratch/${trait}-header2-quant.out #EAF = frequency of allele B

cat /scratch/${trait}-header2-quant.out /scratch/tmp2-${trait}.out > /scratch/tmp3-${trait}.out

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

echo "Number of lines in the clean file:"
wc -l /scratch/${trait}-clean.out | awk '{print $1}'

echo "Number of lines in the top file:"
wc -l /scratch/${trait}-top.out | awk '{print $1}'

# echo "Removing tmp files..."
# rm /scratch/tmp*.out

