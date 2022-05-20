#!/bin/bash

#usage: plotHeatmap.sh DataExample.bed

#get template strand signal
computeMatrix reference-point \
        --scoreFileName $1.sorted.bam.reverse.bw \
        --regionsFileName ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_forward-strand-gene.bed \
        --outFileName $1.forwardStrandGene.TS.Matrix.gz \
        --referencePoint TSS \
        --beforeRegionStartLength 10000 \
        --afterRegionStartLength 100000 \
        --missingDataAsZero \
        --numberOfProcessors max \
        --binSize 100
computeMatrix reference-point \
       --scoreFileName $1.sorted.bam.forward.bw \
        --regionsFileName ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_reverse-strand-gene.bed \
        --outFileName $1.reverseStrandGene.TS.Matrix.gz \
        --referencePoint TSS \
        --beforeRegionStartLength 10000 \
        --afterRegionStartLength 100000 \
        --missingDataAsZero \
        --numberOfProcessors max \
        --binSize 100

#merge matrix.gz files
computeMatrixOperations rbind \
        --matrixFile $1.forwardStrandGene.TS.Matrix.gz $1.reverseStrandGene.TS.Matrix.gz \
        --outFileName $1.combinedGene.TS.Matrix.gz

#plot heatmap
plotHeatmap \
        --matrixFile $1.combinedGene.TS.Matrix.gz \
        --outFileName $1.TS.pdf \
        --sortUsing region_length \
        --sortRegions ascend \
        --regionsLabel "6409 expressed genes" \
        --samplesLabel "TS" \
        --heatmapHeight 3 \
        --heatmapWidth 1 \
        --whatToShow "heatmap and colorbar" \
        --zMin 0.4 \
        --zMax 0.6 \
        --colorList "white,blue"

#get non-template strand signal
computeMatrix reference-point \
        --scoreFileName $1.sorted.bam.reverse.bw \
        --regionsFileName ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_reverse-strand-gene.bed \
        --outFileName $1.reverseStrandGene.NTS.Matrix.gz \
        --referencePoint TSS \
        --beforeRegionStartLength 10000 \
        --afterRegionStartLength 100000 \
        --missingDataAsZero \
        --numberOfProcessors max \
        --binSize 100
computeMatrix reference-point \
       --scoreFileName $1.sorted.bam.forward.bw \
        --regionsFileName ../genomeAnnotation/BJ_hg38_FPKM-gt1_sorted_BEDmerged.distance-gt2k_Rmerged_forward-strand-gene.bed \
        --outFileName $1.forwardStrandGene.NTS.Matrix.gz \
        --referencePoint TSS \
        --beforeRegionStartLength 10000 \
        --afterRegionStartLength 100000 \
        --missingDataAsZero \
        --numberOfProcessors max \
        --binSize 100
#merge matrix.gz files
computeMatrixOperations rbind \
        --matrixFile $1.forwardStrandGene.NTS.Matrix.gz $1.reverseStrandGene.NTS.Matrix.gz \
        --outFileName $1.combinedGene.NTS.Matrix.gz

#plot heatmap
plotHeatmap \
        --matrixFile $1.combinedGene.NTS.Matrix.gz \
        --outFileName $1.NTS.pdf \
        --sortUsing region_length \
        --sortRegions ascend \
        --regionsLabel "6409 expressed genes" \
        --samplesLabel "NTS" \
        --heatmapHeight 3 \
        --heatmapWidth 1 \
        --zMin 0.4 \
        --zMax 0.6 \
        --colorList "white,blue" \
        --whatToShow "heatmap and colorbar"
