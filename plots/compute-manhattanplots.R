# Example to generate a Manhattan plot using the ggplot2 package.
# The function highlights in red SNPs that surpass the indicated threshold and draws a horizontal line on the threshold.

setwd("C:/Users/etc-etc")

#install.packages("here")
library(here)

# Import the function:
source(here("path-for-the-function", "ggmanhattan-function.R"))

# Define home_dir:
home_dir=here()  # do not need to change this line

# Select a colour palette for the chromosomes:
# Other colour options here: http://sape.inf.usi.ch/quick-reference/ggplot2/colour
mypalette <- c("#E69F00", "#56B4E9") # (default is blue and yellow)

# Suffix name for the output manhattan plot:
name_plot = "mypheno"
man_filename <- paste("manhattan-TWAS-", name_plot, sep="") # do not need to change this line

# Run the function:
gg.manhattan(path = paste(home_dir,"/CPTP-data/GWAS/SAIGE/meta-SAIGE-BGEN/",sep=""), # can modify if need to change the path for where the data is
             df = "meta-HC-M1-short.out", # text file, separated by white space (sep= " "), with 4 columns: SNP, CHR, POS, PVALUE, in that order with header, but does not need to have a spefic header.
             threshold = 1e-6, # Y-axis level to plot a horizontal line to delimit threshold (default = 5e-8)
             colours = mypalette, # default = blue and yellow
             ylims = c(0,90), # default = c(0,100)
             title = "my GWAS") # default no title
ggsave(file=paste(man_filename,".png", sep=""))
