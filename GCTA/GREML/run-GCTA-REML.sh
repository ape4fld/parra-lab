#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=2:00:00
#SBATCH --job-name=run-reml
#SBATCH --output=run-reml.out
#SBATCH --error=run-reml.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=3G
#SBATCH --cpus-per-task=4

module load nixpkgs/16.09
module load gcc/5.4.0
module load openmpi/2.0.2
module load gcta/1.26.0

gcta64 \
  --reml-bivar 1 2 \
  --grm your-grm \
  --pheno your-pheno-file.phe \
  --covar your-covar-file.txt \
  --qcovar your-quant-covar-file.txt \
  --out output-name \
  --thread-num 4
