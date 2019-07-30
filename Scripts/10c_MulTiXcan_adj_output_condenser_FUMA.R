#Import necessasry libraries
library(data.table)
library(tibble)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of drugs for file input
drug_list <- c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

#Make a data frame with significant results
  #Read in file
  #Add column containing drug name
  #Subset for significance, threshold = .3
  #Compile significant subsets into single data frame
for(drug in drug_list){
  CEU_mult <- fread("/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_" %&% drug %&% "_multixcan_wchr.txt")
  CEU_mult<-add_column(CEU_mult, drug = drug, .before = "pvalue")
  CEU_mult_significant<-subset(CEU_mult, pvalues_adjusted_fdr <= .3)
  if(exists("CEU_mult_sign3")){
    CEU_mult_sign3<-merge(x = CEU_mult_sign3, y = CEU_mult_significant, all = TRUE)
  }
  else{
    CEU_mult_sign3<-CEU_mult_significant
  }
}

#Pull out gene column and create vector
genes<-select(CEU_mult_sign3, 1)
genes<-as.vector(unlist(genes))

#Remove gene column from data frame
CEU_mult_sign3<-select(CEU_mult_sign3, 2:14)

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
CEU_mult_sign3<-add_column(CEU_mult_sign3, gene = gene_list_fuma, .before = "drug")

#Subset again for significance, threshold = .2, .15, .075, and .05
CEU_mult_sign2 <- subset(CEU_mult_sign3, pvalues_adjusted_fdr <= .2)
CEU_mult_sign15 <- subset(CEU_mult_sign3, pvalues_adjusted_fdr <= .15)
CEU_mult_sign075 <- subset(CEU_mult_sign3, pvalues_adjusted_fdr <= .075)
CEU_mult_sign05 <- subset(CEU_mult_sign3, pvalues_adjusted_fdr <= .05)

#Output data frames into directory
fwrite(CEU_mult_sign3, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_multixcan_condensed_fdr3", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(CEU_mult_sign2, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_multixcan_condensed_fdr2", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(CEU_mult_sign15, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_multixcan_condensed_fdr15", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(CEU_mult_sign075, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_multixcan_condensed_fdr075", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(CEU_mult_sign05, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_multixcan_condensed_fdr05", na = "NA", quote = F, sep = "\t", col.names = T) 

