#Import necessasry libraries
library(data.table)
library(tibble)
library(dplyr)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of drugs for file input
#For ALL: no cis, etop, or pacl, nothing significant, will break script if included in list
drug_list <- c("arac", "cape", "carbo", "dauno", "peme")

#Make a data frame with significant results
  #Read in file
  #Add column containing drug name
  #Subset for significance, threshold = BH<.45
  #Compile significant subsets into single data frame
for(drug in drug_list){
  ALL_mult <- fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_output/ALL_" %&% drug %&% "_multixcan_bonferroni_wchr.txt")
  ALL_mult<-select(ALL_mult, 1:9, 11:13)
  ALL_mult<-na.omit(ALL_mult)
  ALL_mult<-add_column(ALL_mult, drug = drug, .before = "pvalue")
  ALL_mult_significant<-subset(ALL_mult, pvalues_adjusted_BH < .45)
  if(exists("ALL_mult_sign")){
    ALL_mult_sign<-merge(x = ALL_mult_sign, y = ALL_mult_significant, all = TRUE)
  }
  else{
    ALL_mult_sign<-ALL_mult_significant
  }
}

#Pull out gene column and create vector (significant genes only)
genes<-select(ALL_mult_sign, 1)
genes<-as.vector(unlist(genes))

#Remove gene column from data frame
ALL_mult_sign<-select(ALL_mult_sign, 2:13)

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
ALL_mult_sign<-add_column(ALL_mult_sign, gene = gene_list_fuma, .before = "drug")

#Pull out gene column and create vector (all genes tested)
genes_list<-select(ALL_mult, 1)
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

#Output data frames into directory
fwrite(ALL_mult_sign, "/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_output/ALL_multixcan_BH_FUMA", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(gn_list_fuma, "/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_output/ALL_multixcan_genes_FUMA.txt", na = "NA", quote = F, sep = "\t", col.names = T)
