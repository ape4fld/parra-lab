# this script is very quick since the files are just a few lines each max. If using Compute Canada, can run it using --salloc or in the main node.

# get a list of the chromosomes for which there is an output:
ls /your-path-to-COJO-output/chr*-GCTA-COJO.jma.cojo > list-COJO-chrs.txt

# extract the header:
file1=$(sed -n 1p list-COJO-chrs.txt)
awk 'NR==1' ${file1} > /your-path-to-COJO-output/pheno-all-chrs.jma.cojo

rows=$(wc -l list-COJO-chrs.txt | awk '{print $1}')
for ((i=1;i<=$rows;i++))
do
  file=$(sed -n ${i}p list-COJO-chrs.txt)
  awk 'NR>1' ${file} >> /your-path-to-COJO-output/pheno-all-chrs.jma.cojo
done
