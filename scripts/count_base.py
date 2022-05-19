#!/usr/bin/env python
# stat base ratio using bed file
# Usage: count_base.py xxx.bed xxx.basecount.txt

import sys
import pandas as pd

def count_single_base(seq_list, index):
	base_dict = {}
	for seq in seq_list:
		base = seq[index]
		k = base_dict.get(base, 0)
		base_dict[base] = k + 1
	return base_dict

bed = sys.argv[1]
seq_list = [line.split("\t")[3] for line in open(bed)]

outfile = sys.argv[2]

dat = pd.DataFrame(0,index=range(10),columns=['T', 'C', 'G', 'A'])

for i in range(10):
	basestmp = count_single_base(seq_list,i)
	for k in basestmp.keys():
		dat.loc[i,k] = basestmp.get(k)


dat.to_csv(outfile,sep='\t',float_format=None,header =True,index=False, quoting=None)
