#Finding other Cell Lines to use - FAM173B

FAM173B_cell_lines<-fread("/home/ashley/LCL_chemotherapy/Cell_Line_followup/mRNA expression (RNAseq)_ FAM173B.txt")
FAM173B_tissues<-colnames(FAM173B_cell_lines)

for (tiss in FAM173B_tissues) {
  tiss_list <- regmatches(tiss, regexpr("_", tiss), invert = TRUE )
  tiss_list <- unlist(tiss_list)
  if (exists("FAM173B_cell_line")) {
    FAM173B_cell_line <- append(FAM173B_cell_line, tiss_list[1])
  }
  else {
    FAM173B_cell_line <- tiss_list[1]
  }
  if (exists("FAM173B_tiss")) {
    FAM173B_tiss <- append(FAM173B_tiss, tiss_list[2])
  }
  else {
    FAM173B_tiss <- tiss_list[2]
  }
}

FAM173B_cell_lines<-transpose(FAM173B_cell_lines)
FAM173B_cell_lines<-add_column(FAM173B_cell_lines, FAM173B_tiss, .before = "V1")
FAM173B_cell_lines<-add_column(FAM173B_cell_lines, FAM173B_cell_line, .before = "FAM173B_tiss")
colnames(FAM173B_cell_lines)<- c("cell_line", "tissue", "FAM173B_mRNA_exp")
FAM173B_cell_lines<-FAM173B_cell_lines[-1,]

cis_IC50<-fread("/home/ashley/LCL_chemotherapy/Cell_Line_followup/Cis_IC50_AUC.txt")

FAM173B_cell_lines_cis_IC50<-inner_join(FAM173B_cell_lines, cis_IC50, by = c("cell_line" = "Cell line"))
FAM173B_cell_lines_cis_IC50<-na.omit(FAM173B_cell_lines_cis_IC50)

FAM173B_mrna_exp<-FAM173B_cell_lines_cis_IC50$FAM173B_mRNA_exp
for (val in FAM173B_mrna_exp) {
  val_num <- as.numeric(val)
  if (exists("mrna_exp")) {
    mrna_exp <- append(mrna_exp, val_num)
  }
  else {
    mrna_exp <- val_num
  }
}

FAM173B_cell_lines_cis_IC50<-add_column(FAM173B_cell_lines_cis_IC50, mrna_exp, .before = "TCGA classification")

FAM173B_cell_lines_cis_IC50<-select(FAM173B_cell_lines_cis_IC50, 1:2, 4:8)

cisp_IC50<-FAM173B_cell_lines_cis_IC50$IC50
for (val in cisp_IC50) {
  val_log <- log10(val)
  if (exists("log_IC50")) {
    log_IC50 <- append(log_IC50, val_log)
  }
  else {
    log_IC50 <- val_log
  }
}

FAM173B_cell_lines_cis_IC50<-add_column(FAM173B_cell_lines_cis_IC50, log_IC50)


pdf("/home/ashley/FAM173B_cell_lines_plot.pdf")
ggplot(FAM173B_cell_lines_cis_IC50, aes(x = FAM173B_cell_lines_cis_IC50$cell_line, y = FAM173B_cell_lines_cis_IC50$IC50 )) +
  geom_point(size = 0.75, color = "#ec328c") + 
  scale_x_discrete(name = "Cell Line") + 
  scale_y_continuous(name = "CIS_IC50") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), text = element_text(size = 10), plot.title = element_text(hjust = 0.5)) +
  ggtitle("FAM173B Cell Lines")
dev.off()

pdf("/home/ashley/FAM173B_mRNA_plot.pdf")
ggplot(FAM173B_cell_lines_cis_IC50, aes(x = FAM173B_cell_lines_cis_IC50$mrna_exp, y = FAM173B_cell_lines_cis_IC50$IC50 )) +
  geom_point(size = 0.75, color = "#ec328c") + 
  scale_x_continuous(name = "mRNA Expression") + 
  scale_y_continuous(name = "CIS_IC50") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), text = element_text(size = 10), plot.title = element_text(hjust = 0.5)) +
  ggtitle("FAM173B Cell Lines")
dev.off()

pdf("/home/ashley/FAM173B_mRNA_log_plot.pdf")
ggplot(FAM173B_cell_lines_cis_IC50, aes(x = FAM173B_cell_lines_cis_IC50$mrna_exp, y = FAM173B_cell_lines_cis_IC50$log_IC50)) +
  geom_point(size = 0.75, color = "#ec328c") + 
  scale_x_continuous(name = "mRNA Expression") + 
  scale_y_continuous(name = "CIS_log_IC50") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), text = element_text(size = 10), plot.title = element_text(hjust = 0.5)) +
  ggtitle("FAM173B Cell Lines")
dev.off()

