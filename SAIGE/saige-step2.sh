#!/bin/bash

#SBATCH --account=your-CC-account
#SBATCH --time=1-00:00:00
#SBATCH --array=1-22
#SBATCH --job-name=saige-step2
#SBATCH --output=slurm-%x.out
#SBATCH --error=slurm-%x.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2G

module load singularity/3.7

singularity exec -B /home -B /project -B /scratch -B /localscratch /your-path-to-the-docker-image/saige.sif step2_SPAtests.R \
        --bgenFile=/your-path-to-the-bgen-files/${SLURM_ARRAY_TASK_ID}.bgen \
        --bgenFileIndex=/your-path-to-the-bgen-index-file/${SLURM_ARRAY_TASK_ID}.bgen.bgi \
        --minMAF=0.01 \
        --chrom=${SLURM_ARRAY_TASK_ID} \
        --minMAC=10 \
        --sampleFile=/your-path-to-a-list-of-sample-IDs/${array}-samples.txt \
        --GMMATmodelFile=/your-path-to-the-RDA-output-of-step1/null-phenotype.rda \
        --varianceRatioFile=/your-path-to-the-varianceRatio-output-of-step1/null-phenotype.varianceRatio.txt \
        --SAIGEOutputFile=/your-path-to-save-the-output/chr${SLURM_ARRAY_TASK_ID}.out \
        --IsOutputAFinCaseCtrl=TRUE \
        --IsDropMissingDosages=TRUE \
        --LOCO=FALSE
