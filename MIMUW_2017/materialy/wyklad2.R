alpha <- 0.05
m1 = 8
m2 = 12
rejected <- replicate(
  1000, {
    rnd1 <- replicate(m1, {
      rnorm(10, 10, 1)
    })
    rnd2 <- replicate(m2, {
      rnorm(10, 9, 1)
    })
    rnd <- cbind(rnd1, rnd2)
    pvs1 <- apply(rnd, 2, function(x) t.test(x, mu=10)$p.value)
    c(sum(p.adjust(pvs1, method="fdr")[1:m1] < alpha),
        sum(p.adjust(pvs1, method="fdr")[m1+(1:m2)] < alpha))
  }
)
head(m <- t(rejected))
Q = ifelse(m[,1] + m[,2] == 0,
           0,
           m[,1]/c(m[,1] + m[,2]))
summary(Q)
V = ifelse(m[,1] == 0,
           0,
           1)
summary(V)
