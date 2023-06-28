# SNP_analysis_haplotype_t

These scripts were used to process WGS DNA sequencing obtained from SRA and create VCFs with variants for each dataset.
Fastqs are trimed, aligned to the genome, and then processed for Variant calling.

Pipeline:

#Trim reads (trimmomatic, trim.sh)

#Align reads with BWA (BWA, bwa.sh)

#Sam -> Bam (samtools)

#MarK PCR duplicates (picard, markdups.sh)

#Assign Read Groups (Picard, Assign_readgroups.sh)

#Make new index file for bam

#Call Vars with GATK (GATK, gatk.sh)


Trimming, alignments, and picard scripts will work on entire directory of samples.
Samtools commands commands are currently only set up to process one sample at a time.
