#Import necessasry libraries
library(data.table)
library(tibble)
library(dplyr)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of drugs for file input
#For YRI: no etop, no significant, will break script
drug_list <- c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

#Make a data frame with significant results
  #Read in file
  #Add column containing drug name
  #Subset for significance, threshold = BF<1
  #Compile significant subsets into single data frame
for(drug in drug_list){
  YRI_mult <- fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_" %&% drug %&% "_multixcan_bonferroni_wchr.txt")
  YRI_mult<-select(YRI_mult, 1:9, 11:13)
  YRI_mult<-na.omit(YRI_mult)
  YRI_mult<-add_column(YRI_mult, drug = drug, .before = "pvalue")
  YRI_mult_significant<-subset(YRI_mult, pvalues_adjusted_BF < 1)
  if(exists("YRI_mult_sign")){
    YRI_mult_sign<-merge(x = YRI_mult_sign, y = YRI_mult_significant, all = TRUE)
  }
  else{
    YRI_mult_sign<-YRI_mult_significant
  }
}

#Pull out gene column and create vector (significant genes only)
genes<-select(YRI_mult_sign, 1)
genes<-as.vector(unlist(genes))

#Remove gene column from data frame
YRI_mult_sign<-select(YRI_mult_sign, 2:13)

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
YRI_mult_sign<-add_column(YRI_mult_sign, gene = gene_list_fuma, .before = "drug")

#Output data frame into directory
fwrite(YRI_mult_sign, "/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_bonferroni_FUMA", na = "NA", quote = F, sep = "\t", col.names = T) 

#Pull out gene column and create vector (all genes tested)
genes_list<-select(YRI_mult, 1)
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
fwrite(gn_list_fuma, "/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_genes_FUMA.txt", na = "NA", quote = F, sep = "\t", col.names = T)


