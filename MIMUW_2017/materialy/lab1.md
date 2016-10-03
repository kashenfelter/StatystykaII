# Porównaj moc testów Chi2 i testu Fishera

1.1. Użyj funkcji rbinom() aby wygenerować dwa niezależne wektory po 100 obserwacji z rozkładu B(0.4,1)
1.2. Zbuduj macierz kontyngencji 2x2 opisującą zależność pomiędzy tymi wektorami
1.3. Wywołaj test Fishera (fisher.test) i chi2 (chisq.test) dla tej macierzy, porównaj p-wartości
1.4. Powtórz kroki 1.1-1.3 10000 razy. Porównaj rozkłady p-wartości, czy wyniki są zgodne z oczekiwaniami?
1.5. Wygeneruj zmienne zależne. Możesz to zrobić zgodnie ze schametem, z prawdopodobieństem b(=0.8) drugi wektor ma taką samą wartość jak pierwszy, z prawdopodobieństem 1-b(=0.2) drugi wektor jest generowany niezależnie
1.6. Wywołaj test Fishera (fisher.test) i chi2 (chisq.test) dla tej macierzy, porównaj p-wartości
1.7. Powtórz 1.5-1.6 10000 razy, porównaj rozkłądy p-wartość. Który test ma wyższą moc?

# Wykonaj analizę korespondencji dla danych auta2012

2.1. Wczytaj zbiór danch aua2012 z pakietu PogromcyDanych.
2.2 Wybierz cztery marki, dwie kojarzące się z szybkimi samochodami i dwie raczej rodzinne.
2.3 Wybierz auta koloru białego, czarnego, żółtego i czerwonego.
2.4 Sprawdź testem chi2 czy jest zależnosć pomiędzy tymi zmiennymi.
2.5 Użyj funkcji ca() z pakietu ca() aby graficznie przedstawić zależność pomiędzy kolorem auta a marką.

