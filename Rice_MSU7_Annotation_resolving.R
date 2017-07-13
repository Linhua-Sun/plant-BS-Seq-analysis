setwd("/Users/sunlinhua/Downloads/Correlation-2017-06-21/Oryza-lincRNA/T")
## Import libraries & Necessary env----
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(GenomicAlignments))
suppressPackageStartupMessages(library(GenomicFeatures))
suppressPackageStartupMessages(library(GenomicRanges))
suppressPackageStartupMessages(library(GenometriCorr))
suppressPackageStartupMessages(library(rtracklayer))
suppressPackageStartupMessages(library("BSgenome.Osativa.MSU.MSU7"))
library(stringr)
Rice_Seqinfo<-dropSeqlevels(seqinfo(BSgenome.Osativa.MSU.MSU7),c("ChrC","ChrM","ChrUn","ChrSy"))
seqlevelsStyle(Rice_Seqinfo)<-"ncbi"
seqlevelsStyle(Rice_Seqinfo)<-"ucsc"
## MSU7 Rice Gene Annotation Analysis ----
MSU7<-import("/Users/sunlinhua/Downloads/Correlation-2017-06-21/Oryza-lincRNA/MSU7_Rice_Annotation.gff3")
MSU7[MSU7$type=="gene"] %>% length 
cMSU7<-keepStandardChromosomes(MSU7,pruning.mode="coarse")
cMSU7_gene<-cMSU7[cMSU7$type=="gene"]
seqlevels(cMSU7_gene)<-str_replace_all(seqlevels(cMSU7_gene),"Chr","chr")
cMSU7_Non_TE_Genes <- cMSU7_gene[!(str_detect(cMSU7_gene$Note,"transposon"))]
## TF ----
Osj_TF_list<-fread("/Users/sunlinhua/Downloads/Correlation-2017-06-21/Oryza-lincRNA/Osj_TF_list")
Osj_TF_ID<-unique(Osj_TF_list$Gene_ID)
MSU_TF<-cMSU7_gene[cMSU7_gene$ID %in% Osj_TF_ID]
seqlevels(MSU_TF)<-str_replace_all(seqlevels(MSU_TF),"Chr","chr")
MSU_TF_Non_TE_Genes<-MSU_TF[!(str_detect(MSU_TF$Note,"transposon"))]
## Import data ----
rice_linc<-fread("/Users/sunlinhua/Downloads/Correlation-2017-06-21/Oryza-lincRNA/Oryza-lincRNA.csv")
rice_linc$Strand[rice_linc$Strand=="."]<-"*"
rice_linc_GR<-GRanges(seqnames = rice_linc$Chr,ranges = IRanges(start = rice_linc$Start,end = rice_linc$End),strand = rice_linc$Strand,seqinfo = Rice_Seqinfo,FlankingGene=rice_linc$FlankingGene,Note=rice_linc$ID)
length(rice_linc_GR)
rice_linc_GR<-rice_linc_GR[order(rice_linc_GR)]
## length ----
length(cMSU7_gene)
length(cMSU7_Non_TE_Genes)
length(MSU_TF)
length(MSU_TF_Non_TE_Genes)
length(rice_linc_GR)

## Export
export.gff3(cMSU7_gene,"cMSU7_gene.gff3")
export.gff3(cMSU7_Non_TE_Genes,"cMSU7_Non_TE_Genes.gff3")
export.gff3(MSU_TF,"MSU_TF.gff3")
export.gff3(MSU_TF_Non_TE_Genes,"MSU_TF_Non_TE_Genes.gff3")
export.gff3(rice_linc_GR,"rice_linc_GR.gff3")