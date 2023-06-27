#!/bin/bash
#SBATCH --job-name=j_GATK
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --mem=100gb
#SBATCH --cpus-per-task=30
#SBATCH --time=100:00:00
#SBATCH --output=GATK.%j.out
#SBATCH --error=GATK.%j.err
cd $SLURM_SUBMIT_DIR
ml GATK/4.4.0.0-GCCcore-8.3.0-Java-17.0.4


# Directory containing the input BAM files
input_dir="/scratch/des65576/Mouse/mm10/wholegenome/mus/align/Mark_dups/RG/"

# Output directory to store the VCF files
output_dir="/scratch/des65576/Mouse/mm10/wholegenome/mus/align/VCF/"

# GATK JAR file path
gatk_jar="/apps/eb/GATK/4.4.0.0-GCCcore-8.3.0-Java-1.8/gatk-package-4.4.0.0-local.jar"

# Reference genome file path
reference_genome="/scratch/des65576/Mouse/mm10/wholegenome/mus/align/tw5_HiFiONT_defaultctgs_25kbNs_norm.fna"

# Iterate over the BAM files in the input directory
for bam_file in "$input_dir"/*.bam; do
    # Extract the base filename without extension
    filename=$(basename "$bam_file" .bam)

    # Generate the output VCF filename
    output_vcf="$output_dir/$filename.vcf"

    # Run GATK HaplotypeCaller to generate the VCF file
    java -jar "$gatk_jar" HaplotypeCaller \
        -R "$reference_genome" \
        -I "$bam_file" \
        -O "$output_vcf"
done
