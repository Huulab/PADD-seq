#!/usr/bin/env python
#stat Dibase ratio using bed file
#Usage: countDipyrimidine.py xxx.bed xxx.DipyrimidineRatio.txt
#By Zhu,Yongchang

import sys
import pandas as pd

def countDibase(seq_list):
    dibase_dict = {}
    for seq in seq_list:
        dibase = seq[3:5]
        k = dibase_dict.get(dibase, 0)
        dibase_dict[dibase] = k + 1
    return dibase_dict

bed = sys.argv[1]
seq_list = [line.split("\t")[3] for line in open(bed)]

outfile = sys.argv[2]

dat = pd.DataFrame(0, index=['0'], columns=['TT', 'TC', 'CT', 'CC'])

dibasestmp = countDibase(seq_list)
#计算二嘧啶总量sum
sum = 0
for J in dibasestmp.keys():
    sum = sum + dibasestmp.get(J)

dat.loc['0','TT'] = (dibasestmp.get('TT',0) / sum)
dat.loc['0','TC'] = (dibasestmp.get('TC',0) / sum)
dat.loc['0','CT'] = (dibasestmp.get('CT',0) / sum)
dat.loc['0','CC'] = (dibasestmp.get('CC',0) / sum)

dat.to_csv(outfile,sep='\t',float_format=None,header =True,index=False, quoting=None)
