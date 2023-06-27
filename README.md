# SNP_analysis_haplotype_t

Pipeline:

#Trim reads (trim.sh)
#Align reads with BWA (bwa.sh)
#Sam -> Bam (samtools)
#MarK PCR duplicates (picard, markdups.sh)
#Assign Read Groups (Picard, Assign_readgroups.sh)
#Call Vars with GATK (GATK, gatk.sh)
