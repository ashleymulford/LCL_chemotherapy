#Import necessary libraries
library(data.table)
library(dplyr)
library(ggplot2)

#PrediXcan Results:

#Plot Predicted Expression for STARD5, for Brain_Cortex tissue, ALL pop, and Etop drug:
#Pheno file:
x_ALL_etop_pheno<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_phenos/ALL_etop.txt")
#Predicted Expression file:
y_ALL_Pred_Brain_Cortex<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_predixcan_predict_output/ALL_results_Brain_Cortex_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
ALL_Pred_top_hits<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_output_combined/ALL_predixcan_top_hits")
#Data file:
xy_ALL_Pred_etop_Brain_Cortex<-inner_join(x_ALL_etop_pheno, y_ALL_Pred_Brain_Cortex, by = c("FID", "IID"))

#Make Plot:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_predicted_expression_plots/ALL_Etoposide_STARD5.pdf")
ggplot(xy_ALL_Pred_etop_Brain_Cortex, aes(x = xy_ALL_Pred_etop_Brain_Cortex$ENSG00000172345.9, y = xy_ALL_Pred_etop_Brain_Cortex$Pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") + 
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Etop IC50 (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ALL Etoposide Brain Cortex STARD5")
dev.off()




#Plot Predicted Expression for USF1, Liver, ALL, Cape:
#Pheno file:
x_ALL_cape_pheno <-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_phenos/ALL_cape.txt")
#Predicted Expression file:
y_ALL_Pred_Liver<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_predixcan_predict_output/ALL_results_Liver_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
ALL_pred_top_hits<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_output_combined/ALL_predixcan_top_hits")
#Data file:
xy_ALL_Pred_cape_Liver<-inner_join(x_ALL_cape_pheno, y_ALL_Pred_Liver, by = c("FID", "IID"))

#Make Plot:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_predicted_expression_plots/ALL_Capecitabine_USF1.pdf")
ggplot(xy_ALL_Pred_cape_Liver, aes(x = xy_ALL_Pred_cape_Liver$ENSG00000158773.10, y = xy_ALL_Pred_cape_Liver$Pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") +
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Cape AUC (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ALL Capecitabine Liver USF1")
dev.off()




#Plot Predicted Expression for FAM137B, Minor Salivary Gland, ASN, Carbo:
#Pheno file:
x_ASN_carbo_pheno <-fread("/home/ashley/LCL_chemotherapy/ASN/ASN_multixcan_phenos/ASN_carbo_pheno")
#Predicted Expression file:
y_ASN_Pred_MSG<-fread("/home/ashley/LCL_chemotherapy/ASN/ASN_predixcan_predict_output/ASN_results_Minor_Salivary_Gland_predicted_expression.txt")
#Association file wiht top hits (to look up gene ID):
ASN_pred_top_hits<-fread("/home/ashley/LCL_chemotherapy/ASN/ASN_assoc_gemma_output_combined/ASN_predixcan_top_hits")
#Data file:
xy_ASN_Pred_carbo_MSG<-inner_join(x_ASN_carbo_pheno, y_ASN_Pred_MSG, by = c("FID", "IID"))

#Make Plot:
pdf("/home/ashley/LCL_chemotherapy/ASN/ASN_predicted_expression_plots/ASN_Carboplatin_FAM137B.pdf")
ggplot(xy_ASN_Pred_carbo_MSG, aes(x = xy_ASN_Pred_carbo_MSG$ENSG00000150756.9, y = xy_ASN_Pred_carbo_MSG$Pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") +
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Carbo IC50 (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ASN Carboplatin Minor Salivary Gland FAM137B")
dev.off()




#Plot Predicted Expression for AHCTF1, Thyroid, ALL, Cape:
#Pheno file:
x_ALL_cape_pheno <-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_phenos/ALL_cape.txt")
#Predicted Expression file:
y_ALL_Pred_Thyroid<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_predixcan_predict_output/ALL_results_Thyroid_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
ALL_pred_top_hits<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_output_combined/ALL_predixcan_top_hits")
#Data file:
xy_ALL_Pred_cape_Thyroid<-inner_join(x_ALL_cape_pheno, y_ALL_Pred_Thyroid, by = c("FID", "IID"))

#Make Plot:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_predicted_expression_plots/ALL_Capecitabine_AHCTF1.pdf")
ggplot(xy_ALL_Pred_cape_Thyroid, aes(x = xy_ALL_Pred_cape_Thyroid$ENSG00000153207.10, y = xy_ALL_Pred_cape_Thyroid$Pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") +
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Cape AUC (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ALL Capecitabine Thyroid AHCTF1")
dev.off()




#MulTiXcan Results:

#Plot Predicted Expression for CCAR1, Esophagus Mucosa, YRI, Cape:
#Pheno file:
x_YRI_cape_pheno <-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_phenos/YRI_cape_pheno")
#Predicted Expression file:
y_YRI_Mult_EsoMuc<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_predixcan_predict_output/YRI_results_Esophagus_Mucosa_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
YRI_Mult_top_hits<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_top_hits")
#Data file:
xy_YRI_Mult_cape_EsoMuc<-inner_join(x_YRI_cape_pheno, y_YRI_Mult_EsoMuc, by = c("FID", "IID"))

#Make Plot:
pdf("/home/ashley/LCL_chemotherapy/YRI/YRI_predicted_expression_plots/YRI_Capecitabine_CCAR1.pdf")
ggplot(xy_YRI_Mult_cape_EsoMuc, aes(x = xy_YRI_Mult_cape_EsoMuc$ENSG00000060339.9, y = xy_YRI_Mult_cape_EsoMuc$Pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") +
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Cape AUC (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("YRI Capecitabine Esophagus Mucosa CCAR1")
dev.off()




#Plot Predicted Expression for RP11-680H20, Nerve Tibial, YRI, Cape:
#Pheno file:
x_YRI_cape_pheno <-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_phenos/YRI_cape_pheno")
#Predicted Expression file:
y_YRI_Mult_NerveTib<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_predixcan_predict_output/YRI_results_Nerve_Tibial_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
YRI_Mult_top_hits<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_top_hits")

#Data file:
xy_YRI_Mult_cape_NerveTib<-inner_join(x_YRI_cape_pheno, y_YRI_Mult_NerveTib, by = c("FID", "IID"))

#Make Plot:
pdf("/home/ashley/LCL_chemotherapy/YRI/YRI_predicted_expression_plots/YRI_Capecitabine_RP11-680H20.pdf")
ggplot(xy_YRI_Mult_cape_NerveTib, aes(x = xy_YRI_Mult_cape_NerveTib$ENSG00000250519.2, y = xy_YRI_Mult_cape_NerveTib$Pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") +
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Cape AUC (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("YRI Capecitabine Nerve Tibial RP11-680H20")
dev.off()




#Plot Predicted Expression for AP005135, Testis, ALL, Peme:
#Pheno file:
x_ALL_peme_pheno <-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_phenos/ALL_peme.txt")
#Predicted Expression file:
y_ALL_Mult_Testis<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_predixcan_predict_output/ALL_results_Testis_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
ALL_Mult_top_hits<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_output/ALL_multixcan_top_hits")
#Data file:
xy_ALL_Mult_peme_Testis<-inner_join(x_ALL_peme_pheno, y_ALL_Mult_Testis, by = c("FID", "IID"))

#Make Plot:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_predicted_expression_plots/ALL_Pemetrexed_AP005135.pdf")
ggplot(xy_ALL_Mult_peme_Testis, aes(x = xy_ALL_Mult_peme_Testis$ENSG00000255512.1, y = xy_ALL_Mult_peme_Testis$Pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") +
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Peme AUC (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ALL Pemetrexed Testis AP005135")
dev.off()




#Plot Predicted Expression for DGUOK, Heart Left Ventricle, ALL, Ara-C:
#Pheno file:
x_ALL_arac_pheno <-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_phenos/ALL_arac.txt")
#Predicted Expression file:
y_ALL_Mult_HLV<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_predixcan_predict_output/ALL_results_Heart_Left_Ventricle_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
ALL_Mult_top_hits<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_output/ALL_multixcan_top_hits")
#Data file:
xy_ALL_Mult_arac_HLV<-inner_join(x_ALL_arac_pheno, y_ALL_Mult_HLV, by = c("FID", "IID"))

#Make Plot:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_predicted_expression_plots/ALL_Ara-C_DGUOK.pdf")
ggplot(xy_ALL_Mult_arac_HLV, aes(x = xy_ALL_Mult_arac_HLV$ENSG00000114956.15, y = xy_ALL_Mult_arac_HLV$Pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") +
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Ara-C AUC (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ALL Ara-C Heart Left Ventricle DGUOK")
dev.off()




#Plot Predicted Expression for VIMP1, Nerve Tibial, YRI, Cape:
#Pheno file:
x_YRI_cape_pheno <-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_phenos/YRI_cape_pheno")
#Predicted Expression file:
y_YRI_Mult_NerveTib<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_predixcan_predict_output/YRI_results_Nerve_Tibial_predicted_expression.txt")
#Association file with top hits (to look up gene ID)
YRI_Mult_top_hits<-fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_top_hits")
#Data file:
xy_YRI_Mult_cape_NerveTib<-inner_join(x_YRI_cape_pheno, y_YRI_Mult_NerveTib, by = c("FID", "IID"))

#Make Plot:
pdf("/home/ashley/LCL_chemotherapy/YRI/YRI_predicted_expression_plots/YRI_Capecitabine_VIMP1.pdf")
ggplot(xy_YRI_Mult_cape_NerveTib, aes(x = xy_YRI_Mult_cape_NerveTib$ENSG00000220548.3, y = xy_YRI_Mult_cape_NerveTib$Pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") +
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Cape AUC (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("YRI Capecitabine Nerve Tibial VIMP1")
dev.off()



