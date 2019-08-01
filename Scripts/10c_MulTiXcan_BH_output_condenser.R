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
  YRI_mult <- fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_" %&% drug %&% "_multixcan_BH_wchr.txt")
  YRI_mult<-add_column(YRI_mult, drug = drug, .before = "pvalue")
  YRI_mult_significant<-subset(YRI_mult, pvalues_adjusted_BH <= .3)
  if(exists("YRI_mult_sign3")){
    YRI_mult_sign3<-merge(x = YRI_mult_sign3, y = YRI_mult_significant, all = TRUE)
  }
  else{
    YRI_mult_sign3<-YRI_mult_significant
  }
}

#Subset again for significance, threshold = .2, .15, .075, and .05
YRI_mult_sign2 <- subset(YRI_mult_sign3, pvalues_adjusted_BH <= .2)
YRI_mult_sign15 <- subset(YRI_mult_sign3, pvalues_adjusted_BH <= .15)
YRI_mult_sign075 <- subset(YRI_mult_sign3, pvalues_adjusted_BH <= .075)
YRI_mult_sign05 <- subset(YRI_mult_sign3, pvalues_adjusted_BH <= .05)

#Output data frames into directory
fwrite(YRI_mult_sign3, "/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_condensed_BH3", na = "NA", quote = F, sep = "\t", col.names = F) 
fwrite(YRI_mult_sign2, "/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_condensed_BH2", na = "NA", quote = F, sep = "\t", col.names = F) 
fwrite(YRI_mult_sign15, "/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_condensed_BH15", na = "NA", quote = F, sep = "\t", col.names = F) 
fwrite(YRI_mult_sign075, "/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_condensed_BH075", na = "NA", quote = F, sep = "\t", col.names = F) 
fwrite(YRI_mult_sign05, "/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_condensed_BH05", na = "NA", quote = F, sep = "\t", col.names = F) 





