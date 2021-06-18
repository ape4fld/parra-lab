#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=1:00:00
#SBATCH --job-name=make-grm
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=2G

for i in {1..22}
do
        awk '$9 != "-nan"' chr${i}.mlma | awk 'NR>1' >> pheno-mlma.out
done

for i in {1..22}
do
        awk -v chr=${i} '{if ($1 == chr) print $1,$2,$3,$4,$5,$7,$8,$9}' ${array}-${trait}.out | awk '{if ($2 == ".") print $1,$1":"$3,$3,$4,$5,$6,$7,$8; else print $0}' > tmp-${array}-${trait}-chr${i}-for-meta.out
        cat header.txt tmp-${array}-${trait}-chr${i}-for-meta.out > ../meta/data-for-meta/${array}-${trait}-chr${i}-for-meta.out
done
