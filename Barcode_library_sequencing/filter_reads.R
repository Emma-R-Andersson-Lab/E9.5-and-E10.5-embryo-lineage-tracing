# Filter trimmed fastq reads for the base quality (reducing sequencing errors)

# Load the library
library(seqTools)

# Discard the sequences where more than two bases have quality below 15:

trimFastq("plasmid_lib_50nt.fq.gz",
          outfile="filtered.fq.gz", discard="discarded.fq.gz",
          qualDiscard = 15)

## Results:
#[trimFastq]    24519506 records written to outfile.
#[trimFastq]    55500238 records written to discard.
