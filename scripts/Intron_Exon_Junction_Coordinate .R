{
  rm(list=ls())
  library(dplyr)
  library(tidyr)
  library(stringr)
  library(tidyverse)
  library(rtracklayer)
  library(gtools)
}



{
  Ann_intron <- read.table("DNA/ucsc_introns.tsv", sep = "\t")
  Ann_intron <- Ann_intron[,-5]
  colnames(Ann_intron) <- c("chr","start","end","V4","Strand")
  Ann_intron <- separate(Ann_intron, col = "V4", into = c("transcript_id","type","intron_id","number",
                                                          "CHR","START","F"))
  Ann_intron$start <- Ann_intron$`F`
  Ann_intron$`F` <- NULL
  Ann_intron$CHR <- NULL
  
  Ann_intron$width <- as.numeric(Ann_intron$end) - as.numeric(Ann_intron$start) + 1
  Ann_intron$exon_up_end <- as.numeric(Ann_intron$start)- 1
  Ann_intron$exon_down_start <- as.numeric(Ann_intron$end)+ 1
  
  Ann_intron$exon_up_end <- paste(Ann_intron$transcript_id, Ann_intron$type, Ann_intron$exon_up_end, sep = "_")
  Ann_intron$exon_down_start <- paste(Ann_intron$transcript_id, Ann_intron$type, Ann_intron$exon_down_start, sep = "_")
  
  
  
  
  
  Ann <- import("DNA/Homo_sapiens.GRCh38.107.chr.gtf")
  Ann <- as.data.frame(Ann)
  Ann_Exon <- subset(Ann, Ann$type == c("exon"))
  Ann_Exon <- subset( Ann_Exon, select = c("seqnames","start","end","strand","exon_number",
                                           "gene_id","width","transcript_id","transcript_version","exon_id")) 
  Ann_Exon$exon_start <- paste(Ann_Exon$transcript_id, Ann_Exon$transcript_version, Ann_Exon$start, sep = "_")
  Ann_Exon$exon_end <- paste(Ann_Exon$transcript_id, Ann_Exon$transcript_version, Ann_Exon$end, sep = "_")
  
}




#select transcripts with high expression in fibroblasts
{
  Transcripts_r1 <- read.table("DNA/Boundary/ENCFF535LLV.tsv", sep = "\t", header = T) 
  Transcripts_r1 <- subset(Transcripts_r1, TPM > 1)
  Transcripts_r1$transcript_id = unlist(str_split(Transcripts_r1$transcript_id,"[.]",simplify=T))[,1]
  Transcripts_r2 <- read.table("DNA/Boundary/ENCFF738OKW.tsv", sep = "\t", header = T) 
  Transcripts_r2 <- subset(Transcripts_r2, TPM > 1)
  Transcripts_r2$transcript_id = unlist(str_split(Transcripts_r2$transcript_id,"[.]",simplify=T))[,1]
  Transcripts_merge <- intersect(Transcripts_r1$transcript_id, Transcripts_r2$transcript_id)

}




#remove exon length less than 50bp

{
  Ann_intron <- subset(Ann_intron, Ann_intron$transcript_id %in% c(Transcripts_merge))
  Ann_Exon <-  subset(Ann_Exon, Ann_Exon$transcript_id %in% c(Transcripts_merge))
  
  
  Ann_Exon_outlier <- subset(Ann_Exon, Ann_Exon$width < 50)
  
  Ann_intron <- Ann_intron[-which(Ann_intron$exon_up_end %in% c(Ann_Exon_outlier$exon_end)),]
  Ann_intron <- Ann_intron[-which(Ann_intron$exon_down_start %in% c(Ann_Exon_outlier$exon_start)),]  
  
  Ann_intron <- Ann_intron[-which(Ann_intron$width < 50),]  
  Ann_intron <- Ann_intron[-which(nchar(Ann_intron$chr) > 5),]  
}




{
  Ann_intron$coor_ID <- paste(Ann_intron$chr, Ann_intron$start, Ann_intron$end, sep = "_")
  Ann_intron$rowId <- rownames(Ann_intron)
  Ann_intron <- group_by(Ann_intron, coor_ID)
  Ann_intron <- filter(Ann_intron, (n() == 1) | (n() > 1 & rowId == min(as.numeric(rowId))))
  
}




{
  Ann_intron_out <- ungroup(Ann_intron)
  Ann_intron_out$start <- as.numeric(Ann_intron_out$start) -1
  
  
  Ann_intron_out_for <- Ann_intron_out[which(Ann_intron_out$Strand == "+"),]
  Ann_intron_out_for <- select(Ann_intron_out_for, c("chr","start","end","number","width","Strand"))
  
  Ann_intron_out_res <- Ann_intron_out[which(Ann_intron_out$Strand == "-"),]
  Ann_intron_out_res <- select(Ann_intron_out_res, c("chr","start","end","number","width","Strand"))
  
  write.table(Ann_intron_out_for, file = "Ann_intron_out_for.bed",sep = "\t", col.names = F, row.names = F, quote = F)
  write.table(Ann_intron_out_res, file = "Ann_intron_out_res.bed",sep = "\t", col.names = F, row.names = F, quote = F)
}
