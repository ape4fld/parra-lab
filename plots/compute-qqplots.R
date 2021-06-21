# Example to run on your Rstudio

setwd("C:/Users/")

#install.packages("here")   # Info about the here() package: https://github.com/jennybc/here_here
library(here)

# Import the function:
source(here("path-where-the-function-is-saved/", "qqplot-function.R"))

# Run the function to generate and save a qqplot
#### path_to_folder: path where the data is saved.
#### file_to_read1: text file with one column (no header) of p-values.
#### file_name: suffix of choice for the plot's name.
#### lambda_pos: position of the lambda value on the Y-axis in the qqplot.

post_gwas_plots(path_to_folder = "path-to-directory", 
                file_to_read1 = "meta-pheno-pval.out", 
                file_name = "meta-pheno", lambda_pos = 10)
