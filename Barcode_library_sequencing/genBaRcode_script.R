## Extraction of barcodes from plasmid library using genBaRcode ----

# the fastq file was pre-filtered with strict criteria for high quality sequences
# resulting file is stored in the folder fastq/plasmid_lib_filtered.fq.gz
# the file contains 24,519,506 reads with barcodes


# load library
library(genBaRcode)

# define the backbone (10 bases before and after the 30N barcode)
backbone <- "TCTAAATGCANNNNNNNNNNNNNNNNNNNNNNNNNNNNNNCTTTAAGACC"

# define source and result directory:
source_dir 
result_dir

# extracted barcodes will be saved into an S4 object

BC_data <- processingRawData(file_name = "plasmid_lib_filtered.fq.gz",
                             source_dir = source_dir,
                             results_dir = result_dir,
                             mismatch = 1, #to the backbone
                             min_score = 0,
                             min_reads = 0, #important, otherwise, automatic cutoff >2
                             label = "genBaRcode",
                             bc_backbone = backbone,
                             bc_backbone_label = "BC_1",
                             save_it = FALSE,
                             seqLogo = FALSE,
                             cpus = 1,
                             strategy = "sequential",
                             full_output = FALSE,
                             wobble_extraction = TRUE)

# get a glimpse on the data object
show(BC_data)

#save as R object
saveRDS(BC_data, file = "plasmid_lib_extracted_barcodes.RDS")

#load in the R object
BC_data <- readRDS(file = "plasmid_lib_extracted_barcodes.RDS")

#extract barcodes and their counts:
bc_table <- BC_data@reads
# exported as a csv file extracted_barcodes_plasmid.csv

## QC plots -----

# Frequencies
library(ggplot2)

freq <- plotReadFrequencies(BC_dat = BC_data)
freq + ggplot2::theme_classic()

# this is a demanding job to generate the plot
kirchen <- generateKirchenplot(BC_dat = BC_data)
kirchen + ggplot2::theme_classic()


# Lorenz curve and Gini coefficient

library(ineq)
ineq(bc_table$read_count,type="Gini")
lc_v <- Lc(bc_table$read_count)
plot(lc_v)

# Sequence logo

# generate a random sample of 100 000 barcodes and plot seqLogo plot

vector <- as.vector(sample(bc_table$barcode, 100000))
base_colors <- c("forestgreen", "darkred","royalblue", "orange","grey" )

plotSeqLogo(vector, colrs = base_colors)


# Hamming distance where within a sample, all sequences are compared to each other

library(dplyr)

l <- 1000

set.seed(123)
col_hd <- sample(bc_table$barcode, l)
row_hd <- col_hd


hd <- data.frame(matrix(NA, nrow = length(row_hd),
                        ncol = length(col_hd), dimnames = list(row_hd, col_hd)))

for (i_row in 1:length(row_hd)){
  for (j_col in 1:length(col_hd)){
    hd[i_row, j_col] <- sum(strsplit(rownames(hd)[i_row], "")[[1]] != strsplit(colnames(hd)[j_col], "")[[1]]) 
  }
}

heatmap(as.matrix(hd), Rowv = NA, Colv = NA)

library(pheatmap)
pheatmap(hd, 
         show_rownames = TRUE,
         show_colnames = FALSE, 
         treeheight_col = 0,
         treeheight_row = 0)

# Plot a histogram of calculated hamming distances 

hd_df <- data.frame()

for (i in 1:1000){
  step_df <- data.frame(values = c(hd[, i]))
  hd_df <- rbind(hd_df, step_df)
}
  
# there is a line of zeros in the matrix becuase barcodes are compare to themselves
# if all the zero Hamming distances come from this, there will be 1000 zeros:

hd_df |>
  filter(values < 15) |>
  summarise(n = n())

# this is correct so we filter these out from the dataset:

hd_df |>
  filter(values > 0) |>
  ggplot(aes( x= values))+
  geom_histogram(bins = 15, color="darkgrey", fill="grey")+
  theme_minimal()+
  xlim(0, NA)+
  xlab("Hamming distance")

