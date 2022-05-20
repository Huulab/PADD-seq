#!/bin/bash

#usage: bash plotCorrelationForBins.sh <1.bed 2.bed 3.bed 4.bed>

#get scores
multiBamSummary bins \
	--bamfiles $1.sorted.bam $2.sorted.bam $3.sorted.bam $4.sorted.bam \
	--outFileName sorted.bam.Scores_per_bin.npz \
	--labels data1 data2 data3 data4 \
	--numberOfProcessors max \
	--binSize 100000

#plotCorrelation heatmap
plotCorrelation \
	--corData sorted.bam.Scores_per_bin.npz \
	--corMethod spearman \
	--skipZeros \
	--whatToPlot heatmap \
	--plotFile correlationHeatmapPerBin.pdf \
	--plotHeight 1.5 \
	--plotWidth 3 \
	--plotNumbers
	
