Celem dzisiejszych zajęć jest poznanie techniki Analizy głównych składowych (ang. Principal Component Analysis, http://pbiecek.github.io/Przewodnik/Analiza/beznadzoru/mds_pca.html).

Będziemy pracować na ocenach filmów z bazy danych Hollywood Insider.
Wykorzystamy te dane aby odnaleźć jakąś interesującą strukturę w ocenach.

1. Wczytaj dane `archivist::aread("pbiecek/Przewodnik/arepo/10aab376f2bc0001cbd1db1802e9fb53")`. Co jest w środku? Wyświetl kilka pierwszych wierszy
2. Wyznacz statystyki opisowe dla wybranych zmiennych. Jaki film był najlepiej oceniany w bazie Rotten.Tomatoes? A jaki najgorzej? Który miał największy budżet?
3. Czy są zależności pomiędzy budżetem filmu a przychodem ze sprzedaży biletów?
4. Do dalszych analiz wybierz tylko filmy z roku 2015 i kolumny 4:8.
5. Użyj funkcji 'prcomp()' aby wyznaczyć składowe główne.
6. Przedstaw tekstowe podsumowanie wyniku. Ile zmienności wyjaśniają pierwsze dwie składowe?
7. Stwórz biplot. Użyj funkcji biplot() lub autoplot() z pakietu ggfortify.
8. Co o strukturze ocen filmów mówi ww. biplot?

## W razie potrzeby....

```

library(ggplot2)
library(dplyr)
filmy <- archivist::aread("pbiecek/Przewodnik/arepo/10aab376f2bc0001cbd1db1802e9fb53")
filmy %>% filter(year == 2015) %>% select(`Rotten.Tomatoes.%`:`Metacritic.Audience.%`) -> filmy4
pca <- prcomp(filmy4)

library(ggfortify)
autoplot(pca, shape = FALSE, label.size = 2, loadings = TRUE, loadings.label = TRUE, loadings.label.size = 5) + theme_bw()

```
