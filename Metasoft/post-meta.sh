#!/bin/bash
#SBATCH --account=your-CC-account
#SBATCH --time=01:00:00
#SBATCH --job-name=post-meta
#SBATCH --error=slurm-%x.err
#SBATCH --output=slurm-%x.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=1G

# After finishing the meta-analysis, run the following command to merge the chromosomes, and then create a short version (chr, pos, pvalue-R2, Q, pvalue-Q):

awk 'NR==1' /your-path-to-meta-results/meta-chr1.out > /your-path-to-meta-results/meta-pheno.out

for i in {1..22}
do
        awk 'NR>1' /your-path-to-meta-results/meta-chr1.out >> /your-path-to-meta-results/meta-pheno.out
done

# Create clean file:
awk 'NR > 1 {print $1,$2,$3,$4,$5,$7,$8,$9,$13,$14,$15}' /your-path-to-meta-results/meta-pheno.out >> /your-path-to-meta-results/tmp-meta-pheno-clean.out

# Separate the SNP IDs to recover chr, pos, A1 and A2:
sed -i 's/:/ /g' /your-path-to-meta-results/tmp-meta-pheno-clean.out
sed -i 's/\t/ /g' /your-path-to-meta-results/tmp-meta-pheno-clean.out

# Create a label.txt file with the following header: CHR POS A1 A2 #STUDIES PVALUE_FE BETA_FE STD_FE BETA_RE STD_RE PVALUE_RE2 I_SQUARE Q PVALUE_Q
cat label.txt /your-path-to-meta-results/tmp-meta-pheno-clean.out > /your-path-to-meta-results/meta-pheno-clean.out
