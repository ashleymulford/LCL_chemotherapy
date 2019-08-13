#Create list of drugs
declare -a drugs=("arac" "cape" "carbo" "cis" "dauno" "etop" "pacl" "peme")

#Use loop to run GWAS through GEMMA (accounts for relatedness)
for drug in ${drugs[@]}
  do
  gemma -g /home/ashley/LCL_chemotherapy/ALL/ALL_orderedby_ASN_CEU_YRI.geno -p /home/ashley/LCL_chemotherapy/ALL/ALL_phenotypes/ALL_${drug}_bestpheno_noids.txt -a /home/ashley/LCL_chemotherapy/ALL/ALL_snp.info -k /home/ashley/LCL_chemotherapy/ALL/ALL_relationship_matrix_maf.cXX.txt -lmm 4 -o /home/ashley/LCL_chemotherapy/ALL/ALL_GWAS_results/ALL_GWAS_${drug}
done
