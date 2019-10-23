#Import necessary libraries
library(data.table)
library(dplyr)

#Read in fam files
plink_all_fam<-fread("/home/ashley/1000G_ALL_Phase1_plink/1kg_phase1_all.fam")
colnames(plink_all_fam)<-c("FIDP", "IID", "PatID", "MatID", "Sex", "Aff")
bimbam_all_fam<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_orderedby_ASN_CEU_YRI.fam")
colnames(bimbam_all_fam)<-c("Pop", "FIDB", "IID", "PatID", "MatID", "Sex", "Aff")

#Output files with just PLINK FID and IID for each pop
overlap_all_fam<-inner_join(plink_all_fam, bimbam_all_fam)
overlap_asn_fam<-subset(overlap_all_fam, Pop == "ASN")
overlap_yri_fam<-subset(overlap_all_fam, Pop == "YRI")
overlap_ceu_fam<-subset(overlap_all_fam, Pop == "CEU")
overlap_all_ids<-select(overlap_all_fam, 1,2)
overlap_asn_ids<-select(overlap_asn_fam, 1,2)
overlap_yri_ids<-select(overlap_yri_fam, 1,2)
overlap_ceu_ids<-select(overlap_ceu_fam, 1,2)
fwrite(overlap_all_ids, "/home/ashley/1000G_ALL_Phase1_plink/overlap_all_id.txt", col.names = F, sep = "\t")
fwrite(overlap_asn_ids, "/home/ashley/1000G_ALL_Phase1_plink/overlap_asn_id.txt", col.names = F, sep = "\t")
fwrite(overlap_yri_ids, "/home/ashley/1000G_ALL_Phase1_plink/overlap_yri_id.txt", col.names = F, sep = "\t")
fwrite(overlap_ceu_ids, "/home/ashley/1000G_ALL_Phase1_plink/overlap_ceu_id.txt", col.names = F, sep = "\t")

#Use these files to subset plink files for focus input (LD ref pop files)

#Plink Commands to subset, also remove indels:
#plink --bfile /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/1kg_phase1_all --keep /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/overlap_all_id.txt --snps-only --make-bed --out /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/focus_all
#plink --bfile /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/1kg_phase1_all --keep /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/overlap_asn_id.txt --snps-only --make-bed --out /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/focus_asn
#plink --bfile /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/1kg_phase1_all --keep /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/overlap_yri_id.txt --snps-only --make-bed --out /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/focus_yri
#plink --bfile /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/1kg_phase1_all --keep /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/overlap_ceu_id.txt --snps-only --make-bed --out /home/ashley/LCL_chemotherapy/1000G_ALL_Phase1_plink/focus_ceu

