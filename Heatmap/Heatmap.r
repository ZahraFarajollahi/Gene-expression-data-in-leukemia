# read the file
x1= read.delim("E:/denboer2009-expr.txt")
rownames(x1)= x1[,1]
x3 = x1[,-1]
x= as.data.frame(t(x3))

# plot & save heatmap
jpeg("Heatmap.jpg")
pheatmap(x)
dev.off
