install.packages("qqman")
install.packages("dplyr")
library(qqman)
library(dplyr)

# FUNCTION TO OBTAIN LAMBDA (GENOMIC CONTROL) AND QQPLOTS.
# IT USES ONE FILE (with header = TRUE): 
  #file_to_read1 = data frame with p-values only (output from post-gwas script)
# IT NEEDS AS INPUT THE FOLDER WHERE THIS FILE IS (path_to_folder argument)
# IT NEEDS AS INPUT A FILE NAME FOR SAVING THE PLOT (file_name argument)
#IT NEEDS AS INPUT THE Y COORDINATE TO OUTPUT THE LAMBDA VALUE IN THE PLOT.
# The lambda genomic control value will be pasted in the qqplot and printed in the screen.
# This function includes the installation of 2 packages: "dplyr" and "qqman".

post_gwas_plots <- function(path_to_folder, file_to_read1, file_name, lambda_pos) {
  
  setwd(path_to_folder)
  
  #read file1:
  p_values <- read.delim(file = file_to_read1, header = TRUE)
  colnames(p_values) <- "pvalue"

   #genomic control (lambda):
   chisq <- qchisq(1-p_values$pvalue,1)
   lambda_value <- median(chisq)/qchisq(0.5,1)
   lambda_value <- round(lambda_value, digits = 4)

   qq_filename <- paste("qqplot-", file_name, ".jpeg", sep="")

   #qqplot:
   jpeg(filename = qq_filename, width = 500, height = 500)
   qq(p_values$pvalue, cex.axis = 1.5)
   text(x = 1, y = lambda_pos, labels = paste("Lambda =", lambda_value, sep=" "))
   dev.off()
   
   print(lambda_value)
}
