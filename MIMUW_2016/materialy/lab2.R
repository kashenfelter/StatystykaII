# Lab 2 - Statistics 2

## Simulations

1. Generate two independent samples from gaussian distribution (100 observations each)
check: rnorm

2. Compute Pearson correlation between these two vectors
check: cor

3. Replicate this setting 10000 times and collect correlations from different runs
check: replicate

4. Present distribution of cor coefficients
check: hist

5. Find critical regions for this test
check: quantile

6. Generate two samples that are correlated, calculate cor coefficients

7. Calculate power for this setting: fraction of samples that fall in the critical region

8. Calculate power as a function of real correlation. How the power behaves? Is it along our expectations?

9. Calculate power as a function of sample size

10. Try non gaussian distributions (log-gaussian, cauchy)  

## Verification (star)

There is an interesting debate about misunderstanding of p-values.
Let’s take a stand.

1.	generate 10000 of p-values for true null hypothesis (rho=0)
2.	generate 10000 of p-values for false null hypothesis (rho=0.01)

What is the probability that H0 if false given p-value are significant?

P(H0 – false | p-val < 0.05)

How this value behave as a function of p-value (from interval 0.0001 – 0.1)
And as a function of sample size?
How it will look like for other rho?

## Exploration

- Find out if there is any relation in auta2012 dataset between Color and Brand.

Which test, which method should be used?

- Find out if there is any relation between Price and Mileage.

How to plot it? How to verify it?


