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

#wilcox test
# creat an empty data frame
wilcoxdata = data.frame( )

# apply t test for each gene, between T-cell and B-cells
for (i in 1:22283) {
  gene_col = i
  wilcoxtest = wilcox.test(x[x$sample =="T",gene_col],x[x$sample !="T",gene_col])
  gene_name = colnames(x[gene_col])
  gene_p_value_w= wilcoxtest$p.value 
  
  # add data to previous data frame
  wilcoxdata =rbind(wilcoxdata , data.frame(gene_name,gene_p_value_w ))
}

# sort samples forom loest p-value to highest
sort_by_pvalue_w= wilcoxdata [order(wilcoxdata$gene_p_value),]
