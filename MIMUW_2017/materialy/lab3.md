Pobierz zbiór danych o winach https://archive.ics.uci.edu/ml/datasets/Wine+Quality

Wina opisane są przez 12 zmiennych dotyczących właściwości 
fizykochemicznych.

Na podstawie tych parametrów chcemy przewidzieć jakość, która jest wyrażona liczbą całkowitą w skali od 3 do 9.

Poniżej rozważymy dwa warianty tej metody. Jeden w którym jakość potraktujemy jako zmienną binarną i jeden,
w którym potraktujemy ją jako zmienną ciągłą.

# Wczytaj dane do R

1. 1. Użyj funkcji read.table aby wczytać dane z interentu

```
url <- 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv'
wine <- read.table(url, sep=";", header=TRUE)
head(wine)
```

1.2. Stwórz binarną zmienną opisującą czy wino jest słabe (ocena niższa lub równa 5) lub czy jest dobre (ocena 6 lub więcej). Możesz użyć do tego funkcji `cut`.

1.3 Wybierz zmienne `volatile.acidity`, `alcohol` i `pH` i statystykami opisowym określ ich związek z oceną wina.

# Zbuduj drzewo decyzyjne opisujące kolumnę z jakością wina

2.1. Użyj funkcji `ctree` z pakietu `party` (podział na bazie testów permutacyjnych). Zastosuj ją do objaśnienia zmiennej ciągłej `quality`.

2.2. Użyj funkcji `ctree` z pakietu `party` (podział na bazie testów permutacyjnych). Zastosuj ją do objaśnienia zmiennej binarnej `qualityb`.

2.3. Funkcją `plot` możesz wyświetlić wynikowe drzewo.

2.4 Użyj argumentu `controls` aby wybrać tylko zmienne, różnicujące każdy węzeł na poziomie 10^10.

2.5. Porównaj wyniki z funkcją `rpart` z pakietu `rpart` (podział na bazie miary informacyjnej).

Więcej o funkcji ctree: https://cran.r-project.org/web/packages/partykit/vignettes/ctree.pdf

# Zbuduj model regresji lub regresji logistycznej  opisujące kolumnę z jakością wina

3.1 Funkcja `glm()` buduje model regresji logistycznej. Zastosuj ją do danych o jakości wina i porównaj jej wyniki z wynikami drzew decyzyjnych dla zmiennej `qualityb`.

3.2 Funkcja `lm()` buduje model regresji prostej. Zastosuj ją do danych o jakości wina i porównaj jej wyniki z wynikami drzew decyzyjnych dla zmiennej `quality`.

Czy te dwa modele mają podobne struktury?











# W razie potrzeby

```
wine$qualityb <- cut(wine$quality, c(0,5.5, 10), labels=c("slabe", "dobre"))
table(wine$quality)
table(wine$qualityb)

library("partykit")
drzewo <- ctree(quality~., data=wine[,-13])
plot(drzewo)

drzewo <- ctree(quality~., data=wine[,-13], controls = ctree_control( mincriterion = 0.999999999))
plot(drzewo)

drzewo <- ctree(qualityb~., data=wine[,-12], controls = ctree_control( mincriterion = 0.999999999))
plot(drzewo)

summary(lm(quality~., data=wine[,-13]))
summary(glm(qualityb~., data=wine[,-12], family="binomial"))
```
