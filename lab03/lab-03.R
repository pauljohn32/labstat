########################################################
### Psyc 650/790 and Pols 706                        ###
### Lab 3: Exercises on importing data and CLT      ###
########################################################

###### 3.1 Exercises on importing data ######
########################################################
### 1. Download text data (.txt) and stata data (.dta)
### Please go to this webpage 
### http://pj.freefaculty.org/stat/ps706/student-Ex1/
### and download any data you want for both formats.
###
### 2. Download SPSS data (.sav)
### Go to
### http://pj.freefaculty.org/guides/stat/Regression/BankSalaryExample-Loess_or_Moderator
### and download bank.sav.
########################################################

###### Exercise #0 Working directory ######
### Before we try to read in data, make sure the 
### working directory has been correctly defined.

### A good habit is to start an .R file from your
### the directory where you save your data so that
### R will know that which directory you are currently
### working in. No need to run setwd() any more.
### To check your working directory, type
getwd()

### In case you start R in a different way,
### run setwd("whatever the directory is")
### to manually set your working directory.

## Because I am using Windows, I have to switch "\" to "/"
setwd("C:/Fan-Class/2012-2013/2013_Spring_TA_Psyc790/Lab/lab3")

## If you are using Mac, 
setwd("/Fan-Class/2012-2013/2013_Spring_TA_Psyc790/Lab/lab3")


###### Exercise #1 Reading a text file ######
### We can use read.table to read in .txt data
### For example, 
dat1 <- read.table("student-1.txt", header=TRUE)


###### Exercise #2 Reading a stata data file ######
### There is no function for reading stata files in the R base package.
### We need to install the "foreign" package first,
### and use the read.dta() function.
install.packages("foreign")
library(foreign)
help(package="foreign")
dat2 <- read.dta("student-2.dta")


###### Exercise #3 Reading a SPSS data file ######
### For SPSS data files, we can use read.spss() function 
### in the "foreign" package.
# install.packages("foreign")
# library(foreign)
dat3 <- read.spss("bank.sav", to.data.frame = TRUE)


###### 3.2 A demonstration of the central limit theorem (CLT) ######
########################################################
### Recall that 
### 1. A statistic is a value derived from a random sample. 
### 2. The distribution of a statistic is called sampling distribution.
### 3. The sampling distribution of mean for large sample size is normal. 
########################################################

###### Exercise #4 Sampling distribution ######
# Create a numeric vector with 1000 elements, all equal 0. 
#----------------------------------------------- 
# x <- numeric(1000)
#-----------------------------------------------
 
# Draw one random sample with 453 random numbers from a normal distribution;
# Compute the mean, and save the value;
# Repeat it 1000 times.
#-----------------------------------------------
# x[1] <- mean(rnorm(453, mean=95, sd=23))
# x[2] <- mean(rnorm(453, mean=95, sd=23))
# x[3] <- mean(rnorm(453, mean=95, sd=23))
# x[4] <- mean(rnorm(453, mean=95, sd=23))
# .....................
# x[1000] <- mean(rnorm(453, mean=95, sd=23))
#-----------------------------------------------

# All the 1000 sample means form a sampling distribution.
#----------------------------------------------- 
# hist(x, prob=TRUE)
#-----------------------------------------------

# I don't really want to run the above steps because
# it requires 1000 lines of code to compute the sample means.
# But here is a more convenient way to do the same thing. 
x <- numeric(1000)
for (i in 1:1000){
	x[i] <- mean(rnorm(453, mean=95, sd=23)) # mu is 95 and sigma is 23
}
hist(x, prob=TRUE)

### The for() loop method is clear but slow when scaled up. 
### A more efficient way is to use sapply() function.
getNormalMean <- function(mu){
    e <- rnorm(453, mean = mu, sd = 23)
    mean(e)
}

# To get one mean
getNormalMean(95)

# To get 1000 means
myMu <- rep(95, 1000)  ## create 1000 mus
myMeans1 <- sapply(myMu, getNormalMean) # First argument is "mu" from myMu.
hist(myMeans1)



###### Exercise #5 CLT (1) ######
## Let's play around with the sample size N
getNormalMean <- function(mu, N){
    e <- rnorm(N, mean = mu, sd = 23)
    mean(e)
}

myMu <- rep(95, 1000) ## create 1000 mus
# Then specify sigma and N in the sapply() function
myMeans2 <- sapply(myMu, getNormalMean, N = 1500) # what if N=1500?
hist(myMeans2, xlim=c(60,160))



###### Exercise #6 CLT (2) ######
### How about other distributions?
getPoissonMean <- function(lambda, N){
    e <- rpois(N, lambda)
    mean(e)
}
myLambda <- rep(0.7, 1000) ## create 1000 lambdas
myMeans3 <- sapply(myLambda, getPoissonMean, N = 1500) # what if N=1500?
hist(myMeans3, prob = TRUE)
lines(density(myMeans3))

# Here is a function for making Kernal Density and normal line in the same figure
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
drawHist(myMeans3)



###### Exercise #7 CLT (3) ######
## Go to Prof. Johnson's webpage
## http://pj.freefaculty.org/guides/Rcourse/WorkingExamples/distributions-gamma-04.R
## See how CLT applies to a gamma distribution.
