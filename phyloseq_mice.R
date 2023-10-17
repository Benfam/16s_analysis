
# Install Library ---------------------------------------------------------
library(dplyr)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("phyloseq") # Install phyloseq

install.packages(c("RColorBrewer", "patchwork")) #install patchwork to chart publication-quality plots and readr to read rectangular datasets.
# Fetch data from repo ----------------------------------------------------
# OTU data
fturl <- 
  "https://raw.githubusercontent.com/quadram-institute-bioscience/datasciencegroup/main/2_rarefaction/table.csv"
feat <- read.csv(fturl, header=T, sep = ',', row.names = 1)

# TAX
tax <- read.csv("https://raw.githubusercontent.com/quadram-institute-bioscience/datasciencegroup/main/2_rarefaction/taxonomy.csv", 
                header=T, sep = ',', row.names = 1)

# Metadata
metadata <- read.csv("https://raw.githubusercontent.com/quadram-institute-bioscience/datasciencegroup/main/2_rarefaction/metadata.csv",
                     header=T, sep = ',')

# Data Preprocessing ------------------------------------------------------

# We remove taxa with low counts

row_mean_df = data.frame(x_name = row.names(feat), mean_value = apply(feat, 1, 
                                                                      mean))
row_mean_df %>% 
  filter(mean_value > 10) %>% 
  row.names() -> selected_gene

feat <- feat[selected_gene,]

# Convert dataframe into phyloseq Objects ---------------------------------

library("phyloseq")
OTU = otu_table(feat, taxa_are_rows = TRUE)
TAX = tax_table(tax)
# Perform data manipulation
colnames(TAX@.Data) <- c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species")
row.names(TAX@.Data) <- row.names(tax)


# create a phyloseq-expriment data 
physeq = phyloseq(OTU, TAX)

# Create visualization 

plot_bar(physeq, fill = "Phylum")

# Create random pyhlogenetic tree
library("ape")
random_tree = rtree(ntaxa(physeq), rooted=TRUE, tip.label=taxa_names(physeq))
plot(random_tree)

# Merge the object with metadata
physeq1 = merge_phyloseq(physeq, metadata, random_tree)



physeq2 = phyloseq(OTU, TAX, metadata, random_tree)

plot_tree(physeq2, color="Location", label.tips="taxa_names",
          ladderize="left", plot.margin=0.3)

physeq2

plot_heatmap(physeq1, high = '#ef0029', low = '#0029ef')
