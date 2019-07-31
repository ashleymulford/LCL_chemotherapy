CEU_mult_dauno<-fread("/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_dauno_multixcan_wchr.txt")

genes<-select(CEU_mult_dauno, 1)
genes<-as.vector(unlist(genes))

CEU_mult_dauno<-select(CEU_mult_dauno, 2:13)

for (gene in genes) {
  gene<-substr(gene,0,15)
  if(exists("gene_list_fuma")){
    gene_list_fuma<-append(gene_list_fuma, gene)
  }
  else{
    gene_list_fuma<-c(gene)
  }
}

CEU_mult_dauno<-add_column(CEU_mult_dauno, gene = gene_list_fuma, .before = "pvalue")

CEU_mult_dauno_fdr15 <- subset(CEU_mult_dauno, pvalues_adjusted_fdr <= .15)
CEU_mult_dauno_fdr2 <- subset(CEU_mult_dauno, pvalues_adjusted_fdr <= .2)

fwrite(CEU_mult_dauno_fdr15, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_dauno_multixcan_fdr15_FUMA.txt", na = "NA", quote = F, sep = "\t", col.names = T)
fwrite(CEU_mult_dauno_fdr2, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_dauno_multixcan_fdr2_FUMA.txt", na = "NA", quote = F, sep = "\t", col.names = T)

