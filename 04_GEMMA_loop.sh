#Create lists, one of drugs and on of populations 
declare -a drugs=("arac" "capecitabine" "${drug}" "cisplatin" "daunorubicin" "etoposide" "paclitaxel" "pemetrexed")
declare -a pops=("CEU" "${pop}")

#Use loop to run GWAS through GEMMA (accounts for relatedness)
for drug in ${drugs[@]}
  do
  for pop in ${pops[@]}
    do
    gemma -g /home/ashley/LCL_chemotherapy/${pop}/${pop}.TGP_and_imputed.rmBAD.20130526.geno -p /home/ashley/LCL_chemotherapy/${pop}/${pop}_phenotypes/${pop}_${drug}_bestpheno_noids.txt -a /home/ashley/LCL_chemotherapy/${pop}/${pop}.TGP_and_imputed.rmBAD.20130526.snp.info -k /home/ashley/LCL_chemotherapy/${pop}/${pop}_relationship_matrix_maf.cXX.txt -lmm 4 -o /home/ashley/LCL_chemotherapy/${pop}/${pop}_GWAS_results/${pop}_GWAS_${drug}
  done
done
