
module load nixpkgs/16.09 gcc/5.4.0
module load python/3.8.0
module load r/3.3.3

python plink2metasoft2.py chr${SLURM_ARRAY_TASK_ID} study1-chr${SLURM_ARRAY_TASK_ID}.out study2-chr${SLURM_ARRAY_TASK_ID}.out study3-chr${SLURM_ARRAY_TASK_ID}.out
