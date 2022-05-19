#!/usr/bin/env python
# input : unfiltered bam file,reference fasta
# output ：bed file,filtered bam file,logfile containing reads number


import sys, re
import pysam
from pyfaidx import Fasta
import argparse

# define argparse
parser = argparse.ArgumentParser()
parser.add_argument('-i','--ibam',required=True,help='input file with bam format')
parser.add_argument('-r','--fasta',required=True,help='reference genome with fasta format')
parser.add_argument('-s','--bed',required=True,help='output file containing filtering reads with bed format')
parser.add_argument('--uniq',help='output uniqCount')
#parser.add_argument('-o','--outbam',required=True,help='output filtered bamfile')
args = parser.parse_args()

bam = args.ibam
#outbamfile = args.outbam
ref = args.fasta
outbedfile = args.bed
outuniq = open(args.uniq,'w')

if re.findall('hg38',str(ref)):
	chrom = ['chr'+str(i) for i in range(1,23)] + ['chrX']
if re.findall('mm10',str(ref)):
	chrom = ['chr'+str(i) for i in range(1,20)] + ['chrX']

def fetch_sequence(fasta, chrom, start, end):
    try:
        sequence = fasta[chrom][start:end]
    except KeyError:
        sys.stderr.write("warning: {name} not found in file\n".format(**locals()))
        return
    except ValueError as ve:
        sys.stderr.write(str(ve))
        return
    return sequence

# loading file
bamfile = pysam.AlignmentFile(bam,'rb')
#outbam = pysam.AlignmentFile(outbamfile, "wb", template=bamfile)
fasta = Fasta(ref,rebuild=False)
out = open(outbedfile,'w')
count = 0


# filtering reads using pysam
for Chr in chrom:
    for read in bamfile.fetch(Chr):
        if read.is_duplicate:
            continue
        if read.is_read2:
            continue
        if read.is_unmapped:
            continue
        if read.mate_is_unmapped:
            continue
        if read.mapping_quality < 25:
            continue 
        if read.is_secondary:
            continue
        if not read.is_proper_pair:
            continue
        if read.is_reverse:
            #outbam.write(read)
            start = read.reference_end - 5
            end = read.reference_end + 5
            strand = "-"
            score = 60
            sequence = fetch_sequence(fasta,Chr,start,end)
            if sequence == None:
                continue
            seq_up = sequence.reverse.complement.seq.upper()
        else:
            #outbam.write(read)
            start = read.reference_start - 5
            end = read.reference_start + 5
            strand = "+"
            score = 0
            sequence = fetch_sequence(fasta,Chr,start,end)
            if sequence == None:
                continue
            seq_up = sequence.seq.upper()
        if seq_up.count("N") or len(seq_up) != 10:
            continue
        tmp = "\t".join(map(str,[Chr,start,end,seq_up,score,strand]))
        print(tmp,file=out)
        count += 1


print(count,file=outuniq)

bamfile.close()
out.close()
outuniq.close()
