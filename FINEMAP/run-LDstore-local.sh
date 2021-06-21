#!/bin/bash
#SBATCH --partition=generalq
#SBATCH --job-name=ldstore-local
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=1gb
#SBATCH --time=1:0:0
#SBATCH --output=ldstore-local.out
#SBATCH --error=ldstore-local.err

module load ldstore/2.0

# This is one line per subset in the masterfile (defined with the --dataset flag) and the --rsids flag indicates the SNP(s) for which LD will be calculated.
# In this case, a new masterfile is needed to output the LD in text format and not in BCOR format.
# The output will be one file per subset with the 'ld' extension, and in the file one column per SNP indicated here.

ldstore --in-files masterfile-LDstore-local-example.txt --write-text --read-only-bgen --n-threads 5 --dataset 1 --rsids rs16891982
ldstore --in-files masterfile-LDstore-local-example.txt --write-text --read-only-bgen --n-threads 5 --dataset 5 --rsids rs12295166,rs1126809
ldstore --in-files masterfile-LDstore-local-example.txt --write-text --read-only-bgen --n-threads 5 --dataset 3 --rsids rs12821256,rs11611040
