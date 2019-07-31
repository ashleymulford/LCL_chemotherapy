#Read in file
CEU_mult_dauno<-fread("/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_dauno_multixcan_wchr.txt")

#Pull out gene column and create vector
genes<-select(CEU_mult_dauno, 1)
genes<-as.vector(unlist(genes))

#Remove gene column from data frame
CEU_mult_dauno<-select(CEU_mult_dauno, 2:13)

#Create list of gene names for FUMA
  #Create a substring of original gene name, leaving out everything after the decimal
for (gene in genes) {
  gene<-substr(gene,0,15)
  if(exists("gene_list_fuma")){
    gene_list_fuma<-append(gene_list_fuma, gene)
  }
  else{
    gene_list_fuma<-c(gene)
  }
}

#Add new gene column to data frame
CEU_mult_dauno<-add_column(CEU_mult_dauno, gene = gene_list_fuma, .before = "pvalue")

#Subset for significance, threshold = .3, .2, and .15
CEU_mult_dauno_fdr15 <- subset(CEU_mult_dauno, pvalues_adjusted_fdr <= .15)
CEU_mult_dauno_fdr2 <- subset(CEU_mult_dauno, pvalues_adjusted_fdr <= .2)
CEU_mult_dauno_fdr3 <- subset(CEU_mult_dauno, pvalues_adjusted_fdr <= .3)

#Output data frames into directory
fwrite(CEU_mult_dauno_fdr15, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_dauno_multixcan_fdr15_FUMA.txt", na = "NA", quote = F, sep = "\t", col.names = T)
fwrite(CEU_mult_dauno_fdr2, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_dauno_multixcan_fdr2_FUMA.txt", na = "NA", quote = F, sep = "\t", col.names = T)
fwrite(CEU_mult_dauno_fdr3, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_dauno_multixcan_fdr3_FUMA.txt", na = "NA", quote = F, sep = "\t", col.names = T)

