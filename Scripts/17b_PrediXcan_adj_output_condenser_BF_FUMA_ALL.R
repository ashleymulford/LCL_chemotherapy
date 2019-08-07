#Import necessasry libraries
library(data.table)
library(tibble)
library(dplyr)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of drugs for file input
#For ALL: no carbo, dauno, or pacl, nothing significant, will break script if included in list
drug_list <- c("arac", "cape", "cis", "etop", "peme")

#Make a data frame with significant results
  #Read in file
  #Add column containing drug name
  #Subset for significance, threshold = BF<1
  #Compile significant subsets into single data frame
for(drug in drug_list){
  ALL_pred <- fread("/home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_output_combined/ALL_assoc_adjusted_bonferroni_" %&% drug %&% ".txt")
  ALL_pred<-add_column(ALL_pred, drug = drug, .before = "tissue")
  ALL_pred_significant<-subset(ALL_pred, pvalues_adjusted_BF < 1)
  if(exists("ALL_pred_sign")){
    ALL_pred_sign<-merge(x = ALL_pred_sign, y = ALL_pred_significant, all = TRUE)
  }
  else{
    ALL_pred_sign<-ALL_pred_significant
  }
}

#Pull out gene column and create vector
genes<-select(ALL_pred_sign, 3)
genes<-as.vector(unlist(genes))

#Remove gene column from data frame
ALL_pred_sign<-select(ALL_pred_sign, 1:2, 4:18)

#Create list of genes for column in data frame with significant results
  #Create a substring of original gene name, leaving out everything after the decimal (for FUMA input)
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
ALL_pred_sign<-add_column(ALL_pred_sign, gene = gene_list_fuma, .before = "drug")

#Pull out gene column and create vector
genes_list<-select(ALL_pred, 3)
genes_list<-as.vector(unlist(genes_list))

#Create list of background gene names for FUMA
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

#Convert list to single-column data frame
gn_list_fuma<-as.data.frame(gn_list_fuma)

#Output data frames into directory
fwrite(ALL_pred_sign, "/home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_output_combined/ALL_assoc_adj_bonferroni_FUMA", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(gn_list_fuma, "/home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_output_combined/ALL_predixcan_genes_FUMA", na = "NA", quote = F, sep = "\t", col.names = T)

