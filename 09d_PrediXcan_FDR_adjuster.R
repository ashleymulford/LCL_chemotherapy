#adjust pvalues with FDR

"%&%" = function(a,b) paste(a,b,sep="")

bp_chrome <- fread("/home/ashley/LCL_chemotherapy/BP_Chrome.txt")

drug_list <- c("arac", "capecitabine", "carboplatin", "cisplatin", "daunorubicin", "etoposide", "paclitaxel", "pemetrexed")

for (drug in drug_list) {
  CEU_predixcan <- fread("/home/ashley/LCL_chemotherapy/CEU/CEU_assoc_gemma_output_combined/CEU_assoc_" %&% drug)
  pvalues <- select(CEU_predixcan, contains("p_wald"))
  pvalues <- as.vector(unlist(pvalues))
  pvalues_adjusted_fdr <- p.adjust(pvalues, method = "BH")
  CEU_predixcan <- add_column(CEU_predixcan,  pvalues_adjusted_fdr = pvalues_adjusted_fdr , .before = "p_lrt")
  CEU_predixcan <- left_join(CEU_predixcan, bp_chrome, by = c("rs" = "gene"))
  CEU_predixcan <- select(CEU_predixcan, - chr, - ps)
  fwrite(CEU_predixcan, "/home/ashley/LCL_chemotherapy/CEU/CEU_assoc_gemma_output_combined/CEU_assoc_adjusted_" %&% drug %&% ".txt")
}
