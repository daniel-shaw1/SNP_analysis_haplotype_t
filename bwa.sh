#!/bin/bash
#SBATCH --job-name=bwa_alignment_thap
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=100gb
#SBATCH --time=96:00:00
#SBATCH --output=thap.%j.out
#SBATCH --error=thap.%j.err

cd $SLURM_SUBMIT_DIR

ml BWA/0.7.17-GCC-10.3.0
export ref="tw5_HiFiONT_defaultctgs_25kbNs_norm.fa.masked.gz"
export outDir="."

# Iterate over each read 1 file
for read1_file in *1P*; do
    # Get the read name without the suffix
    read_name="${read1_file%_1P*}"

    # Set the output SAM file path based on the read name
    output_sam="${outDir}/${read_name}.sam"

    # Find the corresponding read 2 file
    read2_file="${read_name}_2P.fastq.gz"

    # Align the paired-end reads to the reference genome using BWA-MEM
    bwa mem -t 4 "$ref" "$read1_file" "$read2_file" > "$output_sam"

    echo "Alignment complete for $read_name"
done
