#!/bin/bash
multiBamSummary bins \
--bamfiles /cluster/home/lilin/Project/DNA_Damage/Cis_chip/QC/PCA_PADD/*.bam \
--binSize 10000 \
--numberOfProcessors 10 \
--outRawCounts results.txt \
-o results.npz \

plotPCA -in readCounts.npz -o PCA_readCounts.png -T "PCA of read counts"
