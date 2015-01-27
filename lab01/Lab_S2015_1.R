## ------------------------------------------------------------------------
# Comment to describe code
# What summary provides depends on what is in the parentheses
# cars is a built in data set so you get summary statistics
summary(cars)

## ------------------------------------------------------------------------
3 + 2  # Addition
3 - 1  # Subtraction
7 * 8  # Multiplication
9 / 3  # Division

## ------------------------------------------------------------------------
3 ^ 2  # Power
sqrt(36) # Square root
log(7) # Natural logarithm ln

## ------------------------------------------------------------------------
exp(10) # e^10

## ------------------------------------------------------------------------
1 + 3 * log(10) - (exp(7) - 3) / 4

## ------------------------------------------------------------------------
x <- 1
x   # The value can be printed by typing the object name
x <- 2 + 5  # The result is saved in the object 'x'
x

## ------------------------------------------------------------------------
z <- "Hello!"  # We may save an object as text.
z

## ------------------------------------------------------------------------
X <- 5
X + x
X <- log(2) # This will overwrite the previous value.
X + x

## ----eval = FALSE--------------------------------------------------------
## ## When R was installed, HTML format help files were copied
## ## onto your hard drive. To access these files, just type
## help.start()
## ## To request an R document for a specific function, use '?'.
## ?log
## ## To request help by keywords, use '??'.
## ??logarithm

## ------------------------------------------------------------------------
midterm <- c(99, 87, 96, 100, 82, 79, 88, 85, 94, 90)
midterm
f <- 1:20
f
g <- seq(from = 1, to = 20) # seq(start value, end value, interval)
h <- seq(1, 20, by = 0.2) # specify interval

## ------------------------------------------------------------------------
k <- rep(1, 5)  # rep(value, number of times)
k
l <- rep(1:10, 5)  # rep() can accept numbers, text, or NA
l

## ------------------------------------------------------------------------
datn <- rnorm(n = 1000, mean = 24, sd = 3)
# Look at datn to see what R generated

datp <- rpois(1000, 3)     # 1000 random numbers 
## from a poisson disribution
## with an expected value of 3. 

## ------------------------------------------------------------------------
midterm <- c(99, 87, 96, 100, 82, 79, 88, 85, 94, 90)
mean(midterm) 

## ------------------------------------------------------------------------
midterm2 <- c(99, NA, 96, 100, 82, NA, 88, 85, 94, 90)
mean(midterm2)

## ------------------------------------------------------------------------
mean(midterm2, na.rm = TRUE)

## ------------------------------------------------------------------------
c(1, 2, 3, 4) - 4
c(1, 2, 3, 4)/4
c(1, 2, 3, 4)/c(4, 3, 2, 1)   # 1/4, 2/3, 3/2, 4/1

## ------------------------------------------------------------------------
log(c(1, 2, 3, 4))  # applies log to each element
## Can you tell what this is?
sum((midterm - mean(midterm))^2)/(length(midterm) - 1)

## ------------------------------------------------------------------------
midterm
midterm[2]
midterm[length(midterm)] # What is happening here?

## ------------------------------------------------------------------------
midterm[1:4] # take more than one element at a time.
midterm[c(1:4, 8, 10)]

## ----eval = FALSE--------------------------------------------------------
## midterm[1, 2, 3, 4, 8, 10]  # This is NOT THE SAME
## ## R could only evaluate this if midterm was an array with
## ## 6 dimensions.

## ------------------------------------------------------------------------
mydata <- rnorm(1000, 0, 1) 

?hist

## ------------------------------------------------------------------------
hist(mydata)

## ------------------------------------------------------------------------
hist(mydata, prob = TRUE) 

## ------------------------------------------------------------------------
hist(mydata, prob=TRUE, xlab="X-Variable Name", 
     ylab="Proportion of Cases") # Label x and y axes

## ------------------------------------------------------------------------
hist(mydata, prob=TRUE, xlab="X-Variable Name", 
     ylab="Proportion of Cases", main="My First Histogram", breaks=50) 

## ------------------------------------------------------------------------
hist(mydata, prob=TRUE, xlab="X-Variable Name", 
     ylab="Proportion of Cases", breaks=50) 
lines(density(mydata))

## ------------------------------------------------------------------------
getwd()

## ----eval = FALSE--------------------------------------------------------
## setwd("Labs")
## setwd("D:\\Users\\l076s857\\Desktop") # For Windows
## setwd("D:/Users/l076s857/Desktop") # For Windows, Mac, Linux

## ------------------------------------------------------------------------
ls()

## ------------------------------------------------------------------------
rm(x)
rm(list = ls(all = TRUE))

## ------------------------------------------------------------------------
mydata <- rnorm(1000, 0, 1) 
h1 <- hist(mydata, prob=TRUE, xlab="X-Variable", ylab="Density", 
           main="My First Histogram", breaks=10) 

## ------------------------------------------------------------------------
h1

## ------------------------------------------------------------------------
attributes(h1) 
names(h1)
h1$mids   # The $ allows you to access a specific attribute of the object

## ----eval = FALSE--------------------------------------------------------
## install.packages("rockchalk", dep = TRUE)

## ------------------------------------------------------------------------
library(rockchalk)

## ------------------------------------------------------------------------
mydata <- rnorm(1000, 0, 1) 
summarize(mydata)

