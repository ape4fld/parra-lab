setwd("C:/Users/")

#install.packages("here")
library(here)

source(here("path-where-the-function-is-saved/", "qqplot-function.R"))

post_gwas_plots(path_to_folder = "path-to-directory", 
                file_to_read1 = "meta-pheno-pval.out", 
                file_name = "meta-pheno", lambda_pos = 10)
