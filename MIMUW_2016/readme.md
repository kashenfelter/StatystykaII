Statistics II
-------------

Schedule MIM UW:
----------------

* 1-2 III,  Descriptive statistics - one variable, [Exploration](http://bit.ly/1RCz5EE) 
* 8-9 III,  Descriptive statistics - two variables, [Verification](https://pbiecek.gitbooks.io/przewodnik/content/Analiza/jak_badac_zaleznosci_pomiedzy_para_zmiennych.html), [Exploration](https://pbiecek.gitbooks.io/przewodnik/content/Analiza/jak_badac_rozklad_dwoch_zmiennych.html), [Lab](https://github.com/pbiecek/StatystykaII/blob/master/MIMUW_2016/materialy/lab2.R)
* 15-16 III [Exploration], Grammar of graphics [Theory](https://github.com/pbiecek/StatystykaII/blob/master/MIMUW_2016/materialy/grammarOfGraphics.pdf), [Tools: ggplot2](https://pbiecek.gitbooks.io/przewodnik/content/Wizualizacja/jak_tworzyc_wykresy_ggplot2.html), [Lab](https://github.com/pbiecek/StatystykaII/blob/master/MIMUW_2016/materialy/lab3.R) (there will be no classes - 16 III),
* 22-23 III Project presentation at CNK, [Project 1 phase 1], [Lab](https://github.com/pbiecek/StatystykaII/blob/master/MIMUW_2016/materialy/lab7.Rmd)
* 5-6 IV    [Exploration], Cluster analysis, [k-means](https://pbiecek.gitbooks.io/przewodnik/content/Analiza/beznadzoru/kmeans.html), [PAM](https://pbiecek.gitbooks.io/przewodnik/content/Analiza/beznadzoru/pam.html), [agnes](https://pbiecek.gitbooks.io/przewodnik/content/Analiza/beznadzoru/agnes.html),  [Lab](https://github.com/pbiecek/StatystykaII/blob/master/MIMUW_2016/materialy/lab4.R)
* 12-13 IV  [Exploration], [Multidimensional scaling](https://pbiecek.gitbooks.io/przewodnik/content/Analiza/beznadzoru/mds.html), [Project 1 phase 2],   [Lab](https://github.com/pbiecek/StatystykaII/blob/master/MIMUW_2016/materialy/lab5.Rmd)
* 19-20 IV  [Exploration], [Decision rules](https://pbiecek.gitbooks.io/przewodnik/content/Analiza/beznadzoru/rules.html), [Lab](https://github.com/pbiecek/StatystykaII/blob/master/MIMUW_2016/materialy/lab6.Rmd)
* 26-27 IV  [Prediction], [Regression, kNN, trees, model quality measures, pages 9-32 from EoSL](http://statweb.stanford.edu/~tibs/ElemStatLearn/), [Project 1 phase 3], [Lab](https://github.com/pbiecek/StatystykaII/blob/master/MIMUW_2016/materialy/lab7.Rmd)
* 10-11 V   [Prediction], [Regression with many variables, model selection, chapters 7.1-7.5, 7.7](http://statweb.stanford.edu/~tibs/ElemStatLearn/),
* 17-18 V   [Prediction], [Regularisation, feature extraction, chapter 3.4](http://statweb.stanford.edu/~tibs/ElemStatLearn/), [Project 2 phase 1]
* 24-25 V   [Prediction], Classification LDA, QDA, logistic regression
* 31-1 V    [Prediction], SVM [Project 2 phase 2]
* 7-8 VI    [Prediction], Bagging, boosting, random forest 
* 14-15 VI  [Verification], Multiple hypotheses testing, [Project 2 phase 3]

Projects:
---------

Both projects should be executed in teams. Each team should have 3 or 4 people. You should find different teams for the second projects. 

Projects should be presented during each phase. Projects that are not presented will not be scored.

### Project 1

Exploration and segmentation for data from CNK Science Center.

Phase 1: 
Create a single page overview (format A3) for selected stations (one, few or all, it's up to you).
The overview should present distribution of playing times with different machines. 
Consider identification of variables that may influence this variable (day of week, hour, month).
Bring the printed overview to the presentation. We will discuss different solutions and approaches.

Phase 2: 

For the second phase please choose one from following topics (during lectures we will talk about algorithms that can be used for analyses). 

 + A. Path analysis. What paths are typical, which exhibits are visited after which one, which exhibits are usually the last one, are there some frequent paths / sub-paths?
 + B. Segmentation of visitors. Are there groups / segment of visitors with similar behaviour? Such as playing similar amount of time with given exhibits (longer/shorten than usual), are there some groups of exhibits that are visited more often by some subgroups of visitors?
 + C. Deep analysis of a single selected exhibit. Exhibits are different so choose one and find group of visitors that have similar patterns of interactions with the selected exhibit. 
 




### Project 2 

We are going to work with extremely interesting dataset – number of cancer cases for different regions, genders, age groups. Find the data description [here](https://www.dropbox.com/s/pk27k65b6co2lu0/desc?dl=0), and the first dataset [here](https://www.dropbox.com/s/a46zo0ra6d4fi1w/dane_BRCA.csv?dl=0).

*The ultimate goal:*

Find and present the predictions for number of cancer cases in different regions of Poland.
Identify outliers. Compare results for knn and linear regression or two others approaches.


*The goal for the phase 1:*

Work only on Breast cancer cases. Perform exploratory analysis. Prepare a knitr presentation only with key result (you can move other results to appendix). The presentation should be shorter than 10 pages (if the presentation is in html, check the size by the ‘print’ option).

Things to consider in the phase 1:

-	Explore the distribution of cases in different regions.
-	Try to normalize cases by the size of the population (how to find it? Try GUS or other publicly available databases),
-	Plot the cartogram for these  cases. Here: https://github.com/pbiecek/teryt you can find shape files for counties, here http://www.kevjohnson.org/making-maps-in-r/ you will find instructions how to plot maps with ggplot2
-	Note that you can work with data the level of voivodeship or level of county – it’s up to you. 
-	Note that you can work with single gender or both genders – it’s up to you,
-	Note that you can work with all age groups combined or do analyses for them independently – up to you.


Grade:
------

Each project will be graded on a scale 0-60 points.
From projects you can get a pass (maximum grade 4).

Projects are performed in groups but different people would get different number of points, depending on their contribution.

For higher grade you need to pass a written exam.


Data sets:
----------

Will be used during classes.

```
deputies <- archivist::aread("pbiecek/Przewodnik/arepo/07088eb35cc2c9d2a2a856a36b3253ad")

votings <- archivist::aread("pbiecek/Przewodnik/arepo/9175ec8b23098c4364495afde9a2cc17")
```

Small Logs: http://bit.ly/1X7A2X0
