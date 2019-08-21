#Create list of drugs
declare -a drugs=("arac" "cape" "carbo" "cis" "dauno" "etop" "pacl" "peme")

#Use loop to run MulTiXcan
for drug in ${drugs[@]}
  do
  usr/bin/python MulTiXcan.py --expression_folder /home/ashley/LCL_chemotherapy/ALL/ALL_predixcan_predict_output --expression_pattern "ALL_results_(.*)_predicted_expression.txt" --input_phenos_file /home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_phenos/ALL_${drug}.txt --input_phenos_column Pheno --covariates_file /home/ashley/LCL_chemotherpay/ALL/ALL_covariates.txt --mode linear --output /home/ashley/LCL_chemotherapy/ALL/ALL_multixcan_output/ALL_${drug}_multixcan
done
