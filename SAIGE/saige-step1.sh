#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=3:00:00
#SBATCH --job-name=saige-step1
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=1G

module load singularity/3.5

singularity exec -B /home -B /project -B /scratch -B /localscratch /path-to-your-docker-image/saige.sif step1_fitNULLGLMM.R \
  --plinkFile=/path-to-your-plink-genotype-file/genotypes \
  --phenoFile=/path-to-your-phenotype-file/pheno.saige \
  --phenoCol=column1 \
  --covarColList=sex,age,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10 \
  --sampleIDColinphenoFile=ID_1 \
  --traitType=binary \
  --outputPrefix=/path-to-save-the-output/null-pheno \
  --nThreads=8 \
  --LOCO=FALSE
