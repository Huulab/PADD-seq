#!/bin/bash

#usage: bed2bam.sh DataExample.bed
bedToBam -i $1 -g ~/dataForScriptsToAsk/hg38.genome > $1.bam

samtools sort -@ 5 -o $1.sorted.bam $1.bam

samtools index $1.sorted.bam

