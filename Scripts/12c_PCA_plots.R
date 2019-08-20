#Import necessary libraries
library(data.table)
library(dplyr)
library(ggplot2)

#Read in fam file and add column names
fam<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_orderedby_ASN_CEU_YRI.fam") %>% select (V1,V2,V3)
colnames(fam)<-c("pop", "FID", "IID")

#Read in pcs (king output)
pcs <- fread("/home/ashley/LCL_chemotherapy/ALL/ALL_plinkfiles_PCA/kingpc.txt")

#Join fam and pcs to reorder pcs and add pop 
pcdf <- left_join(fam, pcs)

#Make covariate file for gemma input
covariates<-select(pcdf, 8:17)
fwrite(covariates, "/home/ashley/LCL_chemotherapy/ALL/ALL_covariates_king.txt")

#Make PCA plots:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_plinkfiles_PCA/ALL_PCA_plots_king.pdf")

#PCA Plot 1 (PC1 vs PC2)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC2,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC2")

#PCA Plot 2 (PC1 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC3")

#PCA Plot 1 (PC2 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC2,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC2 vs PC3")

dev.off() 

