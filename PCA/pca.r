# read the file
x1= read.delim("E:/denboer2009-expr.txt")
rownames(x1)= x1[,1]
x3 = x1[,-1]
x= as.data.frame(t(x3))

# read the lables
y= read.delim("E:/denboer2009-pheno (2).txt")
rownames(y)= y[,1]
y= y[,-1]

#compute principle components of gene expressions
pc = prcomp(x)

# plot & save most important pcs 
jpeg("PCA.jpg")
plot(pc) 
title(sub= "Most important principal components of ALL gene expression data")
dev.off()

# draw & save distribution of different samples among PC1 and PC2
pcx = data.frame(pc$x)
sample = y[,5]
jpeg("2d-pc-scaterplot.jpg")
ggplot(pcx, aes(PC1,PC2, color = sample)) + geom_point(size=3) + labs(caption =
                  "This plot shows the distribution of different samples among PC1 and PC2.
  It illustrates that PC1 & PC2 separate T-cell ALL from B-Cell ALL.
   It is obvious that linear classifiers work well with this mapping. ") +
  theme(plot.caption=element_text(hjust = -0.2))
dev.off()

# 3D scatterplot of PC1, PC2, AND PC3
plot3d(pcx[,1:3], type= 's', col = y[,6], size= 2)
