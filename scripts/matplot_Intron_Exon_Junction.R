{
  rm(list=ls())
  library(ggplot2)
  library(ggalt)
  library(patchwork)
}

#Center
{
  
  data_for_0_center_NTS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.forwardStrandIntron_center_NTS.tab", sep = "\t")
  data_res_0_center_NTS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.reverseStrandIntron_center_NTS.tab", sep = "\t")
  data_0_center_NTS <- rbind(data_for_0_center_NTS,data_res_0_center_NTS)
  mean_0_center_NTS <- colMeans(data_0_center_NTS, na.rm=TRUE)
  mean_0_center_NTS <- as.data.frame(mean_0_center_NTS)
  mean_0_center_NTS$mean_0_center_NTS <- (mean_0_center_NTS$mean_0_center_NTS)/2
  
  
  data_for_0_center_TS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.forwardStrandIntron_center_TS.tab", sep = "\t")
  data_res_0_center_TS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.reverseStrandIntron_center_TS.tab", sep = "\t")
  data_0_center_TS <- rbind(data_for_0_center_TS,data_res_0_center_TS)
  mean_0_center_TS <- colMeans(data_0_center_TS, na.rm=TRUE)
  mean_0_center_TS <- as.data.frame(mean_0_center_TS)
  mean_0_center_TS$mean_0_center_TS <- (mean_0_center_TS$mean_0_center_TS)/2
  
  
  data_for_30_center_NTS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.forwardStrandIntron_center_NTS.tab", sep = "\t")
  data_res_30_center_NTS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.reverseStrandIntron_center_NTS.tab", sep = "\t")
  data_30_center_NTS <- rbind(data_for_30_center_NTS,data_res_30_center_NTS)
  mean_30_center_NTS <- colMeans(data_30_center_NTS, na.rm=TRUE)
  mean_30_center_NTS <- as.data.frame(mean_30_center_NTS)
  mean_30_center_NTS$mean_30_center_NTS <- (mean_30_center_NTS$mean_30_center_NTS)/2
  
  
  data_for_30_center_TS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.forwardStrandIntron_center_TS.tab", sep = "\t")
  data_res_30_center_TS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.reverseStrandIntron_center_TS.tab", sep = "\t")
  data_30_center_TS <- rbind(data_for_30_center_TS,data_res_30_center_TS)
  mean_30_center_TS <- colMeans(data_30_center_TS, na.rm=TRUE)
  mean_30_center_TS <- as.data.frame(mean_30_center_TS)
  mean_30_center_TS$mean_30_center_TS <- (mean_30_center_TS$mean_30_center_TS)/2
  
  matplot_center <- cbind(mean_0_center_NTS,mean_0_center_TS,mean_30_center_NTS,mean_30_center_TS)
  row.names(matplot_center) = NULL
  
}




#5 Intron
{
  data_for_0_TSS_NTS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.forwardStrandIntron_TSS_NTS.tab", sep = "\t")
  data_res_0_TSS_NTS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.reverseStrandIntron_TSS_NTS.tab", sep = "\t")
  data_0_TSS_NTS <- rbind(data_for_0_TSS_NTS,data_res_0_TSS_NTS)
  mean_0_TSS_NTS <- colMeans(data_0_TSS_NTS, na.rm=TRUE)
  mean_0_TSS_NTS <- as.data.frame(mean_0_TSS_NTS)
  mean_0_TSS_NTS$mean_0_TSS_NTS <- (mean_0_TSS_NTS$mean_0_TSS_NTS)/2
  
  
  data_for_0_TSS_TS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.forwardStrandIntron_TSS_TS.tab", sep = "\t")
  data_res_0_TSS_TS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.reverseStrandIntron_TSS_TS.tab", sep = "\t")
  data_0_TSS_TS <- rbind(data_for_0_TSS_TS,data_res_0_TSS_TS)
  mean_0_TSS_TS <- colMeans(data_0_TSS_TS, na.rm=TRUE)
  mean_0_TSS_TS <- as.data.frame(mean_0_TSS_TS)
  mean_0_TSS_TS$mean_0_TSS_TS <- (mean_0_TSS_TS$mean_0_TSS_TS)/2
  
  
  
  data_for_30_TSS_NTS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.forwardStrandIntron_TSS_NTS.tab", sep = "\t")
  data_res_30_TSS_NTS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.reverseStrandIntron_TSS_NTS.tab", sep = "\t")
  data_30_TSS_NTS <- rbind(data_for_30_TSS_NTS,data_res_30_TSS_NTS)
  mean_30_TSS_NTS <- colMeans(data_30_TSS_NTS, na.rm=TRUE)
  mean_30_TSS_NTS <- as.data.frame(mean_30_TSS_NTS)
  mean_30_TSS_NTS$mean_30_TSS_NTS <- (mean_30_TSS_NTS$mean_30_TSS_NTS)/2
  
  
  
  data_for_30_TSS_TS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.forwardStrandIntron_TSS_TS.tab", sep = "\t")
  data_res_30_TSS_TS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.reverseStrandIntron_TSS_TS.tab", sep = "\t")
  data_30_TSS_TS <- rbind(data_for_30_TSS_TS,data_res_30_TSS_TS)
  mean_30_TSS_TS <- colMeans(data_30_TSS_TS, na.rm=TRUE)
  mean_30_TSS_TS <- as.data.frame(mean_30_TSS_TS)
  mean_30_TSS_TS$mean_30_TSS_TS <- (mean_30_TSS_TS$mean_30_TSS_TS)/2
  
  
  matplot_TSS <- cbind(mean_0_TSS_NTS,mean_0_TSS_TS,mean_30_TSS_NTS,mean_30_TSS_TS)
  row.names(matplot_TSS) = NULL
  
}




#3 Intron
{
  data_for_0_TES_NTS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.forwardStrandIntron_TES_NTS.tab", sep = "\t")
  data_res_0_TES_NTS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.reverseStrandIntron_TES_NTS.tab", sep = "\t")
  data_0_TES_NTS <- rbind(data_for_0_TES_NTS,data_res_0_TES_NTS)
  mean_0_TES_NTS <- colMeans(data_0_TES_NTS, na.rm=TRUE)
  mean_0_TES_NTS <- as.data.frame(mean_0_TES_NTS)
  mean_0_TES_NTS$mean_0_TES_NTS <- (mean_0_TES_NTS$mean_0_TES_NTS)/2
  
  
  
  
  data_for_0_TES_TS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.forwardStrandIntron_TES_TS.tab", sep = "\t")
  data_res_0_TES_TS <- read.table("Matrix/Tab_Damage_UV/R19029847-HD2TCD4-NCLUV0IDS_UV.reverseStrandIntron_TES_TS.tab", sep = "\t")
  data_0_TES_TS <- rbind(data_for_0_TES_TS,data_res_0_TES_TS)
  mean_0_TES_TS <- colMeans(data_0_TES_TS, na.rm=TRUE)
  mean_0_TES_TS <- as.data.frame(mean_0_TES_TS)
  mean_0_TES_TS$mean_0_TES_TS <- (mean_0_TES_TS$mean_0_TES_TS)/2
  
  
  
  data_for_30_TES_NTS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.forwardStrandIntron_TES_NTS.tab", sep = "\t")
  data_res_30_TES_NTS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.reverseStrandIntron_TES_NTS.tab", sep = "\t")
  data_30_TES_NTS <- rbind(data_for_30_TES_NTS,data_res_30_TES_NTS)
  mean_30_TES_NTS <- colMeans(data_30_TES_NTS, na.rm=TRUE)
  mean_30_TES_NTS <- as.data.frame(mean_30_TES_NTS)
  mean_30_TES_NTS$mean_30_TES_NTS <- (mean_30_TES_NTS$mean_30_TES_NTS)/2
  
  
  
  data_for_30_TES_TS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.forwardStrandIntron_TES_TS.tab", sep = "\t")
  data_res_30_TES_TS <- read.table("Matrix/Tab_Damage_UV/R19046513-N4C2W1-NUV30IDS_UV.reverseStrandIntron_TES_TS.tab", sep = "\t")
  data_30_TES_TS <- rbind(data_for_30_TES_TS,data_res_30_TES_TS)
  mean_30_TES_TS <- colMeans(data_30_TES_TS, na.rm=TRUE)
  mean_30_TES_TS <- as.data.frame(mean_30_TES_TS)
  mean_30_TES_TS$mean_30_TES_TS <- (mean_30_TES_TS$mean_30_TES_TS)/2
  
  
  matplot_TES <- cbind(mean_0_TES_NTS,mean_0_TES_TS,mean_30_TES_NTS,mean_30_TES_TS)
  row.names(matplot_TES) = NULL
}



{
  pdf(paste0("5_Intron_Juction","_IDS.readProfile.pdf"),width = 8,height = 5.5)
  par(mar=c(3,5,3,8))
  # Colors
  matplot(as.matrix(matplot_TSS),type = "l", lty = c(4,1,4,1), col=c("#33CC33","#33CC33","#FF6666","#FF6666"), lwd = 1.5,
          main="5_Intron_Juction",cex.main=1.2,cex.lab=0.5,cex.axis=0.5,las=1,
          mgp=c(2.5,0.8,0),pty="m", ylim=c(0,5),axes=F,ylab ="Relative Signal")
  
  at <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41)
  labels <- c("-20","-19","-18","-17","-16","-15","-14","-13","-12","-11","-10","-9","-8","-7","-6","-5","-4","-3","-2","-1",
              "0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20")
  axis(1,tck=-0.02, xaxs="i", at=at,labels=labels,las=1,cex.axis=0.2,mgp=c(3,0.8,0)) 
  axis(2,tck=-0.02, yaxs="i", las=1, mgp=c(3,0.8,0))
  axis(3,tick=FALSE,labels=FALSE)
  axis(4,tick=FALSE,labels=FALSE)
  grid(col='grey',lwd=0.8,lty=2)
  legend('right',inset = c(-0.35),
         legend = c("0h NTS","0h TS",'0.5h NTS', '0.5h TS'),bty = 'n',
         col=c("#33CC33","#33CC33","#FF6666","#FF6666"),lty = c(4,1,4,1),lwd=1,xpd = TRUE, cex = 0.5,)
  box()
  dev.off()
  
}


{
  pdf(paste0("3_Intron_Juction","_IDS.readProfile.pdf"),width = 8,height = 5.5)
  par(mar=c(3,5,3,8))
  # Colors
  matplot(as.matrix(matplot_TES),type = "l", lty = c(4,1,4,1), col=c("#33CC33","#33CC33","#FF6666","#FF6666"), lwd = 1.5,
          main="3_Intron_Juction",cex.main=1.2,cex.lab=0.5,cex.axis=0.5,las=1,
          mgp=c(2.5,0.8,0),pty="m", ylim=c(0,5),axes=F,ylab ="Relative Signal")
  
  at <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41)
  labels <- c("-20","-19","-18","-17","-16","-15","-14","-13","-12","-11","-10","-9","-8","-7","-6","-5","-4","-3","-2","-1",
              "0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20")
  axis(1,tck=-0.02, xaxs="i", at=at,labels=labels,las=1,cex.axis=0.2,mgp=c(3,0.8,0)) 
  axis(2,tck=-0.02, yaxs="i", las=1, mgp=c(3,0.8,0))
  axis(3,tick=FALSE,labels=FALSE)
  axis(4,tick=FALSE,labels=FALSE)
  grid(col='grey',lwd=0.8,lty=2)
  legend('right',inset = c(0.2),
         legend = c("0h NTS","0h TS",'0.5h NTS', '0.5h TS'),bty = 'o',
         col=c("#33CC33","#33CC33","#FF6666","#FF6666"),lty = c(4,1,4,1),lwd=2,xpd = TRUE, cex = 0.5,)
  box()
  dev.off()
}
