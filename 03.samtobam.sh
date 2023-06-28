#!/bin/bash
#SBATCH --job-name=bwa_alignment_thap
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100gb
#SBATCH --time=96:00:00
#SBATCH --output=samtools.%j.out
#SBATCH --error=samtools.%j.err

cd $SLURM_SUBMIT_DIR

ml SAMtools/1.16.1-GCC-11.3.0
###works on one file at a time.. should automate for multi sam use.

samtools view -bh DRR271620_1_trim.fastq.gz_trim.sam > DRR271620_1_trim.fastq_unsort.bam
samtools sort -o DRR271620_1_trim.fastq_sort.bam -T samfile_s DRR271620_1_trim.fastq_unsort.bam
mv DRR271620_1_trim.fastq_sort.bam DRR271620_1.bam
samtools index -b DRR271620_1.bam
