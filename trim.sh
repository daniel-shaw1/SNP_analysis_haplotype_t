#!/bin/bash
#SBATCH --job-name=j_trim
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=100gb
#SBATCH --time=100:00:00
#SBATCH --output=trim.%j.out
#SBATCH --error=trim.%j.err
ml Trimmomatic/0.39-Java-1.8.0_144

cd $SLURM_SUBMIT_DIR

for file in *_1.f*

do
  export iden=${file%%.fastq}
  export log=${iden}.log
  export output=${iden}_trim.fastq.gz

java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE -phred33 -trimlog ${bam}.log -basein ${file} -baseout ${output}_trim.fastq.gz  ILLUMINACLIP:TruSeq3-PE:2:30:10 LEADING:3 TRAILING:3 SLIDIN$done

gzip *fastq*


