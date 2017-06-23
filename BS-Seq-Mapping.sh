#!/bin/bash

ID=$(basename ${1} _1.fq.gz)
THREADS=10

bismark  \
--multicore ${THREADS}  \
/data1/linhua/QIANLAB/PROJECT/DNA_methylation_data_process/First_test/WGBS_INDEX/  \
-1 ${ID}_1.fq.gz \
-2 ${ID}_2.fq.gz

## OUTPUT == ${ID}_1_bismark_bt2_pe.bam  ::::  0hai_Rawdata_1_bismark_bt2_pe.bam

#samtools view -h ${ID}_1_bismark_bt2_pe.bam > ${ID}_1_bismark_bt2_pe.sam 

deduplicate_bismark -bam -p ${ID}_1_bismark_bt2_pe.bam 
 
bismark_methylation_extractor \
--multicore 12 \
--no_overlap \
--comprehensive \
--cytosine_report \
--CX_context \
--genome_folder /data1/linhua/QIANLAB/PROJECT/DNA_methylation_data_process/First_test/WGBS_INDEX/ \
${ID}_1_bismark_bt2_pe.deduplicated.bam