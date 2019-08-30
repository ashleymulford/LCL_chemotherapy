#Import necessasry libraries
library(data.table)
library(tibble)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of drugs for file input
  #For YRI: no etop (nothing siginificant, remove from list to avoid breaking script)
  #For CEU: no arac
  #For ASN: no carbo or cis
  #For ALL: no cis, etop, or pacl
drug_list <- c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

#Make a data frame with significant results
  #Read in file
  #Add column containing drug name
  #Subset for significance, threshold: pvalues_adjusted_bonferroni < 1
  #Compile significant subsets into single data frame
for(drug in drug_list){
  YRI_mult <- fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_" %&% drug %&% "_adj.txt")
  YRI_mult<-add_column(YRI_mult, drug = drug, .before = "pvalue")
  YRI_mult_significant<-subset(YRI_mult, pvalues_adjusted_bonferroni < 1)
  if(exists("YRI_mult_sign")){
    YRI_mult_sign<-merge(x = YRI_mult_sign, y = YRI_mult_significant, all = TRUE)
  }
  else{
    YRI_mult_sign<-YRI_mult_significant
  }
}

#Output data frames into directory
fwrite(YRI_mult_sign, "/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_top_hits", na = "NA", quote = F, sep = "\t", col.names = T) 


