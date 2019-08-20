#Import necessary libraries
library(data.table)
library(dplyr)
library(ggplot2)

#Read in fam file and add column names
popinfo<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_orderedby_ASN_CEU_YRI.fam") %>% select (V1,V2,V3)
colnames(popinfo)<-c("pop", "FID", "IID")

#Read in pcs (plink output)
pcs<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_plinkfiles_&_PCA/ALL_subset.eigenvec", header=F)

#Merge and rename columns with first 10 pcs
pcdf<-data.frame(popinfo, pcs[,3:ncol(pcs)]) %>% rename(PC1=V3,PC2=V4,PC3=V5,PC4=V6,PC5=V7,PC6=V8,PC7=V9,PC8=V10,PC9=V11,PC10=V12)

#Calcuate proportion variance explained by each PC
eval<-scan("/home/ashley/LCL_chemotherapy/ALL/ALL_plinkfiles_&_PCA/ALL_subset.eigenval")[1:10]
skree<-round(eval/sum(eval),3)
skree<-cbind.data.frame(skree,c(1,2,3,4,5,6,7,8,9,10))
colnames(skree)<-c("percent_var", "PC")

#Make PCA plots:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_plinkfiles_&_PCA/ALL_PCA_plots.pdf")

ggplot(data=skree, aes(x=PC, y=percent_var)) + geom_point() + geom_line() + scale_x_continuous(breaks = 1:10) + ggtitle("Proportion of variance explained")

#PCA Plot 1 (PC1 vs PC2)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC2,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC2")

#PCA Plot 2 (PC1 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC3")

#PCA Plot 1 (PC2 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC2,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC2 vs PC3")

dev.off() 
