#!/usr/bin/env python

from __future__ import print_function
import sys
import re

if len(sys.argv)==1:
	print('Please give me a Bismark deduplicated output file!')
	print('Python scripts to convert ------[TODO]')
	sys.exit()
	
f = open(sys.argv[1],'r')  
# f=open("0hai_Rawdata_1_bismark_bt2_pe.deduplication_report.txt",'r')
result = list() 
for line in f.readlines():
    line = line.strip()
    result.append(line)

test=''.join([te for te in result if te.startswith("Total count of deduplicated leftover sequences:")])

pat1=re.compile(r'\s(\d+)\s')
Leftover_Reads=''.join(pat1.findall(test))
pat2=re.compile(r'\((\d+.\d+)\%')
Leftover_Percent=''.join(pat2.findall(test))

print(sys.argv[1].split(".")[0],Leftover_Reads,Leftover_Percent,sep="\t")

## Sample Leftover_Reads Leftover_Percent

