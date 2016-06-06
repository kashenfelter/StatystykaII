library(dplyr)
library(tidyr)
library(ggplot2)
library('raster')
library('sp')
library('rgdal')
library('rgeos')
library(scales)
library(ggmap)
library(dplyr)
library(Cairo)
library(maptools)
library("sqldf")

setwd("C:/Users/mm332321/Downloads/v1/v1")
BRCA <- read.table("dane_BRCA.csv", header = TRUE, sep = ";", dec = ",")

BRCA <- BRCA %>% 
  
  group_by(ICD10, GENDER, AGE_GROUP, TERYT4, region, subregion, year) %>%
  
  summarise(Stage1 = sum(Stage1), 
            
            Stage2 = sum(Stage2), 
            
            Stage3 = sum(Stage3), 
            
            Stage4 = sum(Stage4),
            new = sum(new))
# MAN #
{
temp <- read.table("ludnosc_mezczyzni_2010.csv", header=TRUE, sep=";", dec=",")
temp <- temp[temp$Kod/1000 == floor(temp$Kod/1000),]
temp <- temp[,-18] # usuwa 70 i wiÄ‚â€žĂ˘â€žËcej
people_man <- temp[,1:2]
people_man$total <- temp$ogolem
people_man$'<0-44>' <- (temp$X0.4 + temp$X5.9 + temp$X10.14 +
                          temp$X15.19 + temp$X20.24 + temp$X25.29 + 
                          temp$X30.34 + temp$X35.39 + temp$X40.44)
people_man$'<45-54>' <- (temp$X45.49 + temp$X50.54)
people_man$'<55-64>' <- (temp$X55.59 + temp$X60.64)
people_man$'<65-74>' <- (temp$X65.69 + temp$X70.74)
people_man$'<75-84>' <- (temp$X75.79 + temp$X80.84)
people_man$'<85+>' <- (temp$X85.i.wiecej)

colnames(people_man)[1:2] <- c("TERYT4","name")
people_man$TERYT4 <- people_man$TERYT4/1000
people_man$PLEC <- "M"
data_long <- gather(people_man, "grupa_wiek", "ludnosc", 3:7)
people_man <- data_long
  }
# WOMAN #
{ 
temp <- read.table("ludnosc_kobiety_2010.csv", header=TRUE, sep=";", dec=",")
temp <- temp[temp$Kod/1000 == floor(temp$Kod/1000),]
temp <- temp[,-18] # usuwa 70 i wiÄ‚â€žĂ˘â€žËcej
people_woman <- temp[,1:2]
people_woman$total <- temp$ogolem
people_woman$'<0-44>' <- (temp$X0.4 + temp$X5.9 + temp$X10.14 + 
                            temp$X15.19 + temp$X20.24 + temp$X25.29 +
                            temp$X30.34 + temp$X35.39 + temp$X40.44)
people_woman$'<45-54>' <- (temp$X45.49 + temp$X50.54)
people_woman$'<55-64>' <- (temp$X55.59 + temp$X60.64)
people_woman$'<65-74>' <- (temp$X65.69 + temp$X70.74)
people_woman$'<75-84>' <- (temp$X75.79 + temp$X80.84)
people_woman$'<85+>' <- (temp$X85.i.wiecej)    

colnames(people_woman)[1:2] <- c("TERYT4","name")
people_woman$TERYT4 <- people_woman$TERYT4/1000
people_woman$PLEC <- "K"
data_long <- gather(people_woman, "grupa_wiek", "ludnosc", 3:7)
people_woman <- data_long
} 
{
people <- rbind(people_man, people_woman)
myall <- BRCA
allJoined <- sqldf("select * from myall join people on myall.AGE_GROUP = people.grupa_wiek and myall.GENDER = people.PLEC and myall.TERYT4 = people.TERYT4")

allJoined$freq = allJoined$new / allJoined$ludnosc * 1000

allJoined$age1 <- ifelse(allJoined$grupa_wiek == "<0-44>",1,0)
allJoined$age2 <- ifelse(allJoined$grupa_wiek == "<45-54>",1,0)
allJoined$age3 <- ifelse(allJoined$grupa_wiek == "<55-64>",1,0)
allJoined$age4 <- ifelse(allJoined$grupa_wiek == "<65-74>",1,0)
allJoined$age5 <- ifelse(allJoined$grupa_wiek == "<75-84>",1,0)
allJoined$age6 <- ifelse(allJoined$grupa_wiek == "85+",1,0)
allJoined$plec01 <- ifelse(allJoined$PLEC == "M",1,0)

allJoined$woj2 <- ifelse(allJoined$region == 2,1,0)
allJoined$woj4 <- ifelse(allJoined$region == 4,1,0)
allJoined$woj6 <- ifelse(allJoined$region == 6,1,0)
allJoined$woj8 <- ifelse(allJoined$region == 8,1,0)
allJoined$woj10 <- ifelse(allJoined$region == 10,1,0)
allJoined$woj12 <- ifelse(allJoined$region == 12,1,0)
allJoined$woj14 <- ifelse(allJoined$region == 14,1,0)
allJoined$woj16 <- ifelse(allJoined$region == 16,1,0)
allJoined$woj18 <- ifelse(allJoined$region == 18,1,0)
allJoined$woj20 <- ifelse(allJoined$region == 20,1,0)
allJoined$woj22 <- ifelse(allJoined$region == 22,1,0)
allJoined$woj24 <- ifelse(allJoined$region == 24,1,0)
allJoined$woj26 <- ifelse(allJoined$region == 26,1,0)
allJoined$woj28 <- ifelse(allJoined$region == 28,1,0)
allJoined$woj30 <- ifelse(allJoined$region == 30,1,0)
allJoined$woj32 <- ifelse(allJoined$region == 32,1,0)

allFiltered <- allJoined[,c(4:7,12,17:41)]
load("centroidy_powiatow.Rdata")
with_centroids <- sqldf("select * from centroidy_powiatow join allFiltered on centroidy_powiatow.jpt_kod_je = allFiltered.TERYT4")
with_centroids <- with_centroids[,-1]
with_centroids$x <- (with_centroids$x - mean(with_centroids$x))/sd(with_centroids$x)
with_centroids$y <- (with_centroids$y - mean(with_centroids$y))/sd(with_centroids$y)
}
{
salary <- read.table("wynagrodzenia_2010.csv", header=TRUE, sep=";", dec=",")
salary <- salary[salary$Kod/1000 == floor(salary$Kod/1000),]
colnames(salary)[1:2] <- c("TERYT4", "name")
salary$TERYT4 <- salary$TERYT4/1000
colnames(salary)[3] <- "wynagrodzenie"
}

{
beds <- read.table("liczba_lozek_ogolem.csv", header=TRUE, sep=";", dec=",")
beds <- beds[beds$Kod/1000 == floor(beds$Kod/1000),]
colnames(beds) <- c("TERYT4", "name", "beds")
beds$TERYT4 <- beds$TERYT4/1000
}

with_centroids <- sqldf("select * from with_centroids join salary on with_centroids.TERYT4 = salary.TERYT4")
with_centroids <- with_centroids[,-33]
with_centroids <- with_centroids[,-33]
with_centroids <- sqldf("select * from with_centroids join beds on with_centroids.TERYT4 = beds.TERYT4")
with_centroids <- with_centroids[,-34]
with_centroids <- with_centroids[,-34]
with_centroids$wynagrodzenie <- (with_centroids$wynagrodzenie - mean(with_centroids$wynagrodzenie))/sd(with_centroids$wynagrodzenie)
with_centroids$beds <- (with_centroids$beds - mean(with_centroids$beds))/sd(with_centroids$beds)

with_centroids$ludnosc <- (with_centroids$ludnosc - mean(with_centroids$ludnosc))/sd(with_centroids$ludnosc)

BRCA2010 <- with_centroids[with_centroids$year==2010,]
BRCA2011 <- with_centroids[with_centroids$year==2011,]

BRCA2010 <- BRCA2010[,c(1:2,7:8, 10:16,33,34)] 
BRCA2011 <- BRCA2011[,c(1:2,7:8, 10:16,33,34)] 

library(caret)
library(party)
fit1 <- train(new ~ ., data=BRCA2010, method="lm")
pf1 <- predict(fit1, BRCA2011)
summary(fit1)
sum((BRCA2011$new - pf1)^2)/2037

tempTrain <- BRCA2010[]
tempTest <- BRCA2011[]
fitControl <- trainControl(method = "none")
for(k in c(1,3,6,10,15)){
  #tempTrain$ludnosc <- BRCA2010$ludnosc * par
  #tempTest$ludnosc <- BRCA2011$ludnosc * par
  fit2 <- train(new~., data=tempTrain, method="knn", trControl=fitControl, tuneGrid = data.frame(k=k))
  pf2 <- predict(fit2, tempTest)
  print(sum((BRCA2011$new - pf2)^2)/2037)
}

