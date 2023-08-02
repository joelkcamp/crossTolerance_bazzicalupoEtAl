
library(tidyverse)
library(cowplot)

# set wd
setwd("~/Dropbox/ottoLabNotes/scripts")
source("bioscreen_functions.R") #load function script for max growth rate
library(viridis)


codes <- read.csv("~/Dropbox/ottoLabNotes/oly077/mbm_codes/mbm_BIO2_3codes.csv") #codes file
biosc2 <- read.csv("~/Dropbox/ottoLabNotes/oly077/mbm_data/mbm_BIO2_3_20220304.csv") #data file

# Transpose dataframe
Time <- biosc2$Time #remember row id
bio2 <- as.data.frame(t(biosc2[,-1])) #transpose dataframe, exclude 1st colunmn
colnames(bio2) <- Time #create column names  

# Combine the bioscreen output with metadata
df = cbind(codes, bio2)

# loop through matrix to get growth curves, maximum slope and final OD per well
pdf("figure.pdf", onefile = TRUE) # name the figure
par(mfrow = c(10,4))
par(mar = c(0,0,0,0))
par(cex=0.5, mai=c(0.1,0.2,0.1,0.1))
for(r in 1:nrow(df)){
  temp = as.numeric(df[r, 7:198]) # change second number to the right number of columns of df
  time = seq(0.25, length(temp)/4, by = 0.25)
  test <- NA
  test[1] <- FALSE
   growth <- spline.slope(time, temp)
  t <- spline(time, temp)
   codes$initOD[r] <- mean(temp[3:8]) # Arbitrary choice, first between 45 min and 2.5 hours
  codes$OD_maxSlope[r] <- temp[which(time == t)]
  codes$finalOD[r] <- mean(temp[(length(temp)-5):length(temp)])
  codes$maxSlope[r] <- growth
  codes$time_maxSlope[r] <- t
  codes$finalTime[r] <- length(temp)/4
  plot(temp ~ time, xlim = c(0, 70), ylim = c(0, 1.5), xlab = "Time (h)", ylab = "OD")
  text(5, 1, paste0(codes$metal[r], " ", codes$strain[r], "\nC ", codes$conc[r],"\nr = ", round(growth, 3), "\ntime points\nlost: ", sum(test)), cex = 0.5)
  abline(v=t)
}
dev.off()

