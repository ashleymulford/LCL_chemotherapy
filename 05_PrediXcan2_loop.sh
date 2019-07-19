declare -a drugs=("arac" "capecitabine" "carboplatin" "cisplatin" "daunorubicin" "etoposide" "paclitaxel" "pemetrexed")
declare -a pops=("CEU" "YRI")

for db in /home/wheelerlab3/Data/PrediXcan_db/GTEx-V7_HapMap-2017-11-29/*.db

  do 
  prefix=${db#/home/wheelerlab3/Data/PrediXcan_db/GTEx-V7_HapMap-2017-11-29/gtex_v7_}
  prefix=${prefix%_imputed_europeans_tw_0.5_signif.db}
  
  for drug in ${drugs[@]}
    do
    for pop in ${pops[@]}
      do
      /usr/local/bin/gemma -g /home/ashley/LCL_chemotherapy/${pop}/${pop}_assoc_gemma_input/$prefix -notsnp -p /home/ashley/LCL_chemotherapy/${pop}/${pop}_phenotypes/${pop}_${drug}_bestpheno_noids.txt -k ${pop}_relationship_matrix_maf.cXX.txt -lmm 4 -o ${pop}_assoc_${drug}_$prefix
    done
  done
done
