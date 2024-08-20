#!/bin/bash

#SBATCH --job-name=fastp_1
#SBATCH --output=%x.%j.out1

# Resources allocation request parameters
#SBATCH --partition=sahmri_prod_hpc

#SBATCH --mail-user=daniel.thomson@sahmri.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=6000       # this will request 96 Gb of memory
#SBATCH --time=3-00:00:00          # Run time in hh:mm:s

#set -e
#set -o pipefail

## specify tools
fastp='/apps/bioinfo/share/bcbio/anaconda_old/bin/fastp'



####### Fastqp trim to length  ############
mkdir -p fastq.trimmed

${fastp} --max_len1 76 \
	--max_len2 76 \
	-i /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00592_S7_R1_001.fastq.gz \
	-I /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00592_S7_R2_001.fastq.gz \
        -o /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00592_S7_R1_001.fastq.gz \
        -O /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00592_S7_R2_001.fastq.gz

echo "finished"

${fastp} --max_len1 76 \
        --max_len2 76 \
        -i /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00591_S6_R1_001.fastq.gz \
        -I /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00591_S6_R2_001.fastq.gz \
        -o /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00591_S6_R1_001.fastq.gz \
        -O /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00591_S6_R2_001.fastq.gz

echo "finished"

${fastp} --max_len1 76 \
        --max_len2 76 \
        -i /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00590_S5_R1_001.fastq.gz \
        -I /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00590_S5_R2_001.fastq.gz \
        -o /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00590_S5_R1_001.fastq.gz \
        -O /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00590_S5_R2_001.fastq.gz

echo "finished"

${fastp} --max_len1 76 \
        --max_len2 76 \
        -i /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00589_S4_R1_001.fastq.gz \
        -I /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00589_S4_R2_001.fastq.gz \
        -o /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00589_S4_R1_001.fastq.gz \
        -O /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00589_S4_R2_001.fastq.gz

echo "finished"

${fastp} --max_len1 76 \
        --max_len2 76 \
        -i /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00588_S3_R1_001.fastq.gz \
        -I /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00588_S3_R2_001.fastq.gz \
        -o /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00588_S3_R1_001.fastq.gz \
        -O /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00588_S3_R2_001.fastq.gz

echo "finished"

${fastp} --max_len1 76 \
        --max_len2 76 \
        -i /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00587_S2_R1_001.fastq.gz \
        -I /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00587_S2_R2_001.fastq.gz \
        -o /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00587_S2_R1_001.fastq.gz \
        -O /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00587_S2_R2_001.fastq.gz

echo "finished"

${fastp} --max_len1 76 \
        --max_len2 76 \
        -i /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00586_S1_R1_001.fastq.gz \
        -I /cancer/storage/SAGC/fastq/SAGCQA0625-1/F350010030/fastq/23-00586_S1_R2_001.fastq.gz \
        -o /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00586_S1_R1_001.fastq.gz \
        -O /homes/daniel.thomson/projects/MGIvsIllumina/fastq.trimmed/23-00586_S1_R2_001.fastq.gz

echo "finished"
