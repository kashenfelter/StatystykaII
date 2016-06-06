---
title: "Untitled"
output: html_document
---

```{r}
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

library(caret)
library(party)
```
```{r setup, include=FALSE}
setwd("C:/Users/Mateusz/Desktop/StatystykaII/MIMUW_2016/projekty/projekt2/macias_trojgo_rinowska_gorka/phase3")
load("full_data_unnormed.Rdata")

with_centroids$ludnosc2 <- (with_centroids$ludnosc - mean(with_centroids$ludnosc))/sd(with_centroids$ludnosc)
#wartosc kontrolna
{
  
BRCA <- read.table("dane_BRCA.csv", header = TRUE, sep = ";", dec = ",")

BRCA <- BRCA %>% 
  
  group_by(ICD10, GENDER, AGE_GROUP, TERYT4, region, subregion, year) %>%
  
  summarise(Stage1 = sum(Stage1), 
            
            Stage2 = sum(Stage2), 
            
            Stage3 = sum(Stage3), 
            
            Stage4 = sum(Stage4),
            new = sum(new))


BRCA2010 <- BRCA[BRCA$year == 2010,]

BRCA2011 <- BRCA[BRCA$year == 2011,]

BRCA2012 <- BRCA[BRCA$year == 2012,]

df <- sqldf("select BRCA2011.TERYT4, BRCA2011.GENDER, BRCA2011.AGE_GROUP, BRCA2011.new as res2011, BRCA2010.new as res2010 from BRCA2011 left join BRCA2010 on BRCA2011.TERYT4 = BRCA2010.TERYT4 and BRCA2010.GENDER = BRCA2011.GENDER and BRCA2010.AGE_GROUP = BRCA2011.AGE_GROUP")
having <- df[!is.na(df$res2010),]
mean((having$res2010 - having$res2011)^2)
}

# Drzewko przewiduje 2011 na bazie 2010
{
  BRCA2010 <- with_centroids[with_centroids$year==2010,]
  BRCA2011 <- with_centroids[with_centroids$year==2011,]
  BRCA2010 <- BRCA2010[,c(9, 10:33,34)] 
  #BRCA2011 <- BRCA2011[,c(1:2,9, 10:33,34)] 

  tempTrain <- BRCA2010[]
  tempTest <- BRCA2011[]
  fitControl <- trainControl(method = "none")
  for(mincrit in c(0.9,0.7,0.5,0.4, 0.35,0.3,0.25,0.2, 0.1, 0.05,0.01)){
    fit2 <- train(freq ~ ., data=tempTrain, method="ctree",tuneGrid = data.frame(mincriterion = mincrit),trControl = fitControl)
    pf3 <- predict(fit2, tempTest)
    print(mincrit)
    print(sum((BRCA2011$new - pf3*BRCA2011$ludnosc/1000)^2)/2037)
  }
  
}
# Drzewko przewiduje 2012 na bazie 2011
{
  BRCA2011 <- with_centroids[with_centroids$year==2011,]
  BRCA2012 <- with_centroids[with_centroids$year==2012,]
  BRCA2011 <- BRCA2011[,c(9, 10:33,34)] 
  #BRCA2011 <- BRCA2011[,c(1:2,9, 10:33,34)] 

  tempTrain <- BRCA2011[]
  tempTest <- BRCA2012[]
  fitControl <- trainControl(method = "none")
  for(mincrit in c(0.9,0.7,0.5,0.4, 0.35,0.3,0.25,0.2, 0.1, 0.05,0.01)){
    fit2 <- train(freq ~ ., data=tempTrain, method="ctree",tuneGrid = data.frame(mincriterion = mincrit),trControl = fitControl)
    pf3 <- predict(fit2, tempTest)
    print(mincrit)
    print(mean((BRCA2012$new - pf3*BRCA2012$ludnosc/1000)^2))
  }
  
}

# Drzewko przewiduje 2012 na bazie 2011
{
  BRCA2011 <- with_centroids[with_centroids$year==2011 | with_centroids$year==2010,]
  BRCA2012 <- with_centroids[with_centroids$year==2012,]
  BRCA2011 <- BRCA2011[,c(9, 10:33,34)] 
  #BRCA2011 <- BRCA2011[,c(1:2,9, 10:33,34)] 

  tempTrain <- BRCA2011[]
  tempTest <- BRCA2012[]
  fitControl <- trainControl(method = "none")
  for(mincrit in c(0.9,0.7,0.5,0.4, 0.35,0.3,0.25,0.2, 0.1, 0.05,0.01)){
    fit2 <- train(freq ~ ., data=tempTrain, method="ctree",tuneGrid = data.frame(mincriterion = mincrit),trControl = fitControl)
    pf3 <- predict(fit2, tempTest)
    print(mincrit)
    print(mean((BRCA2012$new - pf3*BRCA2012$ludnosc/1000)^2))
  }
  
}

{
  df <- sqldf("select BRCA2011.TERYT4, BRCA2011.GENDER, BRCA2011.AGE_GROUP, BRCA2011.new as target, BRCA2010.Stage1, BRCA2010.Stage2, BRCA2010.Stage3, BRCA2010.Stage4, BRCA2010.new as res2010 from BRCA2011 left join BRCA2010 on BRCA2011.TERYT4 = BRCA2010.TERYT4 and BRCA2010.GENDER = BRCA2011.GENDER and BRCA2010.AGE_GROUP = BRCA2011.AGE_GROUP")
  df2 <- sqldf("select BRCA2012.TERYT4, BRCA2012.GENDER, BRCA2012.AGE_GROUP, BRCA2012.new as target, BRCA2011.Stage1, BRCA2011.Stage2, BRCA2011.Stage3, BRCA2011.Stage4, BRCA2011.new as res2010 from BRCA2012 left join BRCA2011 on BRCA2012.TERYT4 = BRCA2011.TERYT4 and BRCA2011.GENDER = BRCA2012.GENDER and BRCA2011.AGE_GROUP = BRCA2012.AGE_GROUP")

    having <- df[!is.na(df$res2010),]
 fit1 <- train(target ~ res2010, data = having, method = "lm")
 having2 <- df2[!is.na(df2$res2010),] 
 res <- predict(fit1,having2)
  mean((having2$target - res)^2)
}
```