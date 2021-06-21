# Example to generate a Manhattan plot using the ggplot2 package.
# The function highlights in red SNPs that surpass the indicated threshold and draws a horizontal line on the threshold.

setwd("C:/Users/frida/Dropbox")

#install.packages("here")
library(here)

# Import the function:
source(here("your-path-where-the-function-is", "ggmanhattan-function.R"))

# Define home_dir:
home_dir=here()  # do not need to change this line

# Select a colour palette for the chromosomes:
# Other colour options here: http://sape.inf.usi.ch/quick-reference/ggplot2/colour
mypalette <- c("#E69F00", "#56B4E9") # (default is blue and yellow)

# The function plots a horizontal line, usually indicating a genome-wide significant threshold.
# Here select the Y-axis value for the threshold, if different from default (5e-8):
threshold = 5e-8

# Suffix name for the output saved manhattan plot:
name_plot = "mypheno"
man_filename <- paste("manhattan-gwas-", name_plot, sep="") # do not need to change this line

# Run the function:
gg.manhattan(path = home_dir, # can modify if need to change the path for where the data is
             df = "gwas-pheno-clean2.out", # text file, separated by white space (sep= " "), with 4 columns: SNP, CHR, POS, PVALUE, in that order with header, but does not need to have a spefic header.
             threshold = 1e-6, # if not indicated, default = 5e-8
             colours = mypalette, # if not indicated, default = blue and yellow
             ylims = c(0,15), # if not indicated, default = c(0,100)
             title = "my GWAS") # if not indicated, no title
ggsave(file=paste(man_filename,".png", sep=""))
