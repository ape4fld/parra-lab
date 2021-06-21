# Example to generate a Miami plot using the ggplot2 package.
# The function can highlight in red and annotate significant genes.

setwd("C:/Users/etc-etc")

library(here)
library(tidyverse)

homedir = here()

# Import function to plot Miami plot with ggplot:
source(here("path-to-function", "ggmiami-function.R"))

# The default colours in the function are grey and black, but can change them by changing the values for 'mypalette':
mypalette <- c("#000000", "#999999")

# Enter the number of genes tested to calculate the p-value threshold:
number_genes = 3998

# Calculate the significant threshold (do not modify the following line):
sig_thres = -1*log10(0.05/number_genes)

# Suffix name for the output miami plot:
name_plot = "mypheno"
man_filename <- paste("miami-TWAS-", name_plot, sep="") # do not need to change this line

# Optional: list of significant genes in a text file (one per row, same name as in 'df') to highlight and annotate in the plot:
mygenes <- read.table(here("path-to-list-of-genes", "my-significant-genes.txt"), 
                      header=F, colClasses = "character") %>% .[,]

gg.miami(path = paste(home_dir,"/path-to-data/",sep=""), 
  df = "TWAS-results.out", # The TWAS results should be in a text file with 4 columns with header: ID (gene), CHR, P0 (position), TWAS.Z, separated by whitespace (sep = " ")
  hlight = mygenes, # optional: list of significant genes, default = NA
  colours = mypalette, # default is black and grey
  ylims = c(-30,30),  # default is c(-20,20)
  title = "my GWAS")  # default is no title
ggsave(file=paste(man_filename,".png", sep=""))


