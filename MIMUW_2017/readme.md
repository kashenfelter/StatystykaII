Statystyka II
----------------

Schedule MIM UW:
----------------

* 5 X, W+L: Statystyki opisowe - zmienne jakościowe, test chi2, analiza korespondencji, [lab1](materialy/lab1.md)
* 12 X [eRum @ Poznań] L: Eksploracja danych + ggplot2
* 19 X, W+L: Statystyki opisowe - zmienne ilościowe, testowanie zbioru hipotez, [lab2](materialy/lab2.md)
* 26 X, [Presentations@lab], [Project 1 phase 1] W: Analiza grup - metody kombinatoryczne
* 02 XI, W+L: Analiza grup - metody aglomeracyjne
* 09 XI, [Presentations@lab], [Project 1 phase 2] W: Reguły decyzyjne
* 16 XI, W+L: Skalowanie wielowymiarowe
* 23 XI, [Presentations@lectures], [Project 1 phase 3] L: Reguły decyzyjne
* 30 XI, W+L: Podstawy predykcji, prosta regresja, kNN, drzewa
* 07 XII, W+L: Metody wyboru modelu, regresja z wieloma zmiennymi
* 14 XII, [Presentations@lab], [Project 2 phase 1] W: Regularyzacja
* 21 XII, W+L: Klasyfikacja - podstawy, LDA, QDA, regresja logistyczna
* 11 I, [Presentations@lab], [Project 2 phase 2] W: Ewaluacja modelu, CV, repeated k-fold CV, itp
* 18 I, W+L: Bagging, boosting, random forest
* 25 I, [Presentations@lectures], [Project 2 phase 3] 

Zaliczenie
----------

Zaliczenie będzie oparte o wyniki dwóch projektów, jednego dotyczącego eksploracji i jednego dotyczącego predykcji.
Do zaliczenia wymagana będzie połowa punktów. Maksymalną ocenę, którą można uzyskać z samych projektów jest 4.
Opcjonalnie można podejść też do egzaminu pisemnego, który może podnieść ocenę o 0 0.5, lub 1 stopień.

Projekt dotyczący eksploracji będzie związany z segmentacją danych z PISA 2015, te dane dostępne będą po 6 grudnia.

Projekt związany z predykcją, temat tego projektu będzie wkrótce podany.

Lektura
-------

* [The Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)
* [Przewodnik](http://pbiecek.github.io/Przewodnik/Analiza/analizadanych_z_programem_r_md.html)

Konsultacje
----------

Na konsultacje można umawiać się w środy lub czwartki. Proszę o mailowe potwierdzenie terminu spotkania aby mieć pewność, że w tym czasie nie będzie kilku chętnych.


Projekt 1
---------

Pierwszy projekt dotyczy predykcji.

Celem projektu jest zbudowanie reguły / algorytmu, który na podstawie danych o pacjentach ze zdiagnozowanym nowotworem Glioblastoma będzie mogła możliwie dokładnie oszacować czy pacjent przeżyje 1 rok od diagnozy.

Poniżej przedstawiam fragment zbioru danych. 

Kolejne kolumny opisują: 

- sampleID - unikalny identyfikator pacjenta.
- Cluster - informacja o podtypie nowotworu.
- age - wiek w momencie diagnozy.
- death1y - informacja czy pacjent przeżył 1 rok od diagnozy.
- pozostałe kolumny (16k) to nazwy różnych genów.

```
> GlioblastomaWide[1:5,1:10]
         sampleID Cluster age death1y X..100133144 X..100134869 X..10357 X..10431 X..155060 X..390284
1 TCGA.02.0047.01 C10-GBM  78   alive    -1.686874       -0.573   -0.986   -0.028     0.534    -2.432
2 TCGA.02.0055.01 C10-GBM  62    dead           NA        0.642   -1.788   -0.029     0.010    -0.758
3 TCGA.02.2483.01 C10-GBM  43   alive    -1.747874        0.471   -0.845    0.450    -0.252    -1.974
4 TCGA.02.2485.01 C10-GBM  53   alive     0.693126        0.573   -0.239   -0.943     1.376    -2.800
5 TCGA.02.2486.01 C10-GBM  64   alive    -0.831874       -1.065   -0.793   -0.726     0.780    -2.444
```
Kroki kolejnych etapów:

Etap 1. 
Wybierz zbiór genów lub innych cech, które mają różną ekspresję u pacjentów, kórzy przeżyli i tych co nie przeżyli 1 roku.
(*) Zbadaj stabilność tego wyboru, w zależności od tego czy dane zostały podzielone na podzbiór uczący i testowy.

Etap 2.
Zbuduj klasyfikator oparty o istotne geny lub inne cechy dostępne w danych (wiek, klaster). 
Zweryfikuj jakość klasyfikatora krzywą ROC, tabelą kontyngencji, metodą k-fold CV.

Etap 3.
Zbuduj klasyfikator oparty o model stacking przewidujący prawdopodobny stan pacjenta po roku.

W trzecim etapie oceniane będą kryteria:

- poprawność rozwiązania (czy wykonano cross walidacje, czy zrobiono to poprawnie, czy wyniki uzyskano na odpowiedniej licznie powtórzeń),
- jakość klasyfikacji, im wyższa końcowa skuteczność tym lepiej,
- tuning algorytmu, przyjęte strategie tuningu, parametry i algorytmy rozważane w wyborze najlepszego algorytmu
- interpretacja i walidacja otrzymanych wyników.

