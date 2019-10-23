#Import necessary libraries
library(data.table)

#For ALL etop:
#Change column names of GWAS output file (BIMBAM format) for FOCUS input:
all_gwas_etop<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_etop.assoc.txt")
colnames(all_gwas_etop)<-c("CHR", "SNP", "BP", "n_miss", "A1", "A2", "af", "BETA", "se", "l_remle", "l_mle", "P", "p_lrt", "p_score")
fwrite(all_gwas_etop, "/home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_etop_focus.assoc.txt", sep = "\t")

#Run munge to get sumstats file with z-score:
#focus munge /home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_etop_focus.assoc.txt --verbose --N 557 --output /home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_etop_focus



#For ALL peme:
#Change column names of GWAS output file (BIMBAM format) for FOCUS input:
all_gwas_peme<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_peme.assoc.txt")
colnames(all_gwas_peme)<-c("CHR", "SNP", "BP", "n_miss", "A1", "A2", "af", "BETA", "se", "l_remle", "l_mle", "P", "p_lrt", "p_score")
fwrite(all_gwas_peme, "/home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_peme_focus.assoc.txt", sep = "\t")

#Run munge to get sumstats file with z-score:
#focus munge /home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_peme_focus.assoc.txt --verbose --N 557 --output /home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_peme_focus



#For ALL arac:
#Change column names of GWAS output file (BIMBAM format) for FOCUS input:
all_gwas_arac<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_arac.assoc.txt")
colnames(all_gwas_arac)<-c("CHR", "SNP", "BP", "n_miss", "A1", "A2", "af", "BETA", "se", "l_remle", "l_mle", "P", "p_lrt", "p_score")
fwrite(all_gwas_arac, "/home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_arac_focus.assoc.txt", sep = "\t")

#Run munge to get sumstats file with z-score:
#focus munge /home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_arac_focus.assoc.txt --verbose --N 557 --output /home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_arac_focus



#For ALL cape:
#Change column names of GWAS output file (BIMBAM format) for FOCUS input:
all_gwas_cape<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_cape.assoc.txt")
colnames(all_gwas_cape)<-c("CHR", "SNP", "BP", "n_miss", "A1", "A2", "af", "BETA", "se", "l_remle", "l_mle", "P", "p_lrt", "p_score")
fwrite(all_gwas_cape, "/home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_cape_focus.assoc.txt", sep = "\t")

#Run munge to get sumstats file with z-score:
#focus munge /home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_cape_focus.assoc.txt --verbose --N 557 --output /home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_cape_focus



#For ASN carbo:
#Change column names of GWAS output file (BIMBAM format) for FOCUS input:
ASN_gwas_carbo<-fread("/home/ashley/LCL_chemotherapy/ASN/ASN_GWAS_results/ASN_GWAS_carboplatin.assoc.txt")
colnames(ASN_gwas_carbo)<-c("CHR", "SNP", "BP", "n_miss", "A1", "A2", "af", "BETA", "se", "l_remle", "l_mle", "P", "p_lrt", "p_score")
fwrite(ASN_gwas_carbo, "/home/ashley/LCL_chemotherapy/ASN/ASN_GWAS_results/ASN_GWAS_carbo_focus.assoc.txt", sep = "\t")

#Run munge to get sumstats file with z-score:
#focus munge /home/ashley/LCL_chemotherapy/ASN/ASN_GWAS_results/ASN_GWAS_carbo_focus.assoc.txt --verbose --N 201 --output /home/ashley/LCL_chemotherapy/ASN/ASN_GWAS_results/ASN_GWAS_carbo_focus



#For YRI dauno:
#Change column names of GWAS output file (BIMBAM format) for FOCUS input:
YRI_gwas_dauno<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_daunorubicin.assoc.txt")
colnames(YRI_gwas_dauno)<-c("CHR", "SNP", "BP", "n_miss", "A1", "A2", "af", "BETA", "se", "l_remle", "l_mle", "P", "p_lrt", "p_score")
fwrite(YRI_gwas_dauno, "/home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_dauno_focus.assoc.txt", sep = "\t")

#Run munge to get sumstats file with z-score:
#focus munge /home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_dauno_focus.assoc.txt --verbose --N 178 --output /home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_dauno_focus



#For YRI etop:
#Change column names of GWAS output file (BIMBAM format) for FOCUS input:
YRI_gwas_etop<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_etoposide.assoc.txt")
colnames(YRI_gwas_etop)<-c("CHR", "SNP", "BP", "n_miss", "A1", "A2", "af", "BETA", "se", "l_remle", "l_mle", "P", "p_lrt", "p_score")
fwrite(YRI_gwas_etop, "/home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_etop_focus.assoc.txt", sep = "\t")

#Run munge to get sumstats file with z-score:
#focus munge /home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_etop_focus.assoc.txt --verbose --N 178 --output /home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_etop_focus



#For YRI cis:
#Change column names of GWAS output file (BIMBAM format) for FOCUS input:
YRI_gwas_cis<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_cisplatin.assoc.txt")
colnames(YRI_gwas_cis)<-c("CHR", "SNP", "BP", "n_miss", "A1", "A2", "af", "BETA", "se", "l_remle", "l_mle", "P", "p_lrt", "p_score")
fwrite(YRI_gwas_cis, "/home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_cis_focus.assoc.txt", sep = "\t")

#Run munge to get sumstats file with z-score:
#focus munge /home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_cis_focus.assoc.txt --verbose --N 178 --output /home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_cis_focus



#For YRI cape:
#Change column names of GWAS output file (BIMBAM format) for FOCUS input:
YRI_gwas_cape<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_capecitabine.assoc.txt")
colnames(YRI_gwas_cape)<-c("CHR", "SNP", "BP", "n_miss", "A1", "A2", "af", "BETA", "se", "l_remle", "l_mle", "P", "p_lrt", "p_score")
fwrite(YRI_gwas_cape, "/home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_cape_focus.assoc.txt", sep = "\t")

#Run munge to get sumstats file with z-score:
#focus munge /home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_cape_focus.assoc.txt --verbose --N 178 --output /home/ashley/LCL_chemotherapy/YRI/YRI_GWAS_results/YRI_GWAS_cape_focus
