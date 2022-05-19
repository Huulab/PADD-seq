#!/bin/bash
#SBATCH -J bed2bw2TsHeatmap   
#SBATCH -p interactive             
#SBATCH -N 1                 
#SBATCH --cpus-per-task=5
#SBATCH --mem=25G    
#SBATCH -t 0-05:50:00        
#SBATCH -o info.slarm.out      
#SBATCH --mail-type=ALL
#SBATCH --mail-user=949678447@qq.com

#usage: bed2bw2TsHeatmap <BED/GFF/VCF>
bedToBam -i $1 -g ~/dataForScriptsToAsk/hg38.genome > $1.bam

samtools sort -@ 5 -o $1.sorted.bam $1.bam

samtools index $1.sorted.bam

