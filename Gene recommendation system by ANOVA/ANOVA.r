
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

#anova
#A function for culculating ANOVA
AOV= function(Gene){
  Q= x[,c(Gene , "sample")]
  colnames(Q)[1] = "Gene"
  anova(aov( Gene~sample, Q))[1,5]
}

# Apply ANOVA to all genes
Genes = colnames(x)
Genes = Genes[-length(Genes)]  # remove last lable coolumn
sapply_anova = (sapply(Genes , AOV))
sapply_anova_df = data.frame(Genes,sapply_anova)

#sort results by p value
sort_by_pvalue_anova = sapply_anova_df[order(sapply_anova_df$sapply_anova),]
