#Finding other Cell Lines to use - USF1

USF1_cell_lines<-fread("/home/ashley/LCL_chemotherapy/Cell_Line_followup/mRNA expression (RNAseq)_ USF1.txt")
USF1_tissues<-colnames(USF1_cell_lines)

for (tiss in USF1_tissues) {
  tiss_list <- regmatches(tiss, regexpr("_", tiss), invert = TRUE )
  tiss_list <- unlist(tiss_list)
  if (exists("USF1_cell_line")) {
    USF1_cell_line <- append(USF1_cell_line, tiss_list[1])
  }
  else {
    USF1_cell_line <- tiss_list[1]
  }
  if (exists("USF1_tiss")) {
    USF1_tiss <- append(USF1_tiss, tiss_list[2])
  }
  else {
    USF1_tiss <- tiss_list[2]
  }
}

USF1_cell_lines<-transpose(USF1_cell_lines)
USF1_cell_lines<-add_column(USF1_cell_lines, USF1_tiss, .before = "V1")
USF1_cell_lines<-add_column(USF1_cell_lines, USF1_cell_line, .before = "USF1_tiss")
colnames(USF1_cell_lines)<- c("cell_line", "tissue", "USF1_mRNA_exp")
USF1_cell_lines<-USF1_cell_lines[-1,]

cape_AUC<-fread("/home/ashley/Cape_IC50_AUC.txt")

USF1_cell_lines_cape_AUC<-inner_join(USF1_cell_lines, cape_AUC, by = c("cell_line" = "Cell line"))
USF1_cell_lines_cape_AUC<-na.omit(USF1_cell_lines_cape_AUC)

USF1_mrna_exp<-USF1_cell_lines_cape_AUC$USF1_mRNA_exp
for (val in USF1_mrna_exp) {
  val_num <- as.numeric(val)
  if (exists("mrna_exp")) {
    mrna_exp <- append(mrna_exp, val_num)
  }
  else {
    mrna_exp <- val_num
  }
}

USF1_cell_lines_cape_AUC<-add_column(USF1_cell_lines_cape_AUC, mrna_exp, .before = "TCGA classification")

USF1_cell_lines_cape_AUC<-select(USF1_cell_lines_cape_AUC, 1:2, 4:7, 9)

pdf("/home/ashley/USF1_cell_lines_plot.pdf")
ggplot(USF1_cell_lines_cape_AUC, aes(x = USF1_cell_lines_cape_AUC$cell_line, y = USF1_cell_lines_cape_AUC$AUC )) +
  geom_point(size = 0.75, color = "#ec328c") + 
  scale_x_discrete(name = "Cell Line") + 
  scale_y_continuous(name = "CAPE_AUC") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), text = element_text(size = 10), plot.title = element_text(hjust = 0.5)) +
  ggtitle("USF1 Cell Lines")
dev.off()

pdf("/home/ashley/USF1_mRNA_plot.pdf")
ggplot(USF1_cell_lines_cape_AUC, aes(x = USF1_cell_lines_cape_AUC$mrna_exp, y = USF1_cell_lines_cape_AUC$AUC )) +
  geom_point(size = 0.75, color = "#ec328c") + 
  scale_x_continuous(name = "mRNA Expression") + 
  scale_y_continuous(name = "CAPE_AUC") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), text = element_text(size = 10), plot.title = element_text(hjust = 0.5)) +
  ggtitle("USF1 Cell Lines")
dev.off()
