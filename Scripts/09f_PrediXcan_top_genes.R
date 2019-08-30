#Import necessasry libraries
library(data.table)
library(tibble)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of drugs for file input
  #For YRI: no arac (nothing siginificant, remove from list to avoid breaking script)
  #For CEU: no arac, cape, or etop
  #For ASN: no arac or cis
  #For ALL: no carbo, cis, or peme
drug_list <- c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

#Make a data frame with significant results
  #Read in file
  #Add column containing drug name
  #Subset for significance, threshold: pvalues_adjusted_bonferroni < 1
  #Compile significant subsets into single data frame
for(drug in drug_list){
  ASN_pred <- fread("/home/ashley/LCL_chemotherapy/ASN/ASN_assoc_gemma_output_combined/ASN_predixcan_" %&% drug %&% "_adj.txt")
  ASN_pred<-add_column(ASN_pred, drug = drug, .before = "tissue")
  ASN_pred_significant<-subset(ASN_pred, pvalues_adjusted_bonferroni < 1)
  if(exists("ASN_pred_sign")){
    ASN_pred_sign<-merge(x = ASN_pred_sign, y = ASN_pred_significant, all = TRUE)
  }
  else{
    ASN_pred_sign<-ASN_pred_significant
  }
}

#Output data frames into directory
fwrite(ASN_pred_sign, "/home/ashley/LCL_chemotherapy/ASN/ASN_assoc_gemma_output_combined/ASN_predixcan_top_hits", na = "NA", quote = F, sep = "\t", col.names = T) 

