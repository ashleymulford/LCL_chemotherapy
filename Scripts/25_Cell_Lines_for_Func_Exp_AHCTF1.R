#Finding other Cell Lines to use - AHCTF1

AHCTF1_cell_lines<-fread("/home/ashley/LCL_chemotherapy/Cell_Line_followup/mRNA expression (RNAseq)_ AHCTF1.txt")
AHCTF1_tissues<-colnames(AHCTF1_cell_lines)

for (tiss in AHCTF1_tissues) {
  tiss_list <- regmatches(tiss, regexpr("_", tiss), invert = TRUE )
  tiss_list <- unlist(tiss_list)
  if (exists("AHCTF1_cell_line")) {
    AHCTF1_cell_line <- append(AHCTF1_cell_line, tiss_list[1])
  }
  else {
    AHCTF1_cell_line <- tiss_list[1]
  }
  if (exists("AHCTF1_tiss")) {
    AHCTF1_tiss <- append(AHCTF1_tiss, tiss_list[2])
  }
  else {
    AHCTF1_tiss <- tiss_list[2]
  }
}

AHCTF1_cell_lines<-transpose(AHCTF1_cell_lines)
AHCTF1_cell_lines<-add_column(AHCTF1_cell_lines, AHCTF1_tiss, .before = "V1")
AHCTF1_cell_lines<-add_column(AHCTF1_cell_lines, AHCTF1_cell_line, .before = "AHCTF1_tiss")
colnames(AHCTF1_cell_lines)<- c("cell_line", "tissue", "AHCTF1_mRNA_exp")
AHCTF1_cell_lines<-AHCTF1_cell_lines[-1,]

cape_AUC<-fread("/home/ashley/LCL_chemotherapy/Cell_Line_followup/Cape_IC50_AUC.txt")

AHCTF1_cell_lines_cape_AUC<-inner_join(AHCTF1_cell_lines, cape_AUC, by = c("cell_line" = "Cell line"))
AHCTF1_cell_lines_cape_AUC<-na.omit(AHCTF1_cell_lines_cape_AUC)

AHCTF1_mrna_exp<-AHCTF1_cell_lines_cape_AUC$AHCTF1_mRNA_exp
for (val in AHCTF1_mrna_exp) {
  val_num <- as.numeric(val)
  if (exists("mrna_exp")) {
    mrna_exp <- append(mrna_exp, val_num)
  }
  else {
    mrna_exp <- val_num
  }
}

AHCTF1_cell_lines_cape_AUC<-add_column(AHCTF1_cell_lines_cape_AUC, mrna_exp, .before = "TCGA classification")

AHCTF1_cell_lines_cape_AUC<-select(AHCTF1_cell_lines_cape_AUC, 1:2, 4:7, 9)

pdf("/home/ashley/AHCTF1_cell_lines_plot.pdf")
ggplot(AHCTF1_cell_lines_cape_AUC, aes(x = AHCTF1_cell_lines_cape_AUC$cell_line, y = AHCTF1_cell_lines_cape_AUC$AUC )) +
  geom_point(size = 0.75, color = "#ec328c") + 
  scale_x_discrete(name = "Cell Line") + 
  scale_y_continuous(name = "CAPE_AUC") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), text = element_text(size = 10), plot.title = element_text(hjust = 0.5)) +
  ggtitle("AHCTF1 Cell Lines")
dev.off()

pdf("/home/ashley/AHCTF1_mRNA_plot.pdf")
ggplot(AHCTF1_cell_lines_cape_AUC, aes(x = AHCTF1_cell_lines_cape_AUC$mrna_exp, y = AHCTF1_cell_lines_cape_AUC$AUC )) +
  geom_point(size = 0.75, color = "#ec328c") + 
  scale_x_continuous(name = "mRNA Expression") + 
  scale_y_continuous(name = "CAPE_AUC") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), text = element_text(size = 10), plot.title = element_text(hjust = 0.5)) +
  ggtitle("AHCTF1 Cell Lines")
dev.off()
