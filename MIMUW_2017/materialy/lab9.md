Celem dzisiejszych zajęć jest poznanie techniki konstrukcji reguł decyzyjnych (https://pbiecek.gitbooks.io/przewodnik/content/Analiza/beznadzoru/rules.html).

Reguły decyzyjne

Będziemy pracować na danych o ocenach studentów z MIMUW. 
Wykorzystamy te dane aby odnaleźć jakąś interesującą strukturę w ocenach.

1. Wczytaj dane `archivist::aread("pbiecek/Przewodnik/arepo/12b75717051be0ae516b900e1e70c049")`. Co jest w środku? Wyświetl kilka pierwszych wierszy
2. Wyznacz statystyki opisowe dla wybranych kursów. Z jakich kursów oceny są najlepsze a z jakich najgorsze? 
3. Czy są zależności pomiędzy kursami (ktoś sobie dobrze radzi z jednego i drugiego)?
4. Wykorzystaj pakiet `tidyr` aby przekształcić dane do szerokiej postaci (użyj funkcji `spread()`). Kolumny powinny być przedmiotami a wiersze studentami.
5. Stwórz binarną macierz z wartością TRUE (student dostał 3 lub więcej) lub FALSE (ocena 2 lub brak realizacji kursu).
6. Przekształć tę macierz na dane typu `transactions`. Uzyj pakietu `arules` i funkcji `as()`.
7. Użyj algorytmu `apriori()` aby znaleźć reguły, które mają `support >0.1`.
8. Użyj funkcji `inspect()` i `sort()` aby wyświetlić reguły o najwyższej wartości `lift`.
9. Wykorzystaj pakiet `arulesViz` oraz funkcje `plot()` i `itemFrequencyPlot()` aby dowiedzieć się więcej o tych regułach.

W kolejnym kroku warto przyjrzeć się zbiorowi danych 379dde77e1b8446ecdb0e87fc6552909.



