#!/bin/bash

#usage: sbatch bwPlotCorrelation.sbatch <1.bed 2.bed 3.bed>

#get scores
multiBamSummary bins \
	--bamfiles $1.sorted.bam $2.sorted.bam $3.sorted.bam $4.sorted.bam \
	--outFileName sorted.bam.Scores_per_bin.npz \
	--labels IS ID1 ID2 ID3 \
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
	
