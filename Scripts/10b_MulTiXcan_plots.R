#Import necessary libraries
library(data.table)
library(qqman)
library(colorscape)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create color vector
colors<-sequential_hcl(4,"SunsetDark")

#Create list of drugs for file input
drug_list <- c("arac", "cape", "carbo", "cis", "dauno", "etop", "pacl", "peme")

#Make QQ and Manhattan plots using loop
for(drug in drug_list){
  Multixcan_YRI <- fread("/home/ashley/LCL_chemotherapy/YRI/YRI_multixcan_output/YRI_multixcan_" %&% drug %&% "_adj_BH.txt")
  #Remove status column (empty for all measured genes)
  Multixcan_YRI<-select(Multixcan_YRI, 1:9, 11:13)
  #Remove all rows with NAs
  Multixcan_YRI<-na.omit(Multixcan_YRI)
  
  png(filename = "YRI_MulTiXcan_" %&% drug %&% ".qqplot.png", res=100)
  qq(Multixcan_YRI$pvalue)
  dev.off()
  
  png(filename = "YRI_MulTiXcan_" %&% drug %&% ".manplot.png", res=100)
  manhattan(Multixcan_YRI, chr = "CHR", bp = "BP", p = "pvalue", col = colors)
  dev.off()
}
