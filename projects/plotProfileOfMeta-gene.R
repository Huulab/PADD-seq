#!/usr/bin/env Rscript

options(stringsAsFactors = F)
options(scipen = 20)

rm(list=ls())

readplot <- function(sm){
  dat <- read.table(sm,header = T,sep='\t')
  y <- cbind(dat$TS,dat$NTS)
  prefix <- strsplit(sm,split="\\.")[[1]][1]
  main <- paste(prefix,"TS vs NTS")
  pdf(paste0(prefix,".readProfile.pdf"),width = 9,height = 5.5)
  par(mar=c(3,5,3,6.5))
  matplot(y,type="l",lty=1,col=c("blue","red"),
          main=main,cex.main=1.2,cex.lab=1,cex.axis=1,
          las=1,mgp=c(2.5,0.8,0),pty="m", ylim=c(0,0.5),
          axes=F,ylab ="RPKM")
  
  at <- c(1,101,201,301,401,501)
  labels <- c("-10K", "TSS", "10K", "20K", "30K","40k")
  axis(1,tck=-0.02, xaxs="i", at=at,labels=labels,las=1,cex.axis=1,mgp=c(3,0.6,0)) 
  axis(2,tck=-0.02, yaxs="i", las=1, mgp=c(3,0.6,0))
  axis(3,tick=FALSE,labels=FALSE)
  axis(4,tick=FALSE,labels=FALSE)
  grid(col='grey',lwd=0.8,lty=2)
  legend('right',inset = c(-0.18),
         legend = c('TS','NTS'),bty = 'o',
         col=c("blue","red"),lty=1,lwd=2,xpd = TRUE)
  box()
  dev.off()
}


samples <- list.files(pattern = 'rawValue')

for (sample in samples){
  readplot(sample)
}
