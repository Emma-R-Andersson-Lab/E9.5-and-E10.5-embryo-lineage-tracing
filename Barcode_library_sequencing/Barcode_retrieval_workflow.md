## Barcode retrieval and analysis workflow

### Notes on library preparation

The plasmid DNA-seq library was constructed by amplifying the barcode region with primers designed to the adjacent plasmid sequences, adding adaptors and indeces necessary for Illumina NextSeq550 platfom sequencing. To circumvent the problems with DNA amplicon sequencing, phased primers were used to construct the library. Read 1 was set to 100 nt, read 2 to 50 nt. Only read 1 was considered for further analysis.

### Fastq file pre-processing

Sequencing output **plasmid_lib_R1.fastq.gz** was processed with Cutadapt (version 4.0) with Python 3.9.5 to select reads that contain 30N barcode with 10 nt flanking conserved sequences on each side, reducing thus the length of the read to the most informative region (50N).

Cutadapt command line parameters: -g GAGGAAAG...AATGACTT --max-expected-errors=1 --discard-untrimmed --minimum-length=50 --maximum-length=50

The resulting trimmed file **plasmid_lib_50nt.fq.gz** was processed in R with **seqTools** library with he function *trimFastq* to discard the reads where more than two bases have quality below 15 and thus filter for high-quality reads. See ```filter_reads.R```. 

### Barcode extraction 

Barcodes were retrieved from the filtered file with **GenBaRcode** package i R.
The script ```GenBaRcode_script.R``` also contains preliminary QC plots. 
The used packages were recorded in the text file ```R_session_info.txt```.

The output file is saved as ```extracted_barcodes_plasmid.csv``` which contains a list of retrieved barcodes and their count.

### Barcode analysis

Extracted barcodes were further analyzed using the ```library_quality_control.py``` in Python.

### Depostited files at Zenodo

The raw sequencing file **plasmid_lib_R1.fastq.gz** and extracted barcodes with their counts **extracted_barcodes_plasmid.csv** are available for download at https://doi.org/10.5281/zenodo.14223944.
