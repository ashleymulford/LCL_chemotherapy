#Import necessary package
import pandas as pd

#Read in fam and geno files
ALL_fam = pd.read_csv('/home/ashley/LCL_chemotherapy/ALL/ALL_orderedby_ASN_CEU_YRI.fam', delimiter = " ", header=None)
ALL_geno = pd.read_csv('/home/ashley/LCL_chemotherapy/ALL/ALL_orderedby_ASN_CEU_YRI.geno', delimiter = "\t", header=None)

#Create ped file from subset of fam file
ALL_ped = ALL_fam.iloc[0:, 1:7]

#Transpose geno file
ALL_geno_transposed = ALL_geno.transpose()

#Loop through columns of transposed geno file
for column in ALL_geno_transposed:
  #Create list from each column
  snp_list = ALL_geno_transposed[column]
  snp_list = snp_list.tolist()
  snp_list = snp_list[0].split(",")
  #Save minor allele value
  minor_allele = snp_list[1]
  #Save major allele value
  major_allele = snp_list[2]
  #Create empty lists
  snp_allele1 = []
  snp_allele2 = []
  #Create list of dosages
  dosages = snp_list[3:len(snp_list)]
  #Convert from type chr to type float
  dosages = list(map(float, dosages))
  
  #Iterate through dosages
  for dose in dosages:
    #round to int
    dose = round(dose)
    #Create lists of minor allele and major allele for each snp
    if dose == 0:
      snp_allele1.append(major_allele)
      snp_allele2.append(major_allele)
    
    if dose == 1:
      snp_allele1.append(major_allele)
      snp_allele2.append(minor_allele)
    
    if dose == 2:
      snp_allele1.append(minor_allele)
      snp_allele2.append(minor_allele)
  
  #Add columns to ped file    
  ALL_ped["snp_allele1"]=snp_allele1
  ALL_ped["snp_allele2"]=snp_allele2
  #Rename columns (can't add a new column with the name of an existing column)
  ALL_ped=ALL_ped.rename(columns={"snp_allele1" : "A1", "snp_allele2" : "A2"})

#Output data frame to directory
ALL_ped.to_csv("/home/ashley/LCL_chemotherapy/ALL.ped", sep = "\t", header = None, index = None)
