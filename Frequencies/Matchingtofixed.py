def get_positions_from_vcf(vcf_file):
    positions = set()
    with open(vcf_file, 'r') as vcf:
        for line in vcf:
            if not line.startswith('#'):
                position = line.split('\t')[1]
                positions.add(position)
    return positions

def filter_vcf_by_positions(input_vcf, positions, output_vcf):
    with open(input_vcf, 'r') as vcf, open(output_vcf, 'w') as output:
        for line in vcf:
            if line.startswith('#') or line.split('\t')[1] in positions:
                output.write(line)

# Provide the paths to the VCF files
vcf1_file = 'thapxmm10_thapref.vcf'
vcf2_file = 'ERR1124330_1.marked_duplicates.with_read_groups.vcf'
output_file = 'matched-fixed-31.vcf'

# Get positions from the first VCF file
positions = get_positions_from_vcf(vcf1_file)

# Filter the second VCF file based on the positions
filter_vcf_by_positions(vcf2_file, positions, output_file)
