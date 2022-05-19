#!/usr/bin/env python
# assign read to genes


import sys, argparse
from collections import defaultdict

parser = argparse.ArgumentParser()
parser.add_argument('--tssdat',required=True,help='TSS data file')
parser.add_argument('--intxt',required=True,help='stranded bed file')
parser.add_argument('--posout',required=True,help='output file refers to transcribed strand')
parser.add_argument('--negout',required=True,help='output file refers to non-transcribed strand')
parser.add_argument('-up','--upstream',type=int,default=10000,help='upstream of the site defined in tssdat.[usually TSS]')
parser.add_argument('-down','--downstream',type=int,default=40000,help='...')
args = parser.parse_args()

tssdata = args.tssdat
strand_file = args.intxt
posTSS = args.posout
negTSS = args.negout
upstream = args.upstream
downstream = args.downstream


# load files
TSSdat = [[x for x in line.rstrip('\n').split('\t')] for line in open(tssdata)]

bed = open(strand_file,'r')
TFData = {}
chroms = ['chr'+str(i) for i in range(1,23)] + ['chrX']
for i in chroms:
	TFData[i] = defaultdict(int)

for line in bed:
	line = line.rstrip().split('\t')
	chrom = line[0]
	site = int(line[1]) + 5
	TFData[chrom][site] += 1

cDat = {}
for i in chroms:
	cDat[i] = []

for i in chroms:
	chrdat = TFData[i]
	for k,v in chrdat.items():
		k = int(k)
		v = int(v)
		cDat[i].append([k,v])


# creat new files
f = open(posTSS, 'w')
h = open(negTSS,'w')


# iterate genes
for i in range(0,len(TSSdat)):
	if not TSSdat[i][1] in chroms:
		continue
	if TSSdat[i][3]=='+':
		selPos=range(int(TSSdat[i][2])-upstream,int(TSSdat[i][2])+downstream)
		chrdat = cDat[TSSdat[i][1]]
		k = -1
		while k+1 < len(chrdat) and chrdat[k+1][0] not in selPos:
			k+=1
		k+=1
		while k < len(chrdat) and chrdat[k][0] in selPos:
			f.write(TSSdat[i][0]+'\t'+str(selPos.index(chrdat[k][0]))+'\t'+str(chrdat[k][1])+'\n')
			k+=1


	elif TSSdat[i][3]=='-':
		selPos=range(int(TSSdat[i][2])+upstream,int(TSSdat[i][2])-downstream,-1)
		chrdat = cDat[TSSdat[i][1]]
		k = -1
		while k+1 < len(chrdat) and chrdat[k+1][0] not in selPos:
			k+=1
		k+=1
		while k < len(chrdat) and chrdat[k][0] in selPos:
			h.write(TSSdat[i][0]+'\t'+str(selPos.index(chrdat[k][0]))+'\t'+str(chrdat[k][1])+'\n')
			k+=1


f.close()
h.close()
bed.close()
