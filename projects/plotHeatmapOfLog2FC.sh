#!/bin/bash

#usage: plotHeatmapOfLog2FC.sh <treatment1(2h).bed> <treatment2(0.5h).bed>

#log2ratio(treatment1/treatment2)
bigwigCompare \
	--bigwig1 $1.sorted.bam.forward.bw \
	--bigwig2 $2.sorted.bam.forward.bw \
	--operation log2 \
	--binSize 100 \
	--numberOfProcessors max \
	--outFileName $1.sorted.bam.forward.bw.log2ratio30.bw \
	--outFileFormat bigwig

bigwigCompare \
        --bigwig1 $1.sorted.bam.reverse.bw \
        --bigwig2 $2.sorted.bam.reverse.bw \
        --operation log2 \
        --binSize 100 \
        --numberOfProcessors max \
        --outFileName $1.sorted.bam.reverse.bw.log2ratio30.bw \
        --outFileFormat bigwig

#get template strand signal
computeMatrix reference-point \
        --scoreFileName $1.sorted.bam.reverse.bw.log2ratio30.bw \
        --regionsFileName ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_forward-strand-gene.bed \
        --outFileName $1.sorted.bam.reverse.bw.log2ratio30.bw.TS.Matrix.gz \
        --referencePoint TSS \
        --beforeRegionStartLength 10000 \
        --afterRegionStartLength 100000 \
        --missingDataAsZero \
        --numberOfProcessors max \
        --binSize 100
computeMatrix reference-point \
       --scoreFileName $1.sorted.bam.forward.bw.log2ratio30.bw \
        --regionsFileName ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_reverse-strand-gene.bed \
        --outFileName $1.sorted.bam.forward.bw.log2ratio30.bw.TS.Matrix.gz \
        --referencePoint TSS \
        --beforeRegionStartLength 10000 \
        --afterRegionStartLength 100000 \
        --missingDataAsZero \
        --numberOfProcessors max \
        --binSize 100

#merge matrix.gz files
computeMatrixOperations rbind \
        --matrixFile $1.sorted.bam.reverse.bw.log2ratio30.bw.TS.Matrix.gz $1.sorted.bam.forward.bw.log2ratio30.bw.TS.Matrix.gz \
        --outFileName $1.log2ratio30.combinedGene.TS.Matrix.gz

#plot heatmap
plotHeatmap \
        --matrixFile $1.log2ratio30.combinedGene.TS.Matrix.gz \
        --outFileName $1.log2FC.TS.pdf \
        --sortUsing region_length \
        --sortRegions ascend \
        --regionsLabel "6409 expressed genes" \
        --samplesLabel "log2FCTS" \
	--colorMap PiYG \
	--heatmapHeight 3 \
        --heatmapWidth 1 \
        --whatToShow "heatmap and colorbar" \
        --zMin -0.3 \
        --zMax 0.3

#get Non-template strand signal
computeMatrix reference-point \
        --scoreFileName $1.sorted.bam.forward.bw.log2ratio30.bw \
        --regionsFileName ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_forward-strand-gene.bed \
        --outFileName $1.sorted.bam.reverse.bw.log2ratio30.bw.NTS.Matrix.gz \
        --referencePoint TSS \
        --beforeRegionStartLength 10000 \
        --afterRegionStartLength 100000 \
        --missingDataAsZero \
        --numberOfProcessors max \
        --binSize 100
computeMatrix reference-point \
       --scoreFileName $1.sorted.bam.reverse.bw.log2ratio30.bw \
        --regionsFileName ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_reverse-strand-gene.bed \
        --outFileName $1.sorted.bam.forward.bw.log2ratio30.bw.NTS.Matrix.gz \
        --referencePoint TSS \
        --beforeRegionStartLength 10000 \
        --afterRegionStartLength 100000 \
        --missingDataAsZero \
        --numberOfProcessors max \
        --binSize 100

#merge matrix.gz files
computeMatrixOperations rbind \
        --matrixFile $1.sorted.bam.reverse.bw.log2ratio30.bw.NTS.Matrix.gz $1.sorted.bam.forward.bw.log2ratio30.bw.NTS.Matrix.gz \
        --outFileName $1.log2ratio30.combinedGene.NTS.Matrix.gz

#plot heatmap
plotHeatmap \
        --matrixFile $1.log2ratio30.combinedGene.NTS.Matrix.gz \
        --outFileName $1.log2FC.NTS.pdf \
        --sortUsing region_length \
        --sortRegions ascend \
        --regionsLabel "6409 expressed genes" \
        --samplesLabel "log2FCNTS" \
        --colorMap PiYG \
        --heatmapHeight 3 \
        --heatmapWidth 1 \
        --whatToShow "heatmap and colorbar" \
        --zMin -0.3 \
        --zMax 0.3
