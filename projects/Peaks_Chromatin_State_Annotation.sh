#!/bin/bash
sed s/E18/Quies/g E114_18_core_K27ac_segments_hg38lift.bed \
		#| sed s/E17/ReprPCWk/g | sed s/E16/ReprPC/g | sed s/E15/EnhBiv/g | sed s/E14/TssBiv/g | sed s/E13/Het/g | sed s/E12/ZNF_Rpts/g \
		#| sed s/E11/EnhWk/g | sed s/E10/EnhA2/g | sed s/E9/EnhA1/g | sed s/E8/EnhG2/g | sed s/E7/EnhG1/g | sed s/E6/TxWk/g | sed s/E5/Tx/g \
		#| sed s/E4/TssFlnkD/g | sed s/E3/TssFlnkU/g | sed s/E2/TssFlnk/g | sed s/E1/TssA/g > E114_18_core_K27ac_segments_hg38lift_ann.bed
for i in A549H3k9aCis90C1_peaks.FDR0.01.summit A549H3k9aCis90C2_peaks.FDR0.01.summit A549H3k9aCis90P1_peaks.FDR0.01.summit A549H3k9aCis90P2_peaks.FDR0.01.summit
do
	bedtools intersect -a ./Annotation/${i} -b E114_18_core_K27ac_segments_hg38lift_ann.bed -wa -wb > ${i}_ann.bed
done
