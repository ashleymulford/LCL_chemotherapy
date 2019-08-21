#Import necessary libraries
library(data.table)
library(qqman)
library(colorspace)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create color vector
colors<-sequential_hcl(4,"SunsetDark")

#Create list of drugs for file input
drug_list <- c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

#Make QQ and Manhattan plots using loop
for(drug in drug_list){
  CEU_assoc_adj <- fread("/home/ashley/LCL_chemotherapy/CEU/CEU_assoc_gemma_output_combined/CEU_predixcan_adjusted_" %&% drug %&% ".txt")
  #Remove alleles columns (empty since GEMMA was used for PrediXcan assoc instead of GWAS)
  CEU_assoc_adj<-select(CEU_assoc_adj, 1:3, 6:17)
  #Remove all rows with NAs
  CEU_assoc_adj<-na.omit(CEU_assoc_adj)
  
  png(filename = "CEU_PrediXcan_" %&% drug %&% ".qqplot.png", res=100)
  qq(CEU_assoc_adj$p_wald)
  dev.off()
  
  png(filename = "CEU_PrediXcan_" %&% drug %&% ".manplot.png", res=100)
  manhattan(CEU_assoc_adj, chr = "CHR", bp = "BP", p = "p_wald", col = colors)
  dev.off()
}
