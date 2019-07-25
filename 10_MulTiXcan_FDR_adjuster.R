#adjust pvalues with FDR

"%&%" = function(a,b) paste(a,b,sep="")

drug_list<-c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

for (drug in drug_list) {
  YRI_multixcan<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_" %&% drug %&% "_multixcan")
  pvalues<-select(YRI_multixcan, contains("pvalue"))
  pvalues<-as.vector(unlist(pvalues))
  pvalues_adjusted_fdr<-p.adjust(pvalues, method = "BH")
  YRI_multixcan <- add_column(YRI_multixcan,  pvalues_adjusted_fdr = pvalues_adjusted_fdr , .before = "n_models")
  fwrite(YRI_multixcan, "/home/ashley/LCL_chemotherapy/YRI/YRI_" %&% drug %&% "_multixcan.txt")
}
