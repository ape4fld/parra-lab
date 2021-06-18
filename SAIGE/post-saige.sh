#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=1:00:00
#SBATCH --job-name=post-saige
#SBATCH --output=slurm-%x.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=3G
#SBATCH --ntasks=2

# get header (first) row:
awk 'NR==1' /your-path-to-saige-step2-output/chr1.out > /your-path-to-saige-step2-output/tmp_output-pheno.out

# merge all chromosomes into one file:
for i in {1..22}
do
awk 'NR>1' /your-path-to-saige-step2-output/chr${i}.out >> /your-path-to-saige-step2-output/tmp_output-pheno.out
done

# create .tar.gz file with raw output:
tar -cvzf /your-path-to-saige-step2-output/tmp_output-pheno.tar.gz /your-path-to-saige-step2-output/tmp_output-pheno.out
# remove where p-value = NA:
awk '$13 != "NA"' /your-path-to-saige-step2-output/tmp_output-pheno.out > /your-path-to-saige-step2-output/tmp1_output-pheno.out
# remove SNPs with effect size = NA:
awk '$10 != "NA"' /your-path-to-saige-step2-output/tmp1_output-pheno.out > /your-path-to-saige-step2-output/tmp2_output-pheno.out
# remove SNPs that did not converge:
awk '$15!=0' /your-path-to-saige-step2-output/tmp2_output-pheno.out > /your-path-to-saige-step2-output/tmp3_output-pheno.out

# arrange columns:
awk '{print $3,$1,$2,$4,$5,$7,$8,$9,$10,$11,$13}' /your-path-to-saige-step2-output/tmp3_output-pheno.out > /your-path-to-saige-step2-output/tmp4_output-pheno.out

# filter file with INFO threshold 0.3:
awk '$7 > 0.3' /your-path-to-saige-step2-output/tmp4_output-pheno.out > /your-path-to-saige-step2-output/tmp5_output-pheno.out
# filter file with MAF threshold 0.01, this will be the final clean file:
awk '$6 > 0.01' /your-path-to-saige-step2-output/tmp5_output-pheno.out > /your-path-to-saige-step2-output/output-pheno-clean.out
# filter with p-value threshold 1e-6 (suggestive of association):
awk 'NR==1; $11 < 0.00001' /your-path-to-saige-step2-output/output-pheno-clean.out > /your-path-to-saige-step2-output/output-pheno-top.out
# create file only with p-values (for QQ plot):
awk '{print $11}' /your-path-to-saige-step2-output/output-pheno-clean.out > /your-path-to-saige-step2-output/output-pheno-pval.out
# create file with rsid, chr, pos and p-value (for Manhattan plot):
awk '{print $1,$2,$3,$11}' /your-path-to-saige-step2-output/output-pheno-clean.out > /your-path-to-saige-step2-output/output-pheno-clean2.out
