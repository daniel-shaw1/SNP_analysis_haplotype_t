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
ml picard/2.27.4-Java-13.0.2

input_dir="/scratch/des65576/Mouse/mm10/wholegenome/mus/align/Mark_dups/"

# Output directory to store the BAM files with read groups
output_dir="/scratch/des65576/Mouse/mm10/wholegenome/mus/align/Mark_dups/RG/"

# Picard JAR file path
picard_jar="/apps/eb/picard/2.27.4-Java-13.0.2/picard.jar"

# Read group information
read_group_id="ID"
read_group_sample="Sample"
read_group_library="Library"
read_group_platform="Platform"
read_group_platform_unit="Unit"

# Iterate over the BAM files in the input directory
for bam_file in "$input_dir"/*.bam; do
    # Extract the base filename without extension
    filename=$(basename "$bam_file" .bam)

    # Generate the output BAM filename with read groups
    output_bam="$output_dir/$filename.with_read_groups.bam"

    # Run Picard AddOrReplaceReadGroups to add read groups to the BAM file
    java -jar "$picard_jar" AddOrReplaceReadGroups \
        INPUT="$bam_file" \
        OUTPUT="$output_bam" \
        RGID="$read_group_id" \
        RGLB="$read_group_library" \
        RGPL="$read_group_platform" \
        RGSM="$read_group_sample" \
        RGPU="$read_group_platform_unit" \
        VALIDATION_STRINGENCY=LENIENT
done
