# Goal : creat reliable + high quality denovo contigs using mid6 454 and 7k and 10k
#

# Convert reads.sff to reads.fastq
# sff_info -seq file_name > filename_seq.fasta && sff_info -qual file_name > filename_score.fasta
# fastatofastq

# Open reads.fastq

# Find total nucls
# Find avg read length
# Calculate coverage (C= (Read.avg_length * Read.count)/ Orignial_size)
# Determine number of reads for 5x 10x 15x 20x 25x 30x 35x 40x
# For each coverage X assemble with 7k.screen.fastq and 10k.screen.fastq
# Save passed in reads as file
# Organize into array pull out Largest_contig.length, N50
# For each coverage X repeat randomly 10 to 1000 times
