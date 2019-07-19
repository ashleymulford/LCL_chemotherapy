for db in /home/wheelerlab3/Data/PrediXcan_db/GTEx-V7_HapMap-2017-11-29/*.db


  do 
  prefix=${db#/home/wheelerlab3/Data/PrediXcan_db/GTEx-V7_HapMap-2017-11-29/gtex_v7_}
  prefix=${prefix%_imputed_europeans_tw_0.5_signif.db}
  /usr/local/bin/PrediXcan.py --predict --dosages /home/ashley/LCL_chemotherapy/CEU/CEU_predixcan_dosages --dosages_prefix chr --samples /home/ashley/LCL_chemotherapy/CEU/samples.txt --weights $db --output_prefix CEU_test_results_$prefix


done
