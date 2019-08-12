#Import necessary libraries
library(data.table)
library(dplyr)
library(tibble)

#Read in snp info file and add column names
ALL_snp_info<-fread("/home/ashley/LCL_chemotherapy/ALL/ALL_snp.info")
colnames(ALL_snp_info)<-c("rs", "bp", "chr")

#Extract chr column
chr<-select(ALL_snp_info, 3)
chr<-as.vector(unlist(chr))

#Select for rs and bp columns
ALL_map<-select(ALL_snp_info, 1:2)

#Add chr column
ALL_map<-add_column(ALL_map, chr = chr, .before = "rs")

#Add cm column
ALL_map<-add_column(ALL_map, cm = "0", .before = "bp")

#Output data frame to directory
fwrite(ALL_map, "/home/ashley/LCL_chemotherapy/ALL/ALL.map")
