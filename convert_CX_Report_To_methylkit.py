#!/usr/bin/env python
from __future__ import print_function,division
import sys
import decimal

## Example from https://bioconductor.org/packages/release/bioc/vignettes/methylKit/inst/doc/methylKit.html#1_introduction
#chrBase	chr	base	strand	coverage	freqC	freqT
#chr21.9764539	chr21	9764539	R	12	25.00	75.00
#chr21.9764513	chr21	9764513	R	12	0.00	100.00

print('chrBase','chr','base','strand','coverage','freqC','freqT',sep="\t")
d = {"-":"R","+":"F"} ## For replace
for line in sys.stdin.readlines():
    L = line.strip().split("\t")
    if (int(L[3])+int(L[4]))!=0:
        chrBase=L[0].replace("Chr","chr")+"."+L[1]
        chr=L[0].replace("Chr","chr")
        base=L[1]
        strand=d[L[2]]
        coverage=int(L[3])+int(L[4])
        freqC= decimal.Decimal(100*int(L[3])/(int(L[3])+int(L[4]))).quantize(decimal.Decimal('0.00')) ## methylated
        freqT= decimal.Decimal(100*int(L[4])/(int(L[3])+int(L[4]))).quantize(decimal.Decimal('0.00')) ## unmethylated
        print(chrBase,chr,base,strand,coverage,freqC,freqT,sep="\t")
    else:
        chrBase=L[0].replace("Chr","chr")+"."+L[1]
        chr=L[0].replace("Chr","chr")
        base=L[1]
        strand=d[L[2]]
        coverage=int(L[3])+int(L[4])
        freqC=decimal.Decimal(0).quantize(decimal.Decimal('0.00'))
        freqT=decimal.Decimal(0).quantize(decimal.Decimal('0.00'))
        print(chrBase,chr,base,strand,coverage,freqC,freqT,sep="\t")