#!/usr/bin/env python

import sys, gzip

bed = sys.argv[1]
plus_out = open(sys.argv[2],'w')
minus_out = open(sys.argv[3],'w')

if bed.endswith('.gz'):
    fh = gzip.open(bed)
else:
    fh = open(bed)
    
for line in fh:
    line = line.rstrip().split('\t')
    strand = line[5]
    if strand == '+':
        print('\t'.join(map(str,line)),file=plus_out)
    elif strand == '-':
        print('\t'.join(map(str,line)),file=minus_out)

fh.close()
plus_out.close()
minus_out.close()

