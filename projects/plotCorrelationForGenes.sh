#!/bin/bash

#usage: bash plotCorrelationForGenes.sh <1.bed 2.bed 3.bed 4.bed ...>

#get Template Strand scores
multiBigwigSummary BED-file \
	--bwfiles $1.sorted.bam.reverse.bw $2.sorted.bam.reverse.bw $3.sorted.bam.reverse.bw $4.sorted.bam.reverse.bw \
	--outFileName sorted.bam.reverse.Scores_per_TS.npz \
	--BED ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_forward-strand-gene.bed \
	--labels 0.5h_1 0.5h_2 2h_1 2h_2 \
	--numberOfProcessors max

multiBigwigSummary BED-file \
        --bwfiles $1.sorted.bam.forward.bw $2.sorted.bam.forward.bw $3.sorted.bam.forward.bw $4.sorted.bam.forward.bw \
        --outFileName sorted.bam.forward.Scores_per_TS.npz \
        --BED ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_reverse-strand-gene.bed \
        --labels 0.5h_1 0.5h_2 2h_1 2h_2 \
        --numberOfProcessors max

#merge .npz files #output <mergedScores.npz>
python ../scripts/merge_npz.py

#plotCorrelation Scatter_plot
plotCorrelation \
        --corData mergedScores.npz \
        --corMethod spearman \
	--skipZeros \
        --whatToPlot scatterplot \
        --plotFile correlationScatter.pdf \
	--log1p
	
