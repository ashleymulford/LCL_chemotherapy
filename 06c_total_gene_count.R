#Import necessasry library
library(data.table)

#Create function to paste in tissue name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of tissues for file input
tiss_list <- c("Adipose_Subcutaneous", "Adipose_Visceral_Omentum", "Adrenal_Gland", "Artery_Aorta", "Artery_Coronary", "Artery_Tibial", "Brain_Amygdala", "Brain_Anterior", "Brain_Caudate", "Brain_Cerebellar_Hemisphere", "Brain_Cerebellum", "Brain_Cortex", "Brain_Frontal_Cortex", "Brain_Hippocampus", "Brain_Hypothalamus", "Brain_Nucleus", "Brain_Putamen", "Brain_Spinal", "Brain_Substantia", "Breast_Mammary_Tissue", "Cells_EBV-transformed_lymphocytes", "Cells_Transformed_fibroblasts", "Colon_Sigmoid", "Colon_Transverse", "Esophagus_Gastroesophageal_Junction", "Esophagus_Mucosa", "Esophagus_Muscularis", "Heart_Atrial_Appendage", "Heart_Left_Ventricle", "Liver", "Lung", "MESA_AFA", "MESA_AFHI", "MESA_ALL", "MESA_CAU", "MESA_HIS", "Minor_Salivary_Gland", "Muscle_Skeletal", "Nerve_Tibial", "Ovary", "Pancreas", "Pituitary", "Prostate", "Skin_Not_Sun_Exposed_Suprapubic", "Skin_Sun_Exposed_Lower_leg", "Small_Intestine_Terminal_Ileum", "Spleen", "Stomach", "Testis", "Thyroid", "Uterus", "Vagina", "Whole_Blood")

#Create empty lists for later use
gene_count_list1 <- c()
gene_count_list2 <- c()
gene_count_list3 <- c()

#Make YRI column using loop
  #Read in files
  #Save gene count, number of rows = number of genes per tissue
  #Add values to list
for(tiss in tiss_list){
  arac_output <- fread("/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output/YRI_assoc_arac_" %&% tiss %&% ".assoc.txt")
  gene_count<-nrow(arac_output)
  gene_count_list1<-append(gene_count_list1, gene_count)
}

#Rename list with column name
YRI_Gene_Count<-gene_count_list1

#Make CEU column
for(tiss in tiss_list){
  arac_output <- fread("/home/ashley/LCL_chemotherapy/CEU/CEU_assoc_gemma_output/CEU_assoc_arac_" %&% tiss %&% ".assoc.txt")
  gene_count<-nrow(arac_output)
  gene_count_list2<-append(gene_count_list2, gene_count)
}

CEU_Gene_Count<-gene_count_list2

#Make ASN column
for(tiss in tiss_list){
  arac_output <- fread("/home/ashley/LCL_chemotherapy/ASN/ASN_assoc_gemma_output/ASN_assoc_arac_" %&% tiss %&% ".assoc.txt")
  gene_count<-nrow(arac_output)
  gene_count_list3<-append(gene_count_list3, gene_count)
}

ASN_Gene_Count<-gene_count_list3


#Create data frame, three columns from lists created above, column names = list names, row names = tissues
gene_count_df<-data.frame(YRI_Gene_Count, CEU_Gene_Count, ASN_Gene_Count, row.names = tiss_list)

#Output data frame into directory
fwrite(gene_count_df, "/home/ashley/LCL_chemotherapy/PrediXcan_gene_count", na = "NA", quote = F, sep = "\t", col.names = T, row.names = T) 

