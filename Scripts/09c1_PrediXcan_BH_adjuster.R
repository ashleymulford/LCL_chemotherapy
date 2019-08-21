#Import necessary libraries
library(data.table)
library(dpylr)
library(tibble)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Read in table with chr # and bp for genes
bp_chrome <- fread("/home/ashley/LCL_chemotherapy/BP_Chrome.txt")

#Create list of drugs for file input
drug_list <- c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

#Make a data frame from combined PrediXcan results that includes chr #, bp, and FDR adj p-value
  #Read in combined output file
  #Create vector of p-values
  #Adjust p-values with BH (FDR) method
  #Add new column with adjusted p-values to data frame
  #Join PrediXcan data frame with bp_chrome data frame to add columns with chr # and bp
  #Remove old/inaccurate chr and bp columns
  #Ouput data frame into directory
for (drug in drug_list) {
  CEU_predixcan <- fread("/home/ashley/LCL_chemotherapy/CEU/CEU_assoc_gemma_output_combined/CEU_predixcan_" %&% drug)
  pvalues <- select(CEU_predixcan, contains("p_wald"))
  pvalues <- as.vector(unlist(pvalues))
  pvalues_adjusted_fdr <- p.adjust(pvalues, method = "BH")
  CEU_predixcan <- add_column(CEU_predixcan,  pvalues_adjusted_fdr = pvalues_adjusted_fdr , .before = "p_lrt")
  CEU_predixcan <- left_join(CEU_predixcan, bp_chrome, by = c("rs" = "gene"))
  CEU_predixcan <- select(CEU_predixcan, - chr, - ps)
  fwrite(CEU_predixcan, "/home/ashley/LCL_chemotherapy/CEU/CEU_assoc_gemma_output_combined/CEU_predixcan_adjusted_" %&% drug %&% ".txt")
}
