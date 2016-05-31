# Lab 4 - Statistics 2

# Basics
Generate two clusters and use kmeans/pam algorithms to find them.

1. Use the `rmvnorm{mvtnorm}` to draw
- 120 observations from two-dimensional normal distribution *N(c(3,0), diag(1,2))*.
-  80 observations from two-dimensional normal distribution *N(c(0,3), diag(1,2))*.
Then use the `rbind` function to combine these two groups together into a single matrix with 200 rows 2 columns.
Plot this dataset with the `ggplot2` package.

If you wish to learn more about methods for generating data from multidimensional normal distribution, read https://pbiecek.gitbooks.io/przewodnik/content/Programowanie/generatory_3.html.


2. Use `kmeans{stats}` and `pam{cluster}` functions to identify 2 clusters in the dataset generated in the step 1.


# Simulations

It's time to do some experiments with the number of clusters

1. Generate larger number (e.g. 5) of clusters of roughly the same size (e.g. 60, 80, 100, 120, 140). 

Visually check what will happen if you fit 3, 5 or 7 clusters. 
Run k-means algorithm few times and check if these results are stable or not?

2. Use the silhouette function to calculate the average silhouette / generate silhouette plots.

3. Compare the average silhouette for different number of clusters.


# Real data [this will be fun]

Let’s apply pam to real non trivial dataset.

Read data about votings from Polish Sejm 

votings <- archivist::aread("pbiecek/Przewodnik/arepo/9175ec8b23098c4364495afde9a2cc17")

If needed you can fill missing data with some value, e.g. "Not present"

votings[is.na(votings)] <- "Not present"

Use `daisy()` function or some other method to calculate the distance matrix between deputies.
Find some good (what is good?) number of clusters for these deputies and check what is the relation between deputies clubs and clusters created based on their votes.







Use ONLY if in REAL need.

```{r}
library(mvtnorm)
s1 <- rmvnorm(120, c(3,0), diag(1, 2))
s2 <- rmvnorm(80, c(0,3), diag(1, 2))
ss <- as.data.frame(rbind(s1, s2))

library(ggplot2)
ggplot(ss, aes(V1, V2)) +
geom_point()

g1 <- kmeans(ss, 2)
library(cluster)
g2 <- pam(ss, 2)

ss$g1 <- g1$cluster
ss$g2 <- g2$clustering

ggplot(ss, aes(V1, V2, color=g1)) +
geom_point()
ggplot(ss, aes(V1, V2, color=g2)) +
geom_point()
```

