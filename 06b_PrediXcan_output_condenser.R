#Import necessasry libraries
library(data.table)
library(tibble)

#Create function to paste in tissue name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of tissues for file input
tiss_list <- c("Adipose_Subcutaneous", "Adipose_Visceral_Omentum", "Adrenal_Gland", "Artery_Aorta", "Artery_Coronary", "Artery_Tibial", "Brain_Amygdala", "Brain_Anterior", "Brain_Caudate", "Brain_Cerebellar_Hemisphere", "Brain_Cerebellum", "Brain_Cortex", "Brain_Frontal_Cortex", "Brain_Hippocampus", "Brain_Hypothalamus", "Brain_Nucleus", "Brain_Putamen", "Brain_Spinal", "Brain_Substantia", "Breast_Mammary_Tissue", "Cells_EBV-transformed_lymphocytes", "Cells_Transformed_fibroblasts", "Colon_Sigmoid", "Colon_Transverse", "Esophagus_Gastroesophageal_Junction", "Esophagus_Mucosa", "Esophagus_Muscularis", "Heart_Atrial_Appendage", "Heart_Left_Ventricle", "Liver", "Lung", "MESA_AFA", "MESA_AFHI", "MESA_ALL", "MESA_CAU", "MESA_HIS", "Minor_Salivary_Gland", "Muscle_Skeletal", "Nerve_Tibial", "Ovary", "Pancreas", "Pituitary", "Prostate", "Skin_Not_Sun_Exposed_Suprapubic", "Skin_Sun_Exposed_Lower_leg", "Small_Intestine_Terminal_Ileum", "Spleen", "Stomach", "Testis", "Thyroid", "Uterus", "Vagina", "Whole_Blood")

#Make a data frame with significant results
  #Read in file
  #Add column containing tissue name
  #Subset for significance, threshold = 10^-3
  #Compile significant subsets into single data frame
for(tiss in tiss_list){
  arac_output <- fread("/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output/YRI_assoc_arac_" %&% tiss %&% ".assoc.txt")

  arac_output<-add_column(arac_output, tissue = tiss, .before = "chr")
  
  arac_output_significant<-subset(arac_output, p_wald <= 10^-3)
  
  if(exists("YRI_assoc_arac_sign")){
    
    YRI_assoc_arac_sign<-merge(x = YRI_assoc_arac_sign, y = arac_output_significant, all = TRUE)
  }
  else{
    YRI_assoc_arac_sign<-arac_output_significant
  }
  
}

#Subset again for significance, threshold = 10^-5
YRI_assoc_arac_mostsig <- subset(YRI_assoc_arac_sign, p_wald <= 10^-5)

#Output data frames into directory
fwrite(YRI_assoc_arac_sign, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_condensed/YRI_assoc_arac", na = "NA", quote = F, sep = "\t", col.names = T) 

fwrite(YRI_assoc_arac_mostsig, "/home/ashley/LCL_chemotherapy/YRI/YRI_assoc_gemma_output_condensed/YRI_assoc_arac_mostsig", na = "NA", quote = F, sep = "\t", col.names = T) 

