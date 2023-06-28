# SNP_analysis_haplotype_t

These scripts were used to process WGS DNA sequencing obtained from SRA and create VCFs with variants for each dataset.
Fastqs are trimed, aligned to the genome, and then processed for Variant calling.

Pipeline:

1. Trim reads (trimmomatic, trim.sh) QC filtering of Reads, removes adapters and low quality reads.

2. #Align reads with BWA (BWA, bwa.sh) Aligns all trimmed reads to reference.

3.  #Sam -> Bam (samtools), Converts sam to bam for downstream analysis

4. #MarK PCR duplicates (picard, markdups.sh),, Remove duplicated reads 

5. #Assign Read Groups (Picard, Assign_readgroups.sh), Read group assignment is essential for GATK 

6. #Make new index file for bam, Index RG bam files, essential for GATK

7. #Call Vars with GATK (GATK, gatk.sh), Turns bam alignment into VCF 


Trimming, alignments, and picard scripts will work on entire directory of samples.
Samtools commands commands are currently only set up to process one sample at a time.
