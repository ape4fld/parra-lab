## This function was adapted from: https://danielroelfs.com/blog/how-i-create-manhattan-plots-using-ggplot/

install.packages("readr")
install.packages("ggrepel")
install.packages("RColorBrewer")

library(readr)
library(ggrepel)
library(ggplot2)
library(dplyr)
library(RColorBrewer)

gg.manhattan <- function(path, df, threshold = 5e-8, colours = c("#E69F00", "#56B4E9"), ylims = c(0,100), title = ""){
  # read and format df
  setwd(path)
  df <- read.delim(file = df, header = TRUE, sep = " ", colClasses = c("character","integer", "numeric", "numeric"))
  colnames(df) <- c("SNP","CHR","BP","P")
  hlight <- filter(df, P <= threshold) %>% .[,1]
  df <- filter(df, P <= 0.1)
  df.tmp <- df %>% 
    
    # Compute chromosome size
    group_by(CHR) %>% 
    summarise(chr_len=max(BP)) %>% 
    
    # Calculate cumulative position of each chromosome
    mutate(tot=cumsum(chr_len)-chr_len) %>%
    select(-chr_len) %>%
    
    # Add this info to the initial dataset
    left_join(df, ., by=c("CHR"="CHR")) %>%
    
    # Add a cumulative position of each SNP
    arrange(CHR, BP) %>%
    mutate( BPcum=BP+tot) %>%
    
    # Add highlight and annotation information
    mutate( is_highlight=ifelse(SNP %in% hlight, "yes", "no"))
    # mutate( is_annotate=ifelse(P < threshold, "yes", "no"))
  
  # get chromosome center positions for x-axis
  axisdf <- df.tmp %>% group_by(CHR) %>% summarize(center=( max(BPcum) + min(BPcum) ) / 2 )
  
    ggplot(df.tmp, aes(x=BPcum, y=-log10(P))) +
    # Show all points
    geom_point(aes(color=as.factor(CHR)), alpha=0.8, size=2) +
    scale_color_manual(values = rep(col, 22 )) +
    
    # custom X axis:
    scale_x_continuous( label = axisdf$CHR, breaks= axisdf$center ) +
    scale_y_continuous(expand = c(0, 0), limits = ylims) + # expand=c(0,0)removes space between plot area and x axis 
    
    # add plot and axis titles
    ggtitle(paste0(title)) +
    labs(x = "Chromosome") +
    
    # add genome-wide significant line
    geom_hline(yintercept = -log10(threshold)) +
    
    # Add highlighted points
    geom_point(data=subset(df.tmp, is_highlight=="yes"), color="red", size=3) +
    
    # Add label using ggrepel to avoid overlapping
    geom_label_repel(data=df.tmp[df.tmp$is_annotate=="yes",], aes(label=as.factor(SNP), alpha=0.7), size=5, force=1.3) +
    
    # Custom the theme:
    theme_bw(base_size = 22) +
    theme( 
      plot.title = element_text(hjust = 0.5),
      legend.position="none",
      panel.border = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank()
    )
}
