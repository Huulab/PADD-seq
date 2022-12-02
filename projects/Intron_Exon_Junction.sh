#!/bin/bash
for i in R19029847-HD2TCD4-NCLUV0IDS_UV R19046513-N4C2W1-NUV30IDS_UV R19029847-HD2TCD4-NCLUV0IDS_UV R19046513-N4C2W1-NUV30IDS_UV

do

#get template strand signal
computeMatrix reference-point \
        --scoreFileName ${i}.sorted.bam.reverse.bw \
        --regionsFileName Ann_intron_out_for.bed \
        --outFileName ${i}.forwardStrandExon_TSS_TS.Matrix.gz \
        --outFileNameMatrix ${i}.forwardStrandExon_TSS_TS.tab \
        --referencePoint TSS \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1

computeMatrix reference-point \
       --scoreFileName ${i}.sorted.bam.forward.bw \
        --regionsFileName Ann_intron_out_res.bed \
        --outFileName ${i}.reverseStrandExon_TSS_TS.Matrix.gz \
        --outFileNameMatrix ${i}.reverseStrandExon_TSS_TS.tab \
        --referencePoint TSS \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1

#merge matrix.gz files
computeMatrixOperations rbind \
        --matrixFile ${i}.forwardStrandExon_TSS_TS.Matrix.gz ${i}.reverseStrandExon_TSS_TS.Matrix.gz \
        --outFileName ${i}.combinedExon_TSS_TS.Matrix.gz


#get non-template strand signal
computeMatrix reference-point \
        --scoreFileName ${i}.sorted.bam.reverse.bw \
        --regionsFileName Ann_intron_out_res.bed \
        --outFileName ${i}.reverseStrandExon_TSS_NTS.Matrix.gz \
        --outFileNameMatrix ${i}.reverseStrandExon_TSS_NTS.tab \
        --referencePoint TSS \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1
computeMatrix reference-point \
       --scoreFileName ${i}.sorted.bam.forward.bw \
        --regionsFileName Ann_intron_out_for.bed \
        --outFileName ${i}.forwardStrandExon_TSS_NTS.Matrix.gz \
        --outFileNameMatrix ${i}.forwardStrandExon_TSS_NTS.tab \
        --referencePoint TSS \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1
#merge matrix.gz files
computeMatrixOperations rbind \
        --matrixFile ${i}.forwardStrandExon_TSS_NTS.Matrix.gz ${i}.reverseStrandExon_TSS_NTS.Matrix.gz \
        --outFileName ${i}.combinedExon_TSS_NTS.Matrix.gz


#get template strand signal
computeMatrix reference-point \
        --scoreFileName ${i}.sorted.bam.reverse.bw \
        --regionsFileName Ann_intron_out_for.bed \
        --outFileName ${i}.forwardStrandExon_TES_TS.Matrix.gz \
        --outFileNameMatrix ${i}.forwardStrandExon_TES_TS.tab \
        --referencePoint TES \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1
computeMatrix reference-point \
       --scoreFileName ${i}.sorted.bam.forward.bw \
        --regionsFileName Ann_intron_out_res.bed \
        --outFileName ${i}.reverseStrandExon_TES_TS.Matrix.gz \
        --outFileNameMatrix ${i}.reverseStrandExon_TES_TS.tab \
        --referencePoint TES \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1

#merge matrix.gz files
computeMatrixOperations rbind \
        --matrixFile ${i}.forwardStrandExon_TES_TS.Matrix.gz ${i}.reverseStrandExon_TES_TS.Matrix.gz \
        --outFileName ${i}.combinedExon_TES_TS.Matrix.gz


#get non-template strand signal
computeMatrix reference-point \
        --scoreFileName ${i}.sorted.bam.reverse.bw \
        --regionsFileName Ann_intron_out_res.bed \
        --outFileName ${i}.reverseStrandExon_TES_NTS.Matrix.gz \
        --outFileNameMatrix ${i}.reverseStrandExon_TES_NTS.tab \
        --referencePoint TES \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1
computeMatrix reference-point \
       --scoreFileName ${i}.sorted.bam.forward.bw \
        --regionsFileName Ann_intron_out_for.bed \
        --outFileName ${i}.forwardStrandExon_TES_NTS.Matrix.gz \
        --outFileNameMatrix ${i}.forwardStrandExon_TES_NTS.tab \
        --referencePoint TES \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1
#merge matrix.gz files
computeMatrixOperations rbind \
        --matrixFile ${i}.forwardStrandExon_TES_NTS.Matrix.gz ${i}.reverseStrandExon_TES_NTS.Matrix.gz \
        --outFileName ${i}.combinedExon_TES_NTS.Matrix.gz

done
