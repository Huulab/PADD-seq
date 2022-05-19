#!/bin/bash

#usage: generateStrandSpecificBW.sh DataExample.BED
#bedToBam -i $1 -g ./genomeAnnotation/hg38.genome > $1.bam

#samtools sort -@ 10 -o $1.sorted.bam $1.bam

#samtools index $1.sorted.bam

#forward stramd
bamCoverage --bam $1.sorted.bam --outFileName $1.sorted.bam.forward.bw \
        --outFileFormat bigwig \
        -p max \
        --binSize 100 \
	--smoothLength 5000 \
	--normalizeUsing RPKM \
        --filterRNAstrand reverse
#reverse strand
bamCoverage --bam $1.sorted.bam --outFileName $1.sorted.bam.reverse.bw \
        --outFileFormat bigwig \
        -p max \
	--binSize 100 \
	--smoothLength 5000 \
        --normalizeUsing RPKM \
        --filterRNAstrand forward