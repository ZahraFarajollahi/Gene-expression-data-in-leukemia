library(ggplot2)

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

# creat an empty data frame
gene_pvalue_df = data.frame( )

# apply t test for each gene, between T-cell and B-cells
for (i in 1:22283) {
  gene_col = i
  t_test = t.test(x[x$sample =="T",gene_col],x[x$sample !="T",gene_col])
  gene_name = colnames(x[gene_col])
  gene_p_value= t_test$p.value 
  
  # add data to previous data frame
  gene_pvalue_df =rbind(gene_pvalue_df , data.frame(gene_name,gene_p_value )) 
}

# sort samples forom loest p-value to highest
sort_by_pvalue= gene_pvalue_df [order(gene_pvalue_df$gene_p_value),]

# plot and save p-value histogram
jpeg("p_value histogram.jpg")
ggplot(gene_pvalue_df, aes(gene_p_value))+ geom_histogram(binwidth = 0.00001) + coord_cartesian(xlim = c(0.00, 0.0001)) + 
  xlab("t test p values between T-cell & B-cell leukemia") + ylab("number of samples")
dev.off()
