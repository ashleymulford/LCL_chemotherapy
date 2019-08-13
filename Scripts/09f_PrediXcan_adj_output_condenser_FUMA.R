#Import necessasry libraries
library(data.table)
library(tibble)
library(dplyr)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of drugs for file input
drug_list <- c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

#Make a data frame with significant results
  #Read in file
  #Add column containing drug name
  #Subset for significance, threshold = .6
  #Compile significant subsets into single data frame
for(drug in drug_list){
  YRI_pred <- fread("/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_adjusted_" %&% drug %&% ".txt")
  YRI_pred<-add_column(YRI_pred, drug = drug, .before = "tissue")
  YRI_pred_significant<-subset(YRI_pred, pvalues_adjusted_fdr <= .6)
  if(exists("YRI_pred_sign6")){
    YRI_pred_sign6<-merge(x = YRI_pred_sign6, y = YRI_pred_significant, all = TRUE)
  }
  else{
    YRI_pred_sign6<-YRI_pred_significant
  }
}

#Pull out gene column and create vector
genes<-select(YRI_pred_sign6, 3)
genes<-as.vector(unlist(genes))

#Remove gene column from data frame
YRI_pred_sign6<-select(YRI_pred_sign6, 1:2, 4:18)

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
YRI_pred_sign6<-add_column(YRI_pred_sign6, gene = gene_list_fuma, .before = "drug")

#Pull out gene column and create vector (all genes tested)
genes_list<-select(YRI_pred, 1)
genes_list<-as.vector(unlist(genes_list))

#Create list of genes for FUMA
  #Create a substring of original gene name, leaving out everything after the decimal
for (gn in genes_list) {
  gn<-substr(gn,0,15)
  if(exists("gn_list_fuma")){
    gn_list_fuma<-append(gn_list_fuma, gn)
  }
  else{
    gn_list_fuma<-c(gn)
  }
}

#Turn list into data frame
gn_list_fuma<-as.data.frame(gn_list_fuma)

#Output data frame into directory
fwrite(gn_list_fuma, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_predixcan_genes_FUMA.txt", na = "NA", quote = F, sep = "\t", col.names = T)

#Subset again for significance, threshold = .3, .2, and .075
YRI_pred_sign3 <- subset(YRI_pred_sign6, pvalues_adjusted_fdr <= .3)
YRI_pred_sign2 <- subset(YRI_pred_sign6, pvalues_adjusted_fdr <= .2)
YRI_pred_sign075 <- subset(YRI_pred_sign6, pvalues_adjusted_fdr <= .075)

#Output data frames into directory
fwrite(YRI_pred_sign6, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_adj_condensed_fdr6", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(YRI_pred_sign3, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_adj_condensed_fdr3", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(YRI_pred_sign2, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_adj_condensed_fdr2", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(YRI_pred_sign075, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_adj_condensed_fdr075", na = "NA", quote = F, sep = "\t", col.names = T) 

