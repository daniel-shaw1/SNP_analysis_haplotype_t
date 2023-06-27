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

# Directory containing the input BAM files
input_dir="/scratch/des65576/Mouse/mm10/wholegenome/mus/align/"

# Output directory to store the marked duplicates BAM files
output_dir="/scratch/des65576/Mouse/mm10/wholegenome/mus/align/Mark_dups/"

# Picard JAR file path
picard_jar="/apps/eb/picard/2.27.4-Java-13.0.2/picard.jar"

# Iterate over the BAM files in the input directory
for bam_file in "$input_dir"/*.bam; do
    # Extract the base filename without extension
    filename=$(basename "$bam_file" .bam)

    # Generate the output BAM filename with marked duplicates
    output_bam="$output_dir/$filename.marked_duplicates.bam"

    # Run Picard MarkDuplicates to mark duplicates in the BAM file
    java -jar "$picard_jar" MarkDuplicates \
        INPUT="$bam_file" \
        OUTPUT="$output_bam" \
        METRICS_FILE="$output_dir/$filename.marked_duplicates.metrics.txt" \
        VALIDATION_STRINGENCY=LENIENT
done


