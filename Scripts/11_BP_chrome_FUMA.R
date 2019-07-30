library(data.table)
library(tibble)

bp_chrome <- fread("/home/ashley/LCL_chemotherapy/BP_Chrome.txt")
genes <- select(bp_chrome, 3)
genes <- as.vector(unlist(genes))
bp_chrome <- select(bp_chrome, 1,2,4)

for (gene in genes) {
  gene<-substr(gene,0,15)
  if(exists("gene_list_fuma")){
    gene_list_fuma<-append(gene_list_fuma, gene)
  }
  else{
    gene_list_fuma<-c(gene)
  }
}

bp_chrome_fuma<-add_column(bp_chrome, gene = gene_list_fuma, .before = "CHR")
fwrite(bp_chrome_fuma, "/home/ashley/LCL_chemotherapy/BP_Chrome_fuma.txt", col.names = F, quote = F, sep = "\t")
