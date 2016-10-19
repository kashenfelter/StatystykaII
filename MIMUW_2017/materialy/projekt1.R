library(RTCGA.PANCAN12)

data("expression.cb1")
data("expression.cb2")
expression <- rbind(expression.cb1,expression.cb2)
rownames(expression) <- expression[,1]
texpression <- t(expression[,-1])
texpression <- data.frame(texpression)
texpression[1:5,1:5]
texpression$sampleID <- rownames(texpression)

clinical.cb[1:5,1:15]

library(dplyr)

Glioblastoma <- filter(clinical.cb, X_cohort == "TCGA Glioblastoma")
Glioblastoma <- Glioblastoma[,c(1,2,7,16,20)]

table(Glioblastoma$X_TIME_TO_EVENT < 365, Glioblastoma$X_EVENT)

Glioblastoma <- filter(Glioblastoma, 
                       (X_TIME_TO_EVENT >=  365) |
                        (X_EVENT == 1))

Glioblastoma$death1y <- ifelse(Glioblastoma$X_TIME_TO_EVENT >=  365,
                               "alive","dead")
Glioblastoma$sampleID <- gsub(Glioblastoma$sampleID, pattern = "-", replacement = ".", fixed = T)

GlioblastomaWide <- merge(Glioblastoma, texpression, by = "sampleID")
GlioblastomaWide <- GlioblastomaWide[,c(-2,-4)]
