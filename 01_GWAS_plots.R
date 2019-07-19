GWAS_cis <- fread("/home/ashley/LCL_chemotherapy/CEU/CEU_GWAS_results/CEU_GWAS_cisplatin.assoc.txt")
png(filename = "CEU_GWAS_cisplatin.qqplot.png", res=100)
qq(GWAS_cis$p_wald)
dev.off()
png(filename = "CEU_GWAS_cisplatin.manplot.png", res=100)
manhattan(GWAS_cis, chr = "chr", bp = "ps", p = "p_wald")
dev.off()


