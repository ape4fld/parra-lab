library(tidyverse)
library(ggplot2)

setwd("C:/Users/etc-etc/")

# plot the log10(Bayes Factor) results for each region (Y axis; colored by LD).
# also works to plot the PIP instead, check out the comments on the script below to modify.

for (subset in 1:5) {   # change according to the number of susbsets you are plotting
  
  # read SNP file from FINEMAP results for each subset:
  snpfile <- read.csv(paste("subset",subset,".snp",sep=""), sep = " ", header = TRUE)
  
  snpfile <- filter(snpfile, prob >= 0)
  # extract the chromosome number:
  chr <- snpfile[1,3]  
  
  # read the local LD results computed on LDstore:
  ld <- read.csv(paste("subset",subset,".ld",sep=""), sep = " ", header = TRUE)
  
  # separate rsids and other columns to compute R-squared:
  snps <- colnames(ld[2:ncol(ld)])
  head(ld,n=2)
  name_tmp <- data.frame(ld[,1])
  ld_tmp <- data.frame(ld[,2:ncol(ld)]) 
  ld_tmp <- data.frame(lapply(ld_tmp,"^",2))

  # bind the tables back again:
  ld <- bind_cols(name_tmp, ld_tmp)
  
  # rename columns
  colnames(ld) <- c("rsid", snps)

  # join snp table and LD table:
  snp_plot <- left_join(snpfile, ld, by = "rsid")
  
  # get the label for the legend:
  rsq=expression(paste(r^2))

  # plot and save png:
  for (x in 1:length(snps)) {
   index <- snps[x]
  
   top <- filter(snp_plot, rsid == !!index)   # filter to retain only index SNP
   
   #### CHANGE THE FOLLOWING LINE FOR THE Y-AXIS TO: < y = "PIP" > if you want to plot the PIP instead.
   ggplot(snp_plot, aes_string(x = "position", colour = index, y = "log10bf")) + 
     scale_y_continuous() +  
     geom_point(colour = "black", size = 4, alpha = 7/10) +
     geom_point(aes_string(colour = index), size = 3.5, shape = 19, alpha = 7/10) + 
     scale_colour_stepsn(colours=c("blue2","deepskyblue","limegreen","orange2","#CC0000"), name=rsq, breaks=c(0.2, 0.4, 0.6, 0.8), labels=c("0.2","0.4","0.6","0.8")) +
     
     #### CHANGE THE FOLLOWING LINE FOR THE Y-AXIS TITLE TO < y = "PIP" > if you want to plot the PIP instead:
     guides(fill=FALSE) + labs( x = paste("Chromosome",chr,sep=" "), y = "log10(Bayes Factor)") +
     
     theme(axis.text.x = element_text(face="bold", size=12), axis.text.y = element_text(face="bold", size=14),
          axis.title.x = element_text(face="bold", size=15), axis.title.y = element_text(face="bold", size=15),
          legend.title = element_text(size=16, face="bold"), legend.text = element_text(size=12),
          panel.background = element_blank(), axis.line = element_line(color = "black"), legend.key=element_blank()) +

     geom_point(data = top, colour = "black", size = 7.4, shape = 18) + 
     geom_point(data=top, colour="#FFFF00", shape = 18, size = 6.5) +
     #### COMMENT THE FOLLOWING LINE IF PLOTTING THE PIP:
     geom_hline(yintercept=2, colour = "black", linetype="dashed")
   
     #### COMMENT THE FOLLOWING LINE IF PLOTTING THE PIP:
     ggsave(file=paste("path-to-save-plots/subset",subset,"-",snps[x],"-logBF.png", sep=""))
     #### COMMENT THE FOLLOWING LINE IF PLOTTING THE log10BF:
     # ggsave(file=paste("path-to-save-plots/subset",subset,"-",snps[x],"-PIP.png", sep=""))
  }
}
