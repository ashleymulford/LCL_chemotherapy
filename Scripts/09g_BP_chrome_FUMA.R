#Import necessary libraries
library(data.table)
library(dplyr)
library(tibble)

#Read in bp_chrome table
bp_chrome <- fread("/home/ashley/LCL_chemotherapy/BP_Chrome.txt")

#Pull out gene column and create vector
genes <- select(bp_chrome, 3)
genes <- as.vector(unlist(genes))

#Remove gene column from data frame
bp_chrome <- select(bp_chrome, 1,2,4)

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
bp_chrome_fuma<-add_column(bp_chrome, gene = gene_list_fuma, .before = "CHR")

#Output data frame into directory
fwrite(bp_chrome_fuma, "/home/ashley/LCL_chemotherapy/BP_Chrome_fuma.txt", col.names = F, quote = F, sep = "\t")
