#adjust pvalues with FDR

"%&%" = function(a,b) paste(a,b,sep="")

drug_list<-c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

for (drug in drug_list) {
  YRI_predixcan<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_combined/YRI_assoc_" %&% drug)
  pvalues<-select(YRI_predixcan, contains("pvalue"))
  pvalues<-as.vector(unlist(pvalues))
  pvalues_adjusted_fdr<-p.adjust(pvalues, method = "BH")
  YRI_predixcan <- add_column(YRI_predixcan,  pvalues_adjusted_fdr = pvalues_adjusted_fdr , .before = "n_models")
  fwrite(YRI_predixcan, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_" %&% drug %&% ".txt")
}
