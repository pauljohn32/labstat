## ------------------------------------------------------------------------
getwd()

## ----eval = FALSE--------------------------------------------------------
## # See ?setwd or lab 1 if you need help with this function
## setwd("Labs")

## ------------------------------------------------------------------------
dat1 <- read.table("student-1.txt", header=TRUE)

## ------------------------------------------------------------------------
dim(dat1) # what is the dimension of the data set?
names(dat1) # What are the column names in the data set?

## ------------------------------------------------------------------------
library(foreign)
dat2 <- read.dta("student-2.dta")
dim(dat2)
names(dat2)

## ------------------------------------------------------------------------
# library(foreign)
dat3 <- read.spss("bank.sav", to.data.frame = TRUE)
dim(dat3)
names(dat3)

## ------------------------------------------------------------------------
x <- numeric(1000)
x[1:10]

## ----eval = FALSE--------------------------------------------------------
##  x[1] <- mean(rnorm(453, mean=95, sd=23))
##  x[2] <- mean(rnorm(453, mean=95, sd=23))
##  x[3] <- mean(rnorm(453, mean=95, sd=23))
##  x[4] <- mean(rnorm(453, mean=95, sd=23))
## # .....................
##  x[1000] <- mean(rnorm(453, mean=95, sd=23))

## ------------------------------------------------------------------------
x <- numeric(1000)
for (i in 1:1000){
  x[i] <- mean(rnorm(453, mean=95, sd=23)) # mu is 95 and sigma is 23
}

## ----fig.align='center'--------------------------------------------------
hist(x, prob=TRUE)

## ------------------------------------------------------------------------
# Create a function to return a single mean
getNormalMean <- function(mu){
    e <- rnorm(453, mean = mu, sd = 23)
    mean(e)
}

# Get one mean value with a mean = 95
getNormalMean(95)
# Use sapply() to obtain a vector of means at once
myMu <- rep(95, 1000)  ## create 1000 mus
myMeans1 <- sapply(myMu, getNormalMean) # First argument is "mu" from myMu.

## ----fig.align='center'--------------------------------------------------
hist(myMeans1, prob=TRUE)

## ------------------------------------------------------------------------
# Modify the function vary N
getNormalMean <- function(mu, N){
    e <- rnorm(N, mean = mu, sd = 23)
    mean(e)
}

myMu <- rep(95, 1000)
# Then specify sigma and N in the sapply() function
myMeans2 <- sapply(myMu, getNormalMean, N = 1500) # what if N=1500?

## ----fig.align='center'--------------------------------------------------
hist(myMeans2, xlim=c(60,160))

## ------------------------------------------------------------------------
# Change function to randomize data for a Poisson distribution
getPoissonMean <- function(lambda, N){
    e <- rpois(N, lambda)
    mean(e)
}

myLambda <- rep(0.7, 1000) ## create 1000 lambdas
myMeans3 <- sapply(myLambda, getPoissonMean, N = 1500) # what if N=1500?

## ----fig.align='center'--------------------------------------------------
hist(myMeans3, prob = TRUE)
lines(density(myMeans3))

## ------------------------------------------------------------------------
drawHist <- function(data){
  hist(data, prob=T)
  lines(density(data), col="red", lty=2, lwd=2)
  cr <- range(data)
  ind <- seq(cr[1], cr[2], length.out=100)
  cm1 <- round(mean(data), 3)
  cs1 <- round(sd(data), 3)
  nprob <- dnorm(ind, m=cm1, s=cs1)
  lines(ind, nprob, lty=1, col="black")
  nlab <- bquote(paste("Normal(", .(round(cm1,3)),",", .(round(cs1,3))^2,")"))
  legend("topleft",legend=c("Kernel Density", as.expression(nlab)), lty=c(2,1),
  	col=c("red","black"), lwd=c(1.5,1))
  legend("left", legend=c(paste("Obs. Mean=", cm1),paste("Obs. sd=",cs1)))
}

## ----fig.align='center'--------------------------------------------------
drawHist(myMeans3)

## ------------------------------------------------------------------------
drawHist <- function(data){
  hist(data, prob=T)
  lines(density(data), col="red", lty=2, lwd=2)
  cr <- range(data)
  ind <- seq(cr[1], cr[2], length.out=100)
  cm1 <- round(mean(data), 3)
  cs1 <- round(sd(data), 3)
  nprob <- dnorm(ind, m=cm1, s=cs1)
  lines(ind, nprob, lty=1, col="black")
  nlab <- bquote(paste("Normal(", .(round(cm1,3)),",", .(round(cs1,3))^2,")"))
  legend("topleft",legend=c("Kernel Density", as.expression(nlab)), lty=c(2,1),
    col=c("red","black"), lwd=c(1.5,1))
  legend("left", legend=c(paste("Obs. Mean=", cm1),paste("Obs. sd=",cs1)))
}

## ------------------------------------------------------------------------
# Change function to randomize data for a Poisson distribution
getPoissonMean <- function(lambda, N){
    e <- rpois(N, lambda)
    mean(e)
}

myLambda <- rep(0.7, 1000) ## create 1000 lambdas
myMeans3 <- sapply(myLambda, getPoissonMean, N = 1500) # what if N=1500?

## ------------------------------------------------------------------------

getGammaMean <- function(shape, N){
    e <- rgamma(N, shape)
    mean(e)
}

myGamma <- rep(1, 1000) 
myMeans4 <- sapply(myGamma, getGammaMean, N = 1000)

## ----fig.align='center'--------------------------------------------------
hist(myMeans4, prob = TRUE)
lines(density(myMeans4))

