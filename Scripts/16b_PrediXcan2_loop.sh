#Create list of drugs
declare -a drugs=("arac" "cape" "carbo" "cis" "dauno" "etop" "pacl" "peme")

#Use loop to run PrediXcan step two through GEMMA (accounts for relatedness)
for db in /home/wheelerlab3/Data/PrediXcan_db/GTEx-V7_HapMap-2017-11-29/*.db
  do 
  #create tissue prefix for output
  prefix=${db#/home/wheelerlab3/Data/PrediXcan_db/GTEx-V7_HapMap-2017-11-29/gtex_v7_}
  prefix=${prefix%_imputed_europeans_tw_0.5_signif.db}
  for drug in ${drugs[@]}
    do
    /usr/local/bin/gemma -g /home/ashley/LCL_chemotherapy/ALL/ALL_assoc_gemma_input/$prefix -notsnp -p /home/ashley/LCL_chemotherapy/ALL/ALL_phenotypes/ALL_${drug}_bestpheno_noids.txt -k /home/ashley/LCL_chemotherapy/ALL/ALL_relationship_matrix_maf.cXX.txt -c /home/ashley/LCL_chemotherapy/ALL/ALL_covariates.txt -lmm 4 -o ALL_assoc_${drug}_$prefix
  done
done
