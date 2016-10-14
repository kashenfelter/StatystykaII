Celem tych ćwiczeń jest zapoznanie się z narzędziami do korekty p-wartości z uwagi na liczbę testowanych hipotez.

# Sprawdź jak zmienia się częstość błędów w zależności od liczby testowanych hipotez.

W poniższych zadaniach będziemy testować hipotezę, że średnia z próby wynosi 10.
Wykorzystamy prosty test t-studenta dla średniej dla jednej próby.

1.1. Wylosuj 10 obserwacji z rozkładu N(10,1). Możesz użyć do tego funkcji rnorm()
1.2. Wykorzystaj test t-Studenta (t.test()) aby wyznaczyć p-wartość dla hipotezy H0: mu = 10
1.3. Powtórz kroki 1.1 - 1.2 N razy (N=10000) i oszacuj błąd pierwszego rodzaju dla alpha=0.05. Powinieneś otrzymać błąd praktycznie na poziomie poziomu istotności

Zwiększamy liczbę hipotez.

2.1 Zamiast jednej próby, wylosuj M=10 prób, każda po 10 obserwacji z rozkładu N(10,1)
2.2 Dla każdej próby niezależnie wyznać p-wartość dla testu t-Studenta. 
2.3 Powtórz kroki 2.1 - 2.2 i policz jak często przynajmniej jedna z prawdziwych hipotez zerowych była odrzucona (błąd PWER = Pr(V>0))

Stosujemy korektę.

3.1 Podobnie jak w kroku 2.1, zamiast jednej próby, wylosuj M=10 prób, każda po 10 obserwacji z rozkładu N(10,1)
3.2 Dla każdej próby niezależnie wyznać p-wartość dla testu t-Studenta. 
3.3 Użyj funkcji p.adjust by skorygować p-wartości otrzymane w kroku 3.2. Porównaj korektę 'fdr' i 'bonferroni'
3.4 Powtórz kroki 3.1 - 3.3 i policz jak często przynajmniej jedna z prawdziwych hipotez zerowych była odrzucona (błąd PWER = Pr(V>0))

Część hipotez jest fałszywych


4.1 Tym razem wylosuj M=5 prób po 10 obserwacji z rozkładu N(10,1) i dodatkowo N=5 prób z rozkładu N(8, 1)
4.2 Dla każdej próby niezależnie wyznać p-wartość dla testu t-Studenta. 
4.3 Użyj funkcji p.adjust by skorygować p-wartości otrzymane w kroku 3.2. Porównaj korektę 'fdr' i 'bonferroni'
4.4 Powtórz kroki 4.1 - 4.3 i policz jak często przynajmniej jedna z prawdziwych hipotez zerowych była odrzucona (błąd PWER = Pr(V>0)) oraz policz frakcję fałszywie odrzuconych hipotez FDR = E[V/R]

Porównaj wyniki z kroków 3.4 i 4.4

