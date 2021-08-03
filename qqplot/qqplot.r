library(car)

# read the file
x1= read.delim("E:/denboer2009-expr.txt")
rownames(x1)= x1[,1]
x3 = x1[,-1]
x= as.data.frame(t(x3))

# read the lables
y= read.delim("E:/denboer2009-pheno (2).txt")
rownames(y)= y[,1]
y= y[,-1]

# add lables to data as a column
x$sample = substr(y[,5],1,190)


#qqplot
# create a data from a gen and lables and select only T-All 
selectedgene = x[c("CD3D|213539_at" , "sample")]
selectTlable = selectedgene[selectedgene$sample== "T",]
# select the gen column only and run qqplot and save it to analyse if data has Normal distribution
jpeg("qqnorm_CD3D_T_ALL.jpg")  
qqPlot(selectTlable[,1],col.lines = "purple" , ylab = "CD3D Gene" , main =
         " qqnorm for CD3D gene in pationts with T-ALL")
dev.off()

# create a data from a gen and lables and select subtypes of B-ALL
selectedgene = x[c("CD3D|213539_at" , "sample")]
selectOtherlable = selectedgene[selectedgene$sample != "T",]
# select the gen column only and run qqplot and save it to analyse if data has Normal distribution
jpeg("qqnorm_CD3D_B_ALL.jpg")  
qqPlot(selectOtherlable[,1] , ylab = "CD3D Gene" , main =
         " qqnorm for CD3D gene in pationts with B-ALL subtypes")
dev.off()

# qqplot and save for CD3D gene through T-ALL and B-ALL pationts
jpeg("qqplot_CD3D Gene_T-ALL and B-ALL pationts.jpg")
qqplot(selectTlable[,1] , selectOtherlable[,1], plot.it = TRUE,
       xlab = " CD3D gene with T lable",
       ylab = " CD3D gene with other lables",
       main = "qqplot for CD3D gene through T-ALL and B-ALL pationts")
dev.off()
