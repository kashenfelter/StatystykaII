Celem dzisiejszych zajęć jest przedstawienie błędu predykcji jako sumy dwóch składowych - kwadratu obciążenia i wariancji.

Będziemy pracować z czterema regułami predykcyjnymi:

- regresja liniowa
- regularyzacja modeli addytywnych (LASSO lm), implementacja w `cv.glmnet{glmnet}`
- metoda k-sąsiadów (np. knn.reg {FNN})
- jedna dowolnie wybrana inna metoda (SVM, randomForest, NN)

Dla każdej metody oszacujemy obciążenie i wariancje dla ustalonego x0.

Następnie porównamy te metody pod kątem obciążenia i wariancji.

## Studium symulacyjne

1. Ustalmy liczbę cech p=10 i obserwacji n=200 dla symulacyjnego zbioru danych. 

2. Określmy liniową zależność pomiędzy cechami a zmienną zależną y. Np. y = x1 + 0.9*x2 + 0.8 x3 + ... + eps, gdzie eps z rozkładu normlanego N(0,1).

3. Określmy interesujący nas punkt w którym będziemy badali obciążenie i wariancje. 
x_0 = runif(p)

4. Wylosuj zbiór danych o n wierszach i p kolumnach. Wyznacz kolumnę y zgodnie z zależnością opisaną w punkcie 2.

5. Na zadanym zbiorze danych zbuduj regułę predykcyjną wykorzystując zadane metody (regresja liniowa, lasso, knn, svm).

6. Wykorzystaj metody zbudowane w punkcie 5. do wykonania predykcji wartości y dla punktu x_0.

7. Dla każdej z reguł predykcyjnych wyznacz błąd oceny `r_0 = y_0 - \hat f(x_0)`, gdzie `y_0` to średnia wartość zmiennej y w punkcie x_0 wyznaczona ze wzoru 2.

8. Powtórz kroki 4-7 N razy (N=1000). Wyznacz średni błąd predykcji w x_0, wariancje predykcji w x_0 oraz MSE w x_0.

9. Na wykresie narysuj zależność pomiędzy obciążeniem a wariancją predykcji w x_0.



## W razie potrzeby...



```{r}
n = 20
p = 10
N = 1000

beta <- seq(1,0,0.1)

x0 <- as.data.frame(matrix(runif(p), nrow = 1, ncol = p))
truth2 <- as.matrix(x0) %*% t(t(beta))

bias2 <- replicate(N, {
  df <- as.data.frame(matrix(runif(n*p), nrow = n, ncol = p))
  truth <- as.matrix(df) %*% t(t(beta))
  df$y <- truth + rnorm(n)
  e1 <- (predict(lm(y~., data=df), newdata = x0) - truth2)[1]
  e2 <- (predict(cv.glmnet(as.matrix(df[,1:p]), df$y), newx = as.matrix(x0[,1:p])) - truth2)[1]
  c(e1, e2)
})

rowMeans(bias2)
var(t(bias2))
rowMeans(bias2^2)

```

