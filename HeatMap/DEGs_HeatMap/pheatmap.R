setwd("C:/Users/lgautam/Desktop/data_heatmap/AIO")
getwd()
library(pheatmap)
library(grid)
library(ggplot2)
library(matrixStats)
library(tidyverse)
data <-read.csv('all_in_one_file.csv')
dim(data)
head(data)
data1 <- as.matrix(data[,-1])
rownames(data1) <- data[,1]
pheatmap(data1)
pheatmap(log2(data1 +1), scale = 'row')
pheatmap(log2(data1 +1), scale = 'row', row.names = TRUE)
my_plot <- pheatmap(log2(data1 +1), scale = 'row', row.names = F, show_rownames = F, treeheight_row = 50)

#Cut the heatmap to pieces
my_plot <- pheatmap(log2(data1 +1), scale = 'row', row.names = F, show_rownames = F, treeheight_row = 100, cutree_rows = 6, cutree_cols = )

plot_dims <- get_plot_dims(my_plot)
png("AIO_plot_01_1.png", res = 72)




out <- pheatmap(data1, 
                show_rownames=F, cluster_cols=T, cluster_rows=T, scale="row",
                cex=1, clustering_distance_rows="euclidean", cex=1,
                clustering_distance_cols="euclidean", clustering_method="complete", border_color=FALSE,
                annotation_col=metadata,
                annotation_row=metadata_gene)