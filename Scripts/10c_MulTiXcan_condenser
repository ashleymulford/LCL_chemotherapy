#Import necessasry libraries
library(data.table)
library(tibble)

#Create function to paste in tissue name
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
  CEU_mult<-add_column(CEU_mult, drug = drug, .before = "gene")
  CEU_mult_significant<-subset(CEU_mult, pvalues_adjusted_fdr <= .3)
  if(exists("CEU_mult_sign3")){
    CEU_mult_sign3<-merge(x = CEU_mult_sign3, y = CEU_mult_significant, all = TRUE)
  }
  else{
    CEU_mult_sign3<-CEU_mult_significant
  }
}

#Subset again for significance, threshold = .15, .075, and .05
CEU_mult_sign15 <- subset(CEU_mult_sign3, pvalues_adjusted_fdr <= .15)
CEU_mult_sign075 <- subset(CEU_mult_sign3, pvalues_adjusted_fdr <= .075)
CEU_mult_sign05 <- subset(CEU_mult_sign3, pvalues_adjusted_fdr <= .05)

#Output data frames into directory
fwrite(CEU_mult_sign3, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_multixacn_condensed_fdr3", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(CEU_mult_sign15, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_multixacn_condensed_fdr15", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(CEU_mult_sign075, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_multixacn_condensed_fdr075", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(CEU_mult_sign05, "/home/ashley/LCL_chemotherapy/CEU/CEU_multixcan_output/CEU_multixacn_condensed_fdr05", na = "NA", quote = F, sep = "\t", col.names = T) 


