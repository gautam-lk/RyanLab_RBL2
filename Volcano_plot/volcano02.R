#https://biocorecrg.github.io/CRG_RIntroduction/volcano-plots.html

library("ggplot2")
library(ggrepel)

## DGE_MCI_RBL2_all_Volcano #

# The basic scatter plot: x is "log2FoldChange", y is "pvalue"
read.csv("DGE_MCI_RBL2_all.csv")
de<- read.csv("DGE_MCI_RBL2_all.csv")
ggplot(data=de, aes(x=log2FoldChange, y=pvalue)) + geom_point()
# Convert directly in the aes()
p <- ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue))) + geom_point()
# Add more simple "theme"
p <- ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue))) + geom_point() + theme_minimal()
# Add vertical lines for log2FoldChange thresholds, and one horizontal line for the p-value threshold 
p2 <- p + geom_vline(xintercept=c(-2.0, 2.0), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

# The significantly differentially expressed genes are the ones found in the upper-left and upper-right corners.
# Add a column to the data frame to specify if they are UP- or DOWN- regulated (log2FoldChange respectively positive or negative)

# add a column of NAs
de$diffexpressed <- "NO"
# if log2Foldchange > 2.0 and pvalue < 0.05, set as "UP" 
de$diffexpressed[de$log2FoldChange > 2.0 & de$pvalue < 0.05] <- "UP"
# if log2Foldchange < -2.0 and pvalue < 0.05, set as "DOWN"
de$diffexpressed[de$log2FoldChange < -2.0 & de$pvalue < 0.05] <- "DOWN"

# Re-plot but this time color the points with "diffexpressed"
p <- ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed)) + geom_point() + theme_minimal()

# Add lines as before...
p2 <- p + geom_vline(xintercept=c(-2.0, 2.0), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

## Change point color 

# 1. by default, it is assigned to the categories in an alphabetical order):
p3 <- p2 + scale_color_manual(values=c("blue", "black", "red"))

# 2. to automate a bit: ceate a named vector: the values are the colors to be used, the names are the categories they will be assigned to:
mycolors <- c("blue", "red", "black")
names(mycolors) <- c("DOWN", "UP", "NO")
p3 <- p2 + scale_colour_manual(values = mycolors)

# Now write down the name of genes beside the points...
# Create a new column "delabel" to de, that will contain the name of genes differentially expressed (NA in case they are not)

ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed, label=delabel)) + 
  geom_point() + 
  theme_minimal() +
  geom_text()
# Finally, we can organize the labels nicely using the "ggrepel" package and the geom_text_repel() function
# load library
# plot adding up all layers we have seen so far
ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed, label=delabel)) +
  geom_point() + 
  theme_minimal() +
  geom_text_repel() +
  scale_color_manual(values=c("blue", "black", "red")) +
  geom_vline(xintercept=c(-2.0, 2.0), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

ggsave(filename="DGE_MCI_RBL2_all_Volcano.tiff", 
       width = 20, 
       height = 20, 
       units = "cm")


## DGE_MCI CTRL_all_Volcano ##


# The basic scatter plot: x is "log2FoldChange", y is "pvalue"
read.csv("DGE_MCI_CTRL_all.csv")
de<- read.csv("DGE_MCI_CTRL_all.csv")
ggplot(data=de, aes(x=log2FoldChange, y=pvalue)) + geom_point()
# Convert directly in the aes()
p <- ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue))) + geom_point()
# Add more simple "theme"
p <- ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue))) + geom_point() + theme_minimal()
# Add vertical lines for log2FoldChange thresholds, and one horizontal line for the p-value threshold 
p2 <- p + geom_vline(xintercept=c(-2.0, 2.0), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

# The significantly differentially expressed genes are the ones found in the upper-left and upper-right corners.
# Add a column to the data frame to specify if they are UP- or DOWN- regulated (log2FoldChange respectively positive or negative)

# add a column of NAs
de$diffexpressed <- "NO"
# if log2Foldchange > 2.0 and pvalue < 0.05, set as "UP" 
de$diffexpressed[de$log2FoldChange > 2.0 & de$pvalue < 0.05] <- "UP"
# if log2Foldchange < -2.0 and pvalue < 0.05, set as "DOWN"
de$diffexpressed[de$log2FoldChange < -2.0 & de$pvalue < 0.05] <- "DOWN"

# Re-plot but this time color the points with "diffexpressed"
p <- ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed)) + geom_point() + theme_minimal()

# Add lines as before...
p2 <- p + geom_vline(xintercept=c(-2.0, 2.0), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

## Change point color 

# 1. by default, it is assigned to the categories in an alphabetical order):
p3 <- p2 + scale_color_manual(values=c("blue", "black", "red"))

# 2. to automate a bit: ceate a named vector: the values are the colors to be used, the names are the categories they will be assigned to:
mycolors <- c("blue", "red", "black")
names(mycolors) <- c("DOWN", "UP", "NO")
p3 <- p2 + scale_colour_manual(values = mycolors)

# Now write down the name of genes beside the points...
# Create a new column "delabel" to de, that will contain the name of genes differentially expressed (NA in case they are not)


ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed, label=delabel)) + 
  geom_point() + 
  theme_minimal() +
  geom_text()
# Finally, we can organize the labels nicely using the "ggrepel" package and the geom_text_repel() function
# load library
# plot adding up all layers we have seen so far
ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed, label=delabel)) +
  geom_point() + 
  theme_minimal() +
  geom_text_repel() +
  scale_color_manual(values=c("blue", "black", "red")) +
  geom_vline(xintercept=c(-2.0, 2.0), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

ggsave(filename="DGE_MCI_CTRL_all_Volcano.tiff", 
       width = 20, 
       height = 20, 
       units = "cm")

## DGE_MCI_E2F4_all_Volcano ##

# The basic scatter plot: x is "log2FoldChange", y is "pvalue"
read.csv("DGE_MCI_RBL2_all.csv")
de<- read.csv("DGE_MCI_E2F4_all.csv")
ggplot(data=de, aes(x=log2FoldChange, y=pvalue)) + geom_point()
# Convert directly in the aes()
p <- ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue))) + geom_point()
# Add more simple "theme"
p <- ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue))) + geom_point() + theme_minimal()
# Add vertical lines for log2FoldChange thresholds, and one horizontal line for the p-value threshold 
p2 <- p + geom_vline(xintercept=c(-2.0, 2.0), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

# The significantly differentially expressed genes are the ones found in the upper-left and upper-right corners.
# Add a column to the data frame to specify if they are UP- or DOWN- regulated (log2FoldChange respectively positive or negative)

# add a column of NAs
de$diffexpressed <- "NO"
# if log2Foldchange > 2.0 and pvalue < 0.05, set as "UP" 
de$diffexpressed[de$log2FoldChange > 2.0 & de$pvalue < 0.05] <- "UP"
# if log2Foldchange < -2.0 and pvalue < 0.05, set as "DOWN"
de$diffexpressed[de$log2FoldChange < -2.0 & de$pvalue < 0.05] <- "DOWN"

# Re-plot but this time color the points with "diffexpressed"
p <- ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed)) + geom_point() + theme_minimal()

# Add lines as before...
p2 <- p + geom_vline(xintercept=c(-2.0, 2.0), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

## Change point color 

# 1. by default, it is assigned to the categories in an alphabetical order):
p3 <- p2 + scale_color_manual(values=c("blue", "black", "red"))

# 2. to automate a bit: ceate a named vector: the values are the colors to be used, the names are the categories they will be assigned to:
mycolors <- c("blue", "red", "black")
names(mycolors) <- c("DOWN", "UP", "NO")
p3 <- p2 + scale_colour_manual(values = mycolors)

# Now write down the name of genes beside the points...
# Create a new column "delabel" to de, that will contain the name of genes differentially expressed (NA in case they are not)

ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed, label=delabel)) + 
  geom_point() + 
  theme_minimal() +
  geom_text()
# Finally, we can organize the labels nicely using the "ggrepel" package and the geom_text_repel() function
# load library
# plot adding up all layers we have seen so far
ggplot(data=de, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed, label=delabel)) +
  geom_point() + 
  theme_minimal() +
  geom_text_repel() +
  scale_color_manual(values=c("blue", "black", "red")) +
  geom_vline(xintercept=c(-2.0, 2.0), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

ggsave(filename="DGE_MCI_E2F4_all_Volcano.tiff", 
       width = 20, 
       height = 20, 
       units = "cm")
