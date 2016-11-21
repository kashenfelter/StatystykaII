Dzisiaj będziemy pracować z trzema różnymi regułami predykcyjnymi będącymi obecnie 'state of the art'.

Czyli: 

- lasy losowe (odmiana baggingu), implementacja w `randomForest{randomForest}`
- xgboost (odmiana boostingu), implementacja w `xgboost{xgboost}`
- regularyzacja modeli addytywnych (LASSO glm), implementacja w `cv.glmnet{glmnet}`

Będziemy pracować na danych o nowotworze piersi.

```
load(url("https://github.com/pbiecek/StatystykaII/raw/master/MIMUW_2016/materialy/brca.rda"))
```

Dla każdej reguły przedstawimy regiony decyzyjne, sprawdzimy istotność zmiennych i przedstawimy ROC.

## Uczenie

1. Dla każdej z trzech wymienionych funkcji zbuduj regułę decyzyjną w oparciu o zmienne `age` i `ALKBH1`.

Przedstaw graficznie obszary decyzyjne.

Dla funkcji `xgboost` porównaj wyniki dla różnych wartości parametru `nrounds`.

## Krzywa ROC

Użyj funkcji `createDataPartition{caret}` aby podzielić dane na zbiór training/test (proporcje 75/25).

Zbuduj klasyfikator na obserwacjach ze zbioru uczącego. Wyznacz predykcje na zmiennych ze zbioru testowego.
Krzywe ROC będą wyznaczane dla zbioru testowego.

* Użyj pakietu `plotROC` i funkcji `calculate_roc`/`ggroc`/`plot_journal_roc` aby narysować krzywe ROC.

* Użyj pakietu `ROCR` i funkcji `prediction`/`performance`/`plot` aby narysować krzywe ROC ("tpr" vs "fpr"). Porównaj wszystkie trzy klasyfikatory na jednym wykresie (argument `add=TRUE`).

* Narysuj krzywą LIFT dla wszystkich klasyfikatorów ("lift" vs "rpp")

## Optimal cut points

Użyj funkcji `optimal.cutpoints{OptimalCutpoints}` aby wyznaczyć optymalny punkt podziału. 

Zmaksymalizuj współczynnik J Youdena. Użyj funkcji `summary/plot`.

## Zgodność

* Wyznacz zgodność predykcji i prawdziwych etykiet za pomocą funkcji `kappa2{irr}` i `fisher.test`.

## Ważność zmiennych

Każdy z klasyfikatorów wyznacza ranking ważności zmiennych.

Dla lasów losowych spróbuj `importance` i `varImpPlot`. 

Dla XGB użyj `xgb.plot.importance`.



# W razie potrzeby...



```{r}
library("xgboost")
library("randomForest")

rf <- randomForest(outcome~ALKBH1+age, data=brca)
gb <- xgboost(label=brca$outcome == "death in 3 years", data=as.matrix(brca[,c("ALKBH1","age")]), 
              objective = "binary:logistic", 
              nrounds = 2,
              max.deph = 2)

grid <- expand.grid(ALKBH1=seq(100,900, length.out=100),
                    age=seq(20,90, length.out=100))

pred_rf <- predict(rf, grid, type="prob")[,1]
pred_gb <- 1-predict(gb, as.matrix(grid))


grid$posterior_rf <- pred_rf
grid$posterior_gb <- pred_gb

ggplot(grid, aes(age, ALKBH1, color=posterior_rf)) + 
  geom_point(size=1)

ggplot(grid, aes(age, ALKBH1, color=posterior_gb)) + 
  geom_point(size=1) 


library(caret)
inds <- createDataPartition(brca$outcome, p = 0.75)

brca_train <- brca[inds[[1]],]
brca_test  <- brca[-inds[[1]],]

rf <- randomForest(outcome~., data=brca_train[,-(2:4)])
gb <- xgboost(label=brca_train$outcome == "death in 3 years", data=as.matrix(brca_train[,-(1:4)]), 
              objective = "binary:logistic", 
              nrounds = 10,
              max.deph = 3)


library(plotROC)
pred_rf <- predict(rf, brca_test, type="prob")[,2]
pred_gb <- 1 - predict(gb, as.matrix(brca_test[,-(1:4)]))

roc.estimate <- calculate_roc(pred_rf, brca_test$outcome)

rocdata <- data.frame(scores = pred_rf, 
                      labels = brca_test$outcome)

ggplot(rocdata, aes(m = scores, d = labels)) + stat_roc()


library(ROCR)

pred <- prediction( pred_rf, brca_test$outcome)
perf <- performance(pred,"tpr","fpr")
plot(perf,col="blue")
abline(0,1)

pred <- prediction( 1-pred_gb, brca_test$outcome)
perf <- performance(pred,"tpr","fpr")
plot(perf, add=TRUE, col="red")

perf <- performance(pred,"lift","rpp")
plot(perf, col="red")


## Cohen kappa - agreement
library(irr)
(tab <- table(pred_gb > 0.85, brca_test$outcome))

kappa2(cbind(pred_gb > 0.85, brca_test$outcome))

fisher.test(tab)
chisq.test(tab)


## Optimal cutpoints

library(OptimalCutpoints)
pref_df <- data.frame(pred_gb, brca_test$outcome)
oc <- optimal.cutpoints(X = "pred_gb", status = "brca_test.outcome", methods="Youden", data=pref_df, tag.healthy = "death in 3 years")

summary(oc)

plot(oc)

# variable importance

rf <- randomForest(outcome~., data=brca)
gb <- xgboost(label=brca$outcome == "death in 3 years", data=as.matrix(brca[,-(1:4)]), 
              objective = "binary:logistic", 
              nrounds=10,
              max.deph = 3)

importance(rf)
varImpPlot(rf)

importance_matrix <- xgb.importance(colnames(brca)[-(1:4)], model = gb)
xgb.plot.importance(importance_matrix)


```

