library(tidyverse)
library(cowplot)
library(viridis)
library(stats) #variance function
library(readr) #readcsv

# set wd
x = getwd()
setwd(x)
setwd("~/crossTolerance_bazzicalupoEtAl/cross_tol_data/")
source("bioscreen_functions.R")

# Shape of Tolerance
# OLY008 tested in metal concentrations

# cadmium
codes <- read.csv("tolerance/bioscreen20210519_codes.csv") # copper and Cadmium
biosc2 <- read.csv("tolerance/20210519_BIO1.csv")

# Transpose dataframe
Time <- biosc2$Time #remember row id
bio2 <- as.data.frame(t(biosc2[,-1])) #transpose dataframe, exclude 1st colunmn
colnames(bio2) <- Time #create column names  

# Combine the bioscreen output with metadata
df = cbind(codes, bio2)

# loop through file, calculate maxSlope
for(r in 1:nrow(df)){
  temp = as.numeric(df[r, 7:294])
  time = seq(0.25, length(temp)/4, by = 0.25)
  growth <- spline.slope(time, temp)
  t <- spline(time, temp)
  codes$initOD[r] <- mean(temp[3:8]) # Arbitrary choice, first between 45 min and 2.5 hours
  #codes$OD_maxSlope[r] <- temp[which(time == t)]
  codes$finalOD[r] <- mean(temp[(length(temp)-5):length(temp)])
  codes$maxSlope[r] <- growth
  codes$time_maxSlope[r] <- t
  codes$finalTime[r] <- length(temp)/4
}  

ypad = codes[which(codes$metal == "YPAD"), ] # 20210609 to get YPAD readings for OLY008 max slope
ypad008 = ypad[grep("OLY008", ypad$strain),]


CD = codes[which(codes$metal == "CD"), ] # 20210519 good 0.05	0.1	0.15	0.2	0.25	0.3	0.35
CD008 = CD[grep("OLY008", CD$strain),]
# add ypad estimate
CD008$conc = as.character(CD008$conc)
CD008$conc[CD008$conc == "1"] <- "0.05"
CD008$conc[CD008$conc == "2"] <- "0.1"
CD008$conc[CD008$conc == "3"] <- "0.15"
CD008$conc[CD008$conc == "4"] <- "0.2"
CD008$conc[CD008$conc == "5"] <- "0.25"
CD008$conc[CD008$conc == "6"] <- "0.3"
CD008$conc[CD008$conc == "7"] <- "0.35"

CD_OLY008<-ggplot(CD008) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Cadmium")+
  ylab(" ") +
  ylim(0,0.3)

# copper
CU = codes[which(codes$metal == "CU"), ] # 20210519 good 1	3	5	7	9	11	13
CU008 = CU[grep("OLY008", CU$strain),]
CU008$conc = as.character(CU008$conc)
CU008$conc[CU008$conc == "7"] <- "13"
CU008$conc[CU008$conc == "6"] <- "11"
CU008$conc[CU008$conc == "5"] <- "9"
CU008$conc[CU008$conc == "4"] <- "7"
CU008$conc[CU008$conc == "3"] <- "5"
CU008$conc[CU008$conc == "2"] <- "3"
CU008$conc[CU008$conc == "1"] <- "1"
CU008$conc <- factor(CU008$conc, levels=c("1", "3", "5", "7","9","11","13"))

CU_OLY008<-ggplot(CU008) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Copper")+
  ylab(" ") +
  ylim(0,0.3)


# cobalt
codes <- read.csv("tolerance/bioscreen20210526BIO1_codes.csv") # shape of tolerance nickel and cobalt
biosc2 <- read.csv("tolerance/20210526_BIO1.csv")

# Transpose dataframe
Time <- biosc2$Time #remember row id
bio2 <- as.data.frame(t(biosc2[,-1])) #transpose dataframe, exclude 1st colunmn
colnames(bio2) <- Time #create column names  

# Combine the bioscreen output with metadata
df = cbind(codes, bio2)

# loop through file, calculate maxSlope
for(r in 1:nrow(df)){
  temp = as.numeric(df[r, 7:294])
  time = seq(0.25, length(temp)/4, by = 0.25)
  growth <- spline.slope(time, temp)
  t <- spline(time, temp)
  codes$initOD[r] <- mean(temp[3:8]) # Arbitrary choice, first between 45 min and 2.5 hours
  #codes$OD_maxSlope[r] <- temp[which(time == t)]
  codes$finalOD[r] <- mean(temp[(length(temp)-5):length(temp)])
  codes$maxSlope[r] <- growth
  codes$time_maxSlope[r] <- t
  codes$finalTime[r] <- length(temp)/4
}  
CO = codes[which(codes$metal == "CO"), ] # 20210526 good 0.5	1	1.5	2	2.5	3	3.5
CO008 = CO[grep("OLY008", CO$strain),]
CO008$conc = as.character(CO008$conc)
CO008$conc[CO008$conc == "1"] <- "0.5"
CO008$conc[CO008$conc == "2"] <- "1"
CO008$conc[CO008$conc == "3"] <- "1.5"
CO008$conc[CO008$conc == "4"] <- "2"
CO008$conc[CO008$conc == "5"] <- "2.5"
CO008$conc[CO008$conc == "6"] <- "3"
CO008$conc[CO008$conc == "7"] <- "3.5"

CO_OLY008<-ggplot(CO008) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Cobalt")+
  ylab(" ") +
  ylim(0,0.3)

# manganese
codes <- read.csv("tolerance/bioscreen20210520_codes.csv") # shape of tolerance Manganese and Nickel
biosc2 <- read.csv("tolerance/20210520_BIO2.csv")

# Transpose dataframe
Time <- biosc2$Time #remember row id
bio2 <- as.data.frame(t(biosc2[,-1])) #transpose dataframe, exclude 1st colunmn
colnames(bio2) <- Time #create column names  

# Combine the bioscreen output with metadata
df = cbind(codes, bio2)

# loop through file, calculate maxSlope
for(r in 1:nrow(df)){
  temp = as.numeric(df[r, 7:294])
  time = seq(0.25, length(temp)/4, by = 0.25)
  growth <- spline.slope(time, temp)
  t <- spline(time, temp)
  codes$initOD[r] <- mean(temp[3:8]) # Arbitrary choice, first between 45 min and 2.5 hours
  #codes$OD_maxSlope[r] <- temp[which(time == t)]
  codes$finalOD[r] <- mean(temp[(length(temp)-5):length(temp)])
  codes$maxSlope[r] <- growth
  codes$time_maxSlope[r] <- t
  codes$finalTime[r] <- length(temp)/4
}  
MN = codes[which(codes$metal == "MN"), ] # 20210520 good 1	1.5	2	2.5	3	3.5	4
MN008 = MN[grep("OLY008", MN$strain),]
MN008$conc = as.character(MN008$conc)
MN008$conc[MN008$conc == "1"] <- "1"
MN008$conc[MN008$conc == "2"] <- "1.5"
MN008$conc[MN008$conc == "3"] <- "2"
MN008$conc[MN008$conc == "4"] <- "2.5"
MN008$conc[MN008$conc == "5"] <- "3"
MN008$conc[MN008$conc == "6"] <- "3.5"
MN008$conc[MN008$conc == "7"] <- "4"

MN_OLY008<-ggplot(MN008) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Manganese")+
  ylab(" ") +
  ylim(0,0.3)

# nickel
codes <- read.csv("tolerance/bioscreen20210603BIO2_codes.csv") # shape of tolerance Manganese and Nickel
biosc2 <- read.csv("tolerance/20210603_BIO2.csv")

# Transpose dataframe
Time <- biosc2$Time #remember row id
bio2 <- as.data.frame(t(biosc2[,-1])) #transpose dataframe, exclude 1st colunmn
colnames(bio2) <- Time #create column names  

# Combine the bioscreen output with metadata
df = cbind(codes, bio2)

# loop through file, calculate maxSlope
for(r in 1:nrow(df)){
  temp = as.numeric(df[r, 7:294])
  time = seq(0.25, length(temp)/4, by = 0.25)
  growth <- spline.slope(time, temp)
  t <- spline(time, temp)
  codes$initOD[r] <- mean(temp[3:8]) # Arbitrary choice, first between 45 min and 2.5 hours
  #codes$OD_maxSlope[r] <- temp[which(time == t)]
  codes$finalOD[r] <- mean(temp[(length(temp)-5):length(temp)])
  codes$maxSlope[r] <- growth
  codes$time_maxSlope[r] <- t
  codes$finalTime[r] <- length(temp)/4
}  
NI = codes[which(codes$metal == "NI"), ] # 20210603 good 0.5	1	1.5	2	2.5	3	3.5
NI008 = NI[grep("OLY008", NI$strain),]
NI008$conc = as.character(NI008$conc)
NI008$conc[NI008$conc == "1"] <- "0.5"
NI008$conc[NI008$conc == "2"] <- "1"
NI008$conc[NI008$conc == "3"] <- "1.5"
NI008$conc[NI008$conc == "4"] <- "2"
NI008$conc[NI008$conc == "5"] <- "2.5"
NI008$conc[NI008$conc == "6"] <- "3"
NI008$conc[NI008$conc == "7"] <- "3.5"
NI_OLY008<-ggplot(NI008)  + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Nickel")+
  ylab(" ") +
  ylim(0,0.3)


# zinc
codes <- read.csv("tolerance/bioscreen20210510_codes.csv") # ZINC shape of tolerance oly010 and 008 zinc ok, cd no, cu no, co no, mn no, fe no, ni no
biosc2 <- read.csv("tolerance/20210510_BIO2.csv")

# Transpose dataframe
Time <- biosc2$Time #remember row id
bio2 <- as.data.frame(t(biosc2[,-1])) #transpose dataframe, exclude 1st colunmn
colnames(bio2) <- Time #create column names  

# Combine the bioscreen output with metadata
df = cbind(codes, bio2)

# loop through file, calculate maxSlope
for(r in 1:nrow(df)){
  temp = as.numeric(df[r, 7:269])
  time = seq(0.25, length(temp)/4, by = 0.25)
  growth <- spline.slope(time, temp)
  t <- spline(time, temp)
  codes$initOD[r] <- mean(temp[3:8]) # Arbitrary choice, first between 45 min and 2.5 hours
  #codes$OD_maxSlope[r] <- temp[which(time == t)]
  codes$finalOD[r] <- mean(temp[(length(temp)-5):length(temp)])
  codes$maxSlope[r] <- growth
  codes$time_maxSlope[r] <- t
  codes$finalTime[r] <- length(temp)/4
}  
ZN = codes[which(codes$metal == "ZN"), ] # 20210510 good 1	2	3	4	5	6	7
ZN008 = ZN[grep("OLY008", ZN$strain),]
ZN008$conc = as.character(ZN008$conc) # zinc concentrations are the same as the numbers!
ZN_OLY008<-ggplot(ZN008) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Zinc")+
  ylab(" ") +
  ylim(0,0.3)

plot_grid(CD_OLY008, CO_OLY008, CU_OLY008, MN_OLY008, NI_OLY008, ZN_OLY008,  ncol = 3, labels = c("A", "B", "C", "D", "E", "F", "G"))


# OLY077 shape of tolerance ========================================================

codes <- read.csv("tolerance/bioscreen20211209codes.csv") # 
biosc2 <- read.csv("tolerance/20211209_BIO2.csv")


# Transpose dataframe
Time <- biosc2$Time #remember row id
bio2 <- as.data.frame(t(biosc2[,-1])) #transpose dataframe, exclude 1st colunmn
colnames(bio2) <- Time #create column names  

# Combine the bioscreen output with metadata
df = cbind(codes, bio2)

# loop through file, calculate maxSlope
for(r in 1:nrow(df)){
  temp = as.numeric(df[r, 7:198])
  time = seq(0.25, length(temp)/4, by = 0.25)
  growth <- spline.slope(time, temp)
  t <- spline(time, temp)
  codes$initOD[r] <- mean(temp[3:8]) # Arbitrary choice, first between 45 min and 2.5 hours
  #codes$OD_maxSlope[r] <- temp[which(time == t)]
  codes$finalOD[r] <- mean(temp[(length(temp)-5):length(temp)])
  codes$maxSlope[r] <- growth
  codes$time_maxSlope[r] <- t
  codes$finalTime[r] <- length(temp)/4
}  


ZN077 = codes[which(codes$metal == "ZN"), ] # 20210510 good 1	2	3	4	5	6	7
ZN077$conc[ZN077$conc == "10"] <- "4.4"
ZN077$conc[ZN077$conc == "9"] <- "3.9"
ZN077$conc[ZN077$conc == "8"] <- "3.4"
ZN077$conc[ZN077$conc == "7"] <- "2.9"
ZN077$conc[ZN077$conc == "6"] <- "2.4"
ZN077$conc[ZN077$conc == "5"] <- "1.9"
ZN077$conc[ZN077$conc == "4"] <- "1.4"
ZN077$conc[ZN077$conc == "3"] <- "0.9"
ZN077$conc[ZN077$conc == "2"] <- "0.4"
ZN077$conc[ZN077$conc == "1"] <- "0"

ZN077$conc <- factor(ZN077$conc, levels=c("0", "0.4",
                                          "0.9",
                                          "1.4",
                                          "1.9",
                                          "2.4",
                                          "2.9",
                                          "3.4",
                                          "3.9",
                                          "4.4"))


ZN077$conc = as.character(ZN077$conc) # zinc concentrations are the same as the numbers!

ZN_OLY077<-ggplot(ZN077) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Zinc")+
  ylab(" ") +
  ylim(0,0.3)

CD077 = codes[which(codes$metal == "CD"), ] # 20210510 good 1	2	3	4	5	6	7
CD077$conc[CD077$conc == "10"] <- "0.035"
CD077$conc[CD077$conc == "9"] <- "0.031"
CD077$conc[CD077$conc == "8"] <- "0.027"
CD077$conc[CD077$conc == "7"] <- "0.023"
CD077$conc[CD077$conc == "6"] <- "0.019"
CD077$conc[CD077$conc == "5"] <- "0.015"
CD077$conc[CD077$conc == "4"] <- "0.012"
CD077$conc[CD077$conc == "3"] <- "0.007"
CD077$conc[CD077$conc == "2"] <- "0.003"
CD077$conc[CD077$conc == "1"] <- "0"

CD077$conc <- factor(CD077$conc, levels=c("0", "0.003",
                                          "0.007",
                                          "0.012",
                                          "0.015",
                                          "0.019",
                                          "0.023",
                                          "0.027",
                                          "0.031",
                                          "0.035"))

CD077$conc = as.character(CD077$conc) # zinc concentrations are the same as the numbers!

CD_OLY077<-ggplot(CD077) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Cadmium")+
  ylab(" ") +
  ylim(0,0.3)


CO077 = codes[which(codes$metal == "CO"), ] # 20210510 good 1	2	3	4	5	6	7
#CO077 = CO077[!(CO077$repl=="blank"),]
CO077$conc[CO077$conc == "10"] <- "1.875"
CO077$conc[CO077$conc == "9"] <- "1.666"
CO077$conc[CO077$conc == "8"] <- "1.458"
CO077$conc[CO077$conc == "7"] <- "1.250"
CO077$conc[CO077$conc == "6"] <- "1.041"
CO077$conc[CO077$conc == "5"] <- "0.833"
CO077$conc[CO077$conc == "4"] <- "0.625"
CO077$conc[CO077$conc == "3"] <- "0.416"
CO077$conc[CO077$conc == "2"] <- "0.208"
CO077$conc[CO077$conc == "1"] <- "0"

CO077$conc <- factor(CO077$conc, levels=c("0", "0.208",
                                          "0.416",
                                          "0.625",
                                          "0.833",
                                          "1.041",
                                          "1.250",
                                          "1.458",
                                          "1.666",
                                          "1.875"))
CO077$conc = as.character(CO077$conc)

CO_OLY077<-ggplot(CO077) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Cobalt")+
  ylab(" ") +
  ylim(0,0.3)

CU077 = codes[which(codes$metal == "CU"), ] # 20210510 good 1	2	3	4	5	6	7
CU077$conc[CU077$conc == "10"] <- "7.9"
CU077$conc[CU077$conc == "9"] <- "7.02"
CU077$conc[CU077$conc == "8"] <- "6.14"
CU077$conc[CU077$conc == "7"] <- "5.26"
CU077$conc[CU077$conc == "6"] <- "4.38"
CU077$conc[CU077$conc == "5"] <- "3.51"
CU077$conc[CU077$conc == "4"] <- "2.63"
CU077$conc[CU077$conc == "3"] <- "1.75"
CU077$conc[CU077$conc == "2"] <- "0.87"
CU077$conc[CU077$conc == "1"] <- "0"

CU077$conc <- factor(CU077$conc, levels=c("0", "0.87",
                                          "1.75",
                                          "2.63",
                                          "3.51",
                                          "4.38",
                                         "5.26",
                                          "6.14",
                                          "7.02",
                                          "7.9"))
CU077$conc = as.character(CU077$conc) # zinc concentrations are the same as the numbers!
CU_OLY077<-ggplot(CU077) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Copper")+
  ylab(" ") +
  ylim(0,0.3)

MN077 = codes[which(codes$metal == "MN"), ] # 20210510 good 1	2	3	4	5	6	7'
MN077$conc[MN077$conc == "10"] <- "3.5"
MN077$conc[MN077$conc == "9"] <- "3.11"
MN077$conc[MN077$conc == "8"] <- "2.72"
MN077$conc[MN077$conc == "7"] <- "2.33"
MN077$conc[MN077$conc == "6"] <- "1.94"
MN077$conc[MN077$conc == "5"] <- "1.56"
MN077$conc[MN077$conc == "4"] <- "1.16"
MN077$conc[MN077$conc == "3"] <- "0.78"
MN077$conc[MN077$conc == "2"] <- "0.38"
MN077$conc[MN077$conc == "1"] <- "0"

MN077$conc <- factor(MN077$conc, levels=c("0", "0.38",
                                          "0.78",
                                          "1.16",
                                          "1.56",
                                          "1.94",
                                          "2.33",
                                          "2.72",
                                          "3.11",
                                          "3.5"))

MN077$conc = as.character(MN077$conc) # 
MN_OLY077<-ggplot(MN077) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Manganese")+
  ylab(" ") +
  ylim(0,0.3)

NI077 = codes[which(codes$metal == "NI"), ] # 20210510 good 1	2	3	4	5	6	7
NI077$conc[NI077$conc == "10"] <- "2.2"
NI077$conc[NI077$conc == "9"] <- "1.95"
NI077$conc[NI077$conc == "8"] <- "1.71"
NI077$conc[NI077$conc == "7"] <- "1.46"
NI077$conc[NI077$conc == "6"] <- "1.22"
NI077$conc[NI077$conc == "5"] <- "0.97"
NI077$conc[NI077$conc == "4"] <- "0.73"
NI077$conc[NI077$conc == "3"] <- "0.48"
NI077$conc[NI077$conc == "2"] <- "0.24"
NI077$conc[NI077$conc == "1"] <- "0"

NI077$conc <- factor(NI077$conc, levels=c("0", "0.24",
                                          "0.48",
                                          "0.73",
                                          "0.97",
                                          "1.22",
                                          "1.46",
                                          "1.71",
                                          "1.95",
                                          "2.2"))



NI077$conc = as.character(NI077$conc) # 
NI_OLY077<-ggplot(NI077) + 
  geom_point(aes(conc, maxSlope), size = 4, shape=1) + # plots points can add inside aes color = as.factor(pH)), 
  theme_bw()+
  theme(axis.text=element_text(size=10))+
  theme(axis.title.x = element_text( size = 16))+
  theme(axis.title.y = element_text(size = 16))+
  xlab("Nickel")+
  ylab(" ") +
  ylim(0,0.3)


plot_grid(CD_OLY077, CO_OLY077, CU_OLY077, MN_OLY077, NI_OLY077, ZN_OLY077,CD_OLY008, CO_OLY008, CU_OLY008, MN_OLY008, NI_OLY008, ZN_OLY008,   ncol = 3, labels = c("A", "B", "C", "D", "E", "F", "G", "H", "I","J", "K", "L"))
# save supplementary figure
ggsave("figures/SuppFig_Shapetolerance.pdf", height=8, width=16, device="pdf")




