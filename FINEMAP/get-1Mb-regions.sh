# This shell script can be used to get 1Mb regions from GWAS summary statistics and also output a file with the list of the SNPs on each region.
# FINEMAP uses a specific order for the summary statistics: rsid chromosome position allele1 allele2 maf beta se (you can consult the details in the FINEMAP website)
# but make sure that you have that specific format before running this shell script.

# Files required to run the script:
# 'gwas-sumstats-for-finemap.out' in the order mentioned above.
# 'header-finemap.txt' is a text file with one row including the required header [rsid chromosome position allele1 allele2 maf beta se] separated by spaces.
# 'index-SNPs-positions.txt' is a text file containing the chromosome and position information for each top/lead SNP that you'll finemap (one per row, no header), example:

#####    1 417284949
#####    5 127940401
#####    18  1903830191
#####    22  19039387272

# first extract the number of regions to finemap:
rows=$(wc -l index-SNPs-positions.txt | awk '{print $1}')

# loop on the 'index-SNPs-positions.txt' file to extract SNPs in the +/- 500kb flanking regions:
for ((i=1;i<=$rows;i++))
do
	chr=$(sed -n ${i}p index-SNPs-positions.txt | awk '{print $1}')
	pos=$(sed -n ${i}p index-SNPs-positions.txt | awk '{print $2}')
  x=500000  # change value here if you want shorter/longer regions
	pos1=$(echo "${pos} ${x}" | awk '{print $1 - $2}')
	pos2=$(echo "${pos} ${x}" | awk '{print $1 + $2}')
	awk -v tmp1=${chr} -v tmp2=${pos1} -v tmp3=${pos2} '$2==tmp1 && $3>=tmp2 && $3 <=tmp3' gwas-sumstats-for-finemap.out > tmp-sumstats-for-finemap-subset${i}.out
	cat header-finemap.txt tmp-sumstats-for-finemap-subset${i}.out > sumstats-for-finemap-subset${i}.out  # this is the final sumstats file per region
	awk 'NR>1 {print $1}' sumstats-for-finemap-subset${i}.out > rsids-sumstats-for-finemap-subset${i}.out  # this is the list of SNPs used to extract afterwards from the genotype data
done
