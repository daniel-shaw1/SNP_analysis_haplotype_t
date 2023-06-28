#!/bin/bash
#SBATCH --job-name=bwa_alignment_thap
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=100gb
#SBATCH --time=96:00:00
#SBATCH --output=thap.%j.out
#SBATCH --error=thap.%j.err

cd $SLURM_SUBMIT_DIR

ml SAMtools/1.16.1-GCC-11.3.0
#need to run for each bam file, should be able to work on multiple with -M command
samtools index -b DRR271623_1.marked_duplicates.with_read_groups.bam

