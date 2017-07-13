## ----
library(ggpubr)
## Plot Ecdf ----
linc_VS_MSU7_Genes<-fread("linc_VS_cMSU7_gene.bed")
linc_VS_MSU7_non_TE_Genes<-fread("linc_VS_cMSU7_Non_TE_Genes.bed")
linc_VS_MSU7_TF_Genes<-fread("linc_VS_MSU_TF.bed")
linc_VS_MSU7_TF_Non_TE<-fread("linc_VS_MSU_TF_Non_TE_Genes.bed")

linc_VS_MSU7_Genes$Group<-"Genes"
linc_VS_MSU7_non_TE_Genes$Group<-"Non-TE-Genes"
linc_VS_MSU7_TF_Genes$Group<-"TF-Genes"
linc_VS_MSU7_TF_Non_TE$Group<-"TF-Non-Genes"

STM<-rbind(linc_VS_MSU7_Genes,
linc_VS_MSU7_non_TE_Genes,
linc_VS_MSU7_TF_Genes,
linc_VS_MSU7_TF_Non_TE)

p <- ggecdf(
  STM,
  x = "V10",color ="Group",palette = "aaas",
  size = 1
)
ggpar(p,font.legend = c(15),legend="right",xlab="Fractional distance",ylab="Cumulative fraction",font.tickslab=c(15,"bold"),font.x=c(18,"bold"),font.y=c(18,"bold"))+border(color="black",size=1.5,linetype=NULL)+geom_abline(intercept=0,slope=0,colour="grey",linetype="dashed",size=1.0)+geom_abline(intercept=1,slope=0,colour="grey",linetype="dashed",size=1.0)+geom_abline(intercept=0,slope=2,colour="black",linetype="dashed",size=1.2)

ggsave("Rice_Linc_Relative_Other_Feature.pdf",device = "pdf",width = 7,height = 5)
