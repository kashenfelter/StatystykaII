res <- read.table("~/GitHub/StatystykaII/MIMUW_2016/materialy/euro2016", sep="\t")

res5 <- read.csv("~/GitHub/StatystykaII/MIMUW_2016/materialy/euro2016_odds.csv", sep=",")

res2 <- read.table("~/GitHub/StatystykaII/MIMUW_2016/materialy/fifa_points", sep="\t")
rownames(res2) <- substr(res2$V2, 4, 100)
res2$V3 <- gsub(res2$V3, pattern="\\(.+", replacement="")
res2$V3 <- as.numeric(res2$V3)

res[,1] <- gsub(
  gsub(as.character(res[,1]), 
       pattern="^ +", replacement=""), 
  pattern=" +$", replacement="")
res[,3] <- gsub(
  gsub(as.character(res[,3]), 
       pattern="^ +", replacement=""), 
  pattern=" +$", replacement="")
res$V4 <- substr(res$V2, 1, 1)
res$V5 <- substr(res$V2, 3, 3)


newRes <- as.data.frame(rbind(as.matrix(res[,c(1, 3, 4)]), 
                              as.matrix(res[,c(3, 1, 5)])))

newRes$delta <- res2[as.character(newRes$V1), "V3"] - res2[as.character(newRes$V3), "V3"]
newRes$V4 <- as.numeric(as.character(newRes$V4))

ee<- predict(glm(V4~delta, data=newRes, family="poisson"),
        data.frame(delta=seq(-700,700,10)), type="response")

plot(newRes$delta, newRes$V4, pch=19, col=(newRes$V1=="Poland")+1)
lines(seq(-700,700,10), ee, col="red")

df <- data.frame(x=seq(-700,700,10), 
           y=ee)

842 - 894


newRes$resi <-glm(V4~delta, data=newRes, family="poisson")$fitted.values - newRes$V4
  
  
  glm(V4~delta, data=newRes, family="poisson")$residuals

library(ggplot2)
library(ggrepel)
ggplot(newRes, aes(delta, V4, color=factor((V1=="Poland") + (V3=="Poland")))) +
  geom_line(data=df, aes(x,y),color="grey", size=2)+
  geom_point(size=3) + theme_classic() + 
  geom_text_repel(data=newRes[abs(newRes$resi)>1.4,], aes(label=paste(V1, V3, sep="-"))) + 
  xlab("Różnica w liczbie punktów FIFA") + ylab("Liczba strzelonych goli")+
  theme(legend.position="none") + scale_color_manual(values=c("black","red"))





team <- unique(gsub(
  gsub(
    c(as.character(res[,1]), as.character(res[,3])), 
                 pattern="^ +", replacement=""), 
            pattern=" +$", replacement=""))


intersect(substr(res2$V2, 4, 100), team)
