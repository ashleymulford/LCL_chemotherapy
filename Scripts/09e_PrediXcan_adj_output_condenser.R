#Import necessasry libraries
library(data.table)
library(tibble)

#Create function to paste in tissue name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of drugs for file input
drug_list <- c("arac", "capecitabine", "carboplatin", "cisplatin", "daunorubicin", "etoposide", "paclitaxel", "pemetrexed")

#Make a data frame with significant results
  #Read in file
  #Add column containing drug name
  #Subset for significance, threshold = .3
  #Compile significant subsets into single data frame
for(drug in drug_list){
  YRI_pred <- fread("/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_adjusted_" %&% drug %&% ".txt")
  YRI_pred<-add_column(YRI_pred, drug = drug, .before = "tissue")
  YRI_pred_significant<-subset(YRI_pred, pvalues_adjusted_fdr <= .3)
  if(exists("YRI_pred_sign3")){
    YRI_pred_sign3<-merge(x = YRI_pred_sign3, y = YRI_pred_significant, all = TRUE)
  }
  else{
    YRI_pred_sign3<-YRI_pred_significant
  }
}

#Subset again for significance, threshold = .2 and .075
YRI_pred_sign2 <- subset(YRI_pred_sign3, pvalues_adjusted_fdr <= .2)
YRI_pred_sign075 <- subset(YRI_pred_sign3, pvalues_adjusted_fdr <= .075)

#Output data frames into directory
fwrite(YRI_pred_sign3, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_adj_condensed_fdr3", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(YRI_pred_sign2, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_adj_condensed_fdr2", na = "NA", quote = F, sep = "\t", col.names = T) 
fwrite(YRI_pred_sign075, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_adj_condensed_fdr075", na = "NA", quote = F, sep = "\t", col.names = T) 



