# This is a quick step that can be run with --salloc on Compute Canada.
# The script merges the bim files (after filtering) for all chromosomes generated in the previous step, to use in the next step (munge sumstats).

for i in 1:22
do
  cat /path-with-LDREF-files/LDref-filtered-chr${i} >> bim-file-all-chrs.txt
done
