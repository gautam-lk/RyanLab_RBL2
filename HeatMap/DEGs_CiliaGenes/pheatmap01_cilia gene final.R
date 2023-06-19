setwd("C:/Users/lgautam/Desktop/HeaMap_RBL_gene")
getwd()
library(pheatmap)
library(grid)
library(ggplot2)
library(matrixStats)
library(tidyverse)
data <-read.csv('cilia_gene_Heatmap.csv')
dim(data)
head(data)
data1 <- as.matrix(data[,-1])
rownames(data1) <- data[,1]
pheatmap(data1)
pheatmap(log2(data1 +1), scale = 'row')
pheatmap(log2(data1 +1), scale = 'row', row.names = TRUE)
pheatmap(log2(data1 +1), scale = 'row', row.names = TRUE, treeheight_row = 20)


get_plot_dims <- function(heat_map)
{
  plot_height <- sum(sapply(heat_map$gtable$heights, grid::convertHeight, "in"))
  plot_width  <- sum(sapply(heat_map$gtable$widths, grid::convertWidth, "in"))
  return(list(height = plot_height, width = plot_width))
}




my_plot <- pheatmap(data1,scale="row", cellheight = 8)
plot_dims <- get_plot_dims(my_plot)
tiff("plot000.tiff", height = plot_dims$height, width = plot_dims$width, units = "in", res = 72)
my_plot
dev.off()


