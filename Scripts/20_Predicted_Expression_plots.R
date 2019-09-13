#Import necessary libraries
library(cowplot)
library(data.table)
library(ggplot2)
library(dplyr)

#Plot Predicted Expression for STARD5 gene, in Brain_Cortex tissue, ALL pop, and Etop drug:

#Pheno file:
x_ALL_etop_pheno <-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_phenos/ALL_etop.txt")
#Predicted Expression file:
y_ALL_Pred_Brain_Cortex<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_predixcan_predict_output/ALL_results_Brain_Cortex_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
ALL_Pred_top_hits<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_output_combined/ALL_predixcan_top_hits")
#Data file:
xy_ALL_Pred_etop_Brain_Cortex<-inner_join(x_ALL_etop_pheno, y_ALL_Pred_Brain_Cortex, by = c("FID", "IID"))
#Make plot:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_predicted_expression_plots/ALL_Etoposide_STARD5.pdf")
ggplot(xy_ALL_Pred_etop_Brain_Cortex, aes(x = xy_ALL_Pred_etop_Brain_Cortex$ENSG00000172345.9, y = xy_ALL_Pred_etop_Brain_Cortex$Pheno)) +
  geom_jitter(size = 0.75, color = "#b3cde3") + 
  geom_density_2d(color = "#8c96c6") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8856a7") + 
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Etop IC50 (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ALL Etoposide Brain Cortex STARD5")
dev.off()



#Plot Predicted Expression for USF1 gene, in Liver tissue, ALL pop, and Cape drug:

#Pheno file:
x_ALL_cape_pheno <-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_phenos/ALL_cape.txt")
#Predicted Expression file:
y_ALL_Pred_Liver<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_predixcan_predict_output/ALL_results_Liver_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
ALL_pred_top_hits<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_output_combined/ALL_predixcan_top_hits")
#Data file:
xy_ALL_Pred_cape_Liver<-inner_join(x_ALL_cape_pheno, y_ALL_Pred_Liver, by = c("FID", "IID"))
#Make plot:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_predicted_expression_plots/ALL_Capecitabine_USF1.pdf")
ggplot(xy_ALL_Pred_cape_Liver, aes(x = xy_ALL_Pred_cape_Liver$ENSG00000158773.10, y = xy_ALL_Pred_cape_Liver$Pheno)) +
  geom_jitter(size = 0.75, color = "#b3cde3") + 
  geom_density_2d(color = "#8c96c6") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8856a7") + 
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Cape AUC (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ALL Capecitabine Liver USF1")
dev.off()



#Plot Predicted Expression for FAM137B gene, in Minor Salivary Gland tissue, ASN pop, and Carbo drug:

#Pheno file:
x_ASN_carbo_pheno <-fread("/home/ashley/LCL_chemotherapy/ASN/ASN_multixcan_phenos/ASN_carbo_pheno")
#Predicted Expression file:
y_ASN_Pred_MSG<-fread("/home/ashley/LCL_chemotherapy/ASN/ASN_predixcan_predict_output/ASN_results_Minor_Salivary_Gland_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
ASN_pred_top_hits<-fread("/home/ashley/LCL_chemotherapy/ASN/ASN_assoc_gemma_output_combined/ASN_predixcan_top_hits")
#Data file:
xy_ASN_Pred_carbo_MSG<-inner_join(x_ASN_carbo_pheno, y_ASN_Pred_MSG, by = c("FID", "IID"))
#Make plot:
pdf("/home/ashley/LCL_chemotherapy/ASN/ASN_predicted_expression_plots/ASN_Carboplatin_FAM137B.pdf")
ggplot(xy_ASN_Pred_carbo_MSG, aes(x = xy_ASN_Pred_carbo_MSG$ENSG00000150756.9, y = xy_ASN_Pred_carbo_MSG$Pheno)) +
  geom_jitter(size = 0.75, color = "#b3cde3") + 
  geom_density_2d(color = "#8c96c6") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8856a7") + 
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Carbo IC50 (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ASN Carboplatin Minor Salivary Gland FAM137B")
dev.off()



#Plot Predicted Expression for AHCTF1 gene, in Thyroid tissue, ALL pop, Cape drug:

#Pheno file:
x_ALL_cape_pheno <-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_phenos/ALL_cape.txt")
#Predicted Expression file:
y_ALL_Pred_Thyroid<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_predixcan_predict_output/ALL_results_Thyroid_predicted_expression.txt")
#Association file with top hits (to look up gene ID):
ALL_pred_top_hits<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_output_combined/ALL_predixcan_top_hits")
#Data file:
xy_ALL_Pred_cape_Thyroid<-inner_join(x_ALL_cape_pheno, y_ALL_Pred_Thyroid, by = c("FID", "IID"))
#Make plot
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_predicted_expression_plots/ALL_Capecitabine_AHCTF1.pdf")
ggplot(xy_ALL_Pred_cape_Thyroid, aes(x = xy_ALL_Pred_cape_Thyroid$ENSG00000153207.10, y = xy_ALL_Pred_cape_Thyroid$Pheno)) +
  geom_jitter(size = 0.75, color = "#b3cde3") + 
  geom_density_2d(color = "#8c96c6") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8856a7") + 
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "Cape AUC (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("ALL Capecitabine Thyroid AHCTF1")
dev.off()




