#Finding other Cell Lines to use - STARD5

#STARD5 data from expression database: https://portals.broadinstitute.org/ccle
STARD5_cell_lines<-fread("/home/ashley/LCL_chemotherapy/Cell_Line_followup/mRNA expression (RNAseq)_ STARD5.txt")
STARD5_tissues<-colnames(STARD5_cell_lines)

#Separate cell line from tissue
for (tiss in STARD5_tissues) {
  tiss_list <- regmatches(tiss, regexpr("_", tiss), invert = TRUE )
  tiss_list <- unlist(tiss_list)
  if (exists("STARD5_cell_line")) {
    STARD5_cell_line <- append(STARD5_cell_line, tiss_list[1])
  }
  else {
    STARD5_cell_line <- tiss_list[1]
  }
  if (exists("STARD5_tiss")) {
    STARD5_tiss <- append(STARD5_tiss, tiss_list[2])
  }
  else {
    STARD5_tiss <- tiss_list[2]
  }
}

#Three column dataframe with cell line, tissue, and mRNA exp
STARD5_cell_lines<-transpose(STARD5_cell_lines)
STARD5_cell_lines<-add_column(STARD5_cell_lines, STARD5_tiss, .before = "V1")
STARD5_cell_lines<-add_column(STARD5_cell_lines, STARD5_cell_line, .before = "STARD5_tiss")
colnames(STARD5_cell_lines)<- c("cell_line", "tissue", "STARD5_mRNA_exp")
STARD5_cell_lines<-STARD5_cell_lines[-1,]

#Etop IC50 data from drug database: https://www.cancerrxgene.org/
Etop_IC50<-fread("/home/ashley/LCL_chemotherapy/Cell_Line_followup/Etop_IC50_AUC.txt")

#Merge STARD5 mRNA expression and Etop IC50 data
STARD5_cell_lines_Etop_IC50<-inner_join(STARD5_cell_lines, Etop_IC50, by = c("cell_line" = "Cell line"))
STARD5_cell_lines_Etop_IC50<-na.omit(STARD5_cell_lines_Etop_IC50)

#Convert mRNA exp from chr to num
STARD5_mrna_exp<-STARD5_cell_lines_Etop_IC50$STARD5_mRNA_exp
for (val in STARD5_mrna_exp) {
  val_num <- as.numeric(val)
  if (exists("mrna_exp")) {
    mrna_exp <- append(mrna_exp, val_num)
  }
  else {
    mrna_exp <- val_num
  }
}

STARD5_cell_lines_Etop_IC50<-add_column(STARD5_cell_lines_Etop_IC50, mrna_exp, .before = "TCGA classification")
STARD5_cell_lines_Etop_IC50<-select(STARD5_cell_lines_Etop_IC50, 1:2, 4:8)


#Plot
pdf("/home/ashley/STARD5_cell_lines_plot.pdf")
ggplot(STARD5_cell_lines_Etop_IC50, aes(x = STARD5_cell_lines_Etop_IC50$cell_line, y = STARD5_cell_lines_Etop_IC50$IC50 )) +
  geom_point(size = 0.75, color = "#ec328c") + 
  scale_x_discrete(name = "Cell Line") + 
  scale_y_continuous(name = "ETOP_IC50") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), text = element_text(size = 10), plot.title = element_text(hjust = 0.5)) +
  ggtitle("STARD5 Cell Lines")
dev.off()

pdf("/home/ashley/STARD5_mRNA_plot.pdf")
ggplot(STARD5_cell_lines_Etop_IC50, aes(x = STARD5_cell_lines_Etop_IC50$mrna_exp, y = STARD5_cell_lines_Etop_IC50$IC50 )) +
  geom_point(size = 0.75, color = "#ec328c") + 
  scale_x_continuous(name = "mRNA Expression") + 
  scale_y_continuous(name = "ETOP_IC50") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), text = element_text(size = 10), plot.title = element_text(hjust = 0.5)) +
  ggtitle("STARD5 Cell Lines")
dev.off()
