#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=1:00:00
#SBATCH --job-name=post-mlma
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=2G

# get the header:
awk 'NR==1' /your-path-with-mlma-results/chr1.mlma > pheno-mlma.out

# merge chromosomes:
for i in {1..22}
do
        awk '$9 != "-nan"' /your-path-with-mlma-results/chr${i}.mlma | awk 'NR>1' >> pheno-mlma.out
done
