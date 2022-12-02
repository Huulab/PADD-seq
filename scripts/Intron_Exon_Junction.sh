#!/bin/bash
for i in R19029847-HD2TCD4-NCLUV0IDS_UV R19046513-N4C2W1-NUV30IDS_UV R19029847-HD2TCD4-NCLUV0IDS_UV R19046513-N4C2W1-NUV30IDS_UV

do

#get template strand signal
computeMatrix reference-point \
        --scoreFileName ${i}.sorted.bam.reverse.bw \
        --regionsFileName Ann_intron_out_for.bed \
        --outFileName ${i}.forwardStrandIntron_TSS_TS.Matrix.gz \
        --outFileNameMatrix ${i}.forwardStrandIntron_TSS_TS.tab \
        --referencePoint TSS \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1

computeMatrix reference-point \
       --scoreFileName ${i}.sorted.bam.forward.bw \
        --regionsFileName Ann_intron_out_res.bed \
        --outFileName ${i}.reverseStrandIntron_TSS_TS.Matrix.gz \
        --outFileNameMatrix ${i}.reverseStrandIntron_TSS_TS.tab \
        --referencePoint TSS \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1




#get non-template strand signal
computeMatrix reference-point \
        --scoreFileName ${i}.sorted.bam.reverse.bw \
        --regionsFileName Ann_intron_out_res.bed \
        --outFileName ${i}.reverseStrandIntron_TSS_NTS.Matrix.gz \
        --outFileNameMatrix ${i}.reverseStrandIntron_TSS_NTS.tab \
        --referencePoint TSS \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1
computeMatrix reference-point \
       --scoreFileName ${i}.sorted.bam.forward.bw \
        --regionsFileName Ann_intron_out_for.bed \
        --outFileName ${i}.forwardStrandIntron_TSS_NTS.Matrix.gz \
        --outFileNameMatrix ${i}.forwardStrandIntron_TSS_NTS.tab \
        --referencePoint TSS \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1




#get template strand signal
computeMatrix reference-point \
        --scoreFileName ${i}.sorted.bam.reverse.bw \
        --regionsFileName Ann_intron_out_for.bed \
        --outFileName ${i}.forwardStrandIntron_TES_TS.Matrix.gz \
        --outFileNameMatrix ${i}.forwardStrandIntron_TES_TS.tab \
        --referencePoint TES \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1
computeMatrix reference-point \
       --scoreFileName ${i}.sorted.bam.forward.bw \
        --regionsFileName Ann_intron_out_res.bed \
        --outFileName ${i}.reverseStrandIntron_TES_TS.Matrix.gz \
        --outFileNameMatrix ${i}.reverseStrandIntron_TES_TS.tab \
        --referencePoint TES \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1




#get non-template strand signal
computeMatrix reference-point \
        --scoreFileName ${i}.sorted.bam.reverse.bw \
        --regionsFileName Ann_intron_out_res.bed \
        --outFileName ${i}.reverseStrandIntron_TES_NTS.Matrix.gz \
        --outFileNameMatrix ${i}.reverseStrandIntron_TES_NTS.tab \
        --referencePoint TES \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1
computeMatrix reference-point \
       --scoreFileName ${i}.sorted.bam.forward.bw \
        --regionsFileName Ann_intron_out_for.bed \
        --outFileName ${i}.forwardStrandIntron_TES_NTS.Matrix.gz \
        --outFileNameMatrix ${i}.forwardStrandIntron_TES_NTS.tab \
        --referencePoint TES \
        --beforeRegionStartLength 20 \
        --afterRegionStartLength 21 \
        --missingDataAsZero \
        --numberOfProcessors 10 \
        --binSize 1

done
