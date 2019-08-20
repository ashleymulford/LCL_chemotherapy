#Import necessary libraries
library(data.table)
library(dplyr)
library(ggplot2)

#Read in hapmap and fam files, name columns, and join to get file with pop, FID, and IID
hapmappopinfo<-fread("/home/ashley/LCL_chemotherapy/pop_HM3_hg19_forPCA.txt") %>% select (V1,V3)
ALL_fam<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_orderedby_ASN_CEU_YRI.fam") %>% select (V2,V3)
colnames(hapmappopinfo) <- c("pop","IID")
colnames(ALL_fam) <- c("FID","IID")
popinfo <- left_join(ALL_fam, hapmappopinfo, by="IID")

#Individuals found in fam file and not in hapmap file have a pop of NA, replace with GWAS
popinfo <- mutate(popinfo, pop=ifelse(is.na(pop),'GWAS', as.character(pop)))

#Read in pcs (plink output)
pcs <- fread("/home/ashley/LCL_chemotherapy/ALL/ALL_plinkfiles_&_PCA/ALL_subset.eigenvec", header=F)

#Merge and rename columns with first 10 pcs
pcdf <- data.frame(popinfo, pcs[,3:ncol(pcs)]) %>% rename(PC1=V3,PC2=V4,PC3=V5,PC4=V6,PC5=V7,PC6=V8,PC7=V9,PC8=V10,PC9=V11,PC10=V12)

#Filter data frame to contain individuals with pop GWAS only
gwas <- filter(pcdf,pop=='GWAS')

#Calcuate proportion variance explained by each PC
eval <- scan("/home/ashley/LCL_chemotherapy/ALL/ALL_plinkfiles_&_PCA/ALL_subset.eigenval")[1:10]
skree<-round(eval/sum(eval),3)
skree<-cbind.data.frame(skree,c(1,2,3,4,5,6,7,8,9,10))
colnames(skree)<-c("percent_var", "PC")


#Make 6 PCA plots:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_plinkfiles_&_PCA/ALL_PCA_plots_yri.pdf")

#Proportion Variance Plot
ggplot(data=skree, aes(x=PC, y=percent_var)) + geom_point() + geom_line() + scale_x_continuous(breaks = 1:10) + ggtitle("Proportion of variance explained")

#PCA Plot 1 (PC1 vs PC2)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC2,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC2")

#PCA Plot 2 (PC1 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC3")

#PCA Plot 1 (PC2 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC2,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC2 vs PC3")

#PCA with HAPMAP populations
yri <- filter(pcdf,pop=='YRI')
uPC1 <- mean(yri$PC1) + 5*sd(yri$PC1)
lPC1 <- mean(yri$PC1) - 5*sd(yri$PC1)
uPC2 <- mean(yri$PC2) + 5*sd(yri$PC2)
lPC2 <- mean(yri$PC2) - 5*sd(yri$PC2)
ggplot() + geom_point(data=gwas,aes(x=PC1,y=PC2,col=pop,shape=pop))+geom_point(data=hm3,aes(x=PC1,y=PC2,col=pop,shape=pop))+ theme_bw() +geom_vline(xintercept=c(uPC1,lPC1)) +geom_hline(yintercept=c(uPC2,lPC2)) + ggtitle("Assuming homogeneous, non-admixed")

inclusion <- gwas[gwas$PC1 >= lPC1,]
inclusion <- inclusion[inclusion$PC1 <= uPC1,]
inclusion <- inclusion[inclusion$PC2 >= lPC2,]
inclusion <- inclusion[inclusion$PC2 <= uPC2,]
samples <- inclusion[,1:2]
table(inclusion$pop)

dim(samples)[1]
dim(gwas)[1]-dim(samples)[1]

ggplot() + geom_point(data=gwas,aes(x=PC1,y=PC2,col=gwas$IID %in% samples$IID,shape=gwas$IID %in% samples$IID))+geom_point(data=hm3,aes(x=PC1,y=PC2,col=pop,shape=pop))+ theme_bw() + ggtitle("Assuming homogeneous, non-admixed")

dev.off() 
