#!/usr/bin/env python
# TSdat and NTSdat generated from assignReadtoGene.py 

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--t1',required=True,help='TSdat file 1')
parser.add_argument('--t2',required=True,help='TSdat file 2')
parser.add_argument('--nt1',required=True,help='NTSdat file 1')
parser.add_argument('--nt2',required=True,help='NTSdat file 2')
parser.add_argument('-r','--regionlength',required=True,type=int,help='the region length')
parser.add_argument('--binSize',type=int,default=100,help='set the bin size\nNote:the region length must can be divisible by this value.')
parser.add_argument('-bg','--bgValue',required=True,help='the back ground value to normalize reads')
parser.add_argument('--outRawvalue',help='output raw value by bins(normalized read counts by sequencing-depth)')
parser.add_argument('--outLine',help='output line plot.[Note:Value just normalized to seq-depth but G-content and input]')
#parser.add_argument('--outHeatmap',help='output heatmap plot')
args = parser.parse_args()

TSdat1=args.t1
TSdat2=args.t2
NTSdat1=args.nt1
NTSdat2=args.nt2
regionlen=args.regionlength
binsize=args.binSize
bgv=args.bgValue
outRawvalue=args.outRawvalue
outline=args.outLine
#outHeatmap=args.outHeatmap


def count_in_bin(x,y):
	if len(y) % x:
		exit("please input a valid binSize value.\n\trefers to --help")
	else:
		bs = []
		bl = len(y) // x
		for i in range(bl):
			tmplist = y[i*x:(i+1)*x]
			sumup = sum(tmplist)
			#sumup /= x
			bs.append(sumup)
		return bs



TSraw1=[[x for x in line.rstrip('\n\r').split('\t')] for line in open(TSdat1)]
TSraw2=[[x for x in line.rstrip('\n\r').split('\t')] for line in open(TSdat2)]
TSgenes=list(set([x[0] for x in TSraw1])) + list(set([x[0] for x in TSraw2]))

NTSraw1=[[x for x in line.rstrip('\n\r').split('\t')] for line in open(NTSdat1)]
NTSraw2=[[x for x in line.rstrip('\n\r').split('\t')] for line in open(NTSdat2)]
NTSgenes=list(set([x[0] for x in NTSraw1])) + list(set([x[0] for x in NTSraw2]))

# prepare data for plot
TSdf=pd.DataFrame(0.0,index=TSgenes,columns=list(range(0,regionlen)))
for i in TSraw1:
	TSdf.loc[i[0],int(i[1])]=float(i[2])
for i in TSraw2:
	TSdf.loc[i[0],int(i[1])]=float(i[2])

TSdf_mean = list(TSdf.mean(axis=0))
TSdf_scale = count_in_bin(binsize,TSdf_mean)

NTSdf=pd.DataFrame(0.0,index=NTSgenes,columns=list(range(0,regionlen)))
for i in NTSraw1:
	NTSdf.loc[i[0],int(i[1])]=float(i[2])
for i in NTSraw2:
	NTSdf.loc[i[0],int(i[1])]=float(i[2])

NTSdf_mean = list(NTSdf.mean(axis=0))
NTSdf_scale = count_in_bin(binsize,NTSdf_mean)


try:
	uc = float(bgv)
except ValueError:
	bgv = str(bgv)
	with open(bgv,'r') as baz:
		uc = baz.readline()
		uc = float(uc)

sf = 1e9 / (uc * binsize) # RPKM

TSdf_scale = [x*sf  for x in TSdf_scale]
NTSdf_scale = [x*sf  for x in NTSdf_scale]


'''
if isinstance(bgv,int):
	TSdf_scale = [x/bgv*10000000  for x in TSdf_scale]
	NTSdf_scale = [x/bgv*10000000  for x in NTSdf_scale]


if isinstance(bgv,str):
	with open(bgv,'r') as baz:
		uc = baz.readline()
		uc = int(float(uc))
		TSdf_scale = [x/uc*10000000  for x in TSdf_scale]
		NTSdf_scale = [x/uc*10000000  for x in NTSdf_scale]
'''

if outRawvalue:
	with open(outRawvalue,'w') as raw:
		print('TS\tNTS',file=raw)
		if len(TSdf_scale) == len(NTSdf_scale):
			for i in range(len(TSdf_scale)):
				print('%s	%s' % (TSdf_scale[i],NTSdf_scale[i]),file=raw)
		else:
			exit('TSdf_scale and NTSdf_scale length is different.')


if outline:
	fig = plt.figure(figsize=(10,6),dpi=150)
	plt.plot(TSdf_scale,color='blue',lw=1.5,label='TS')
	plt.plot(NTSdf_scale,color='red',lw=1.5,label='NTS')
	plt.xticks([0,100,200,300,400,500],['-10k','TSS','10k','20k','30k','40k'],rotation=30)
	plt.ylabel('RPKM',fontsize=16)
	plt.grid()
	plt.legend(fontsize=12,loc=2,bbox_to_anchor=(1.01,0.6))
	T = str(outline).split('.')[0]
	plt.title(T,fontsize=16)
	fig.savefig(outline,dpi=300,bbox_inches="tight")
