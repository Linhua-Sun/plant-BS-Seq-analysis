#!/usr/bin/env python

from __future__ import print_function
import sys

if len(sys.argv)==1:
	print('Please give me a Bismark output file!')
	print('Python scripts to convert ------[TODO]')
	sys.exit()
	
f = open(sys.argv[1],'r')  
# f=open("0hai_Rawdata_1_bismark_bt2_PE_report.txt",'r')
result = list() 
for line in f.readlines():
    line = line.strip()
    result.append(line)

Total_Reads=''.join([te for te in result if te.startswith("Sequence pairs analysed in total:")]).split("\t")[1]
Unique_Reads=''.join([te for te in result if te.startswith("Number of paired-end alignments with a unique best hit:")]).split("\t")[1]
Mapping_efficiency=''.join([te for te in result if te.startswith("Mapping efficiency:")]).split("\t")[1].strip("%")
CG_ratio=''.join([te for te in result if te.startswith("C methylated in CpG context:")]).split("\t")[1].strip("%")
CHG_ratio=''.join([te for te in result if te.startswith("C methylated in CHG context:")]).split("\t")[1].strip("%")
CHH_ratio=''.join([te for te in result if te.startswith("C methylated in CHH context:")]).split("\t")[1].strip("%")
unknown_ratio=''.join([te for te in result if te.startswith("C methylated in unknown context (CN or CHN):")]).split("\t")[1].strip("%")
## 
print(sys.argv[1].split(".")[0],Total_Reads,Unique_Reads,Mapping_efficiency,CG_ratio,CHG_ratio,CHH_ratio,unknown_ratio,sep="\t")

## Sample Total_Reads Unique_Reads Mapping_efficiency CG_ratio CHG_ratio CHH_ratio unknown_ratio
