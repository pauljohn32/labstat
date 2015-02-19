---
title: "Lab 5: Multiple Regression"
author: "P. Johnson, B. Rogers, L. Shaw"
date: "Wednesday, February 25, 2015"
output:   
  slidy_presentation:
    fig_width: 6
    fig_height: 5
---



## Let's take a look at the publicspending.txt data.
Variable names:
- EX: Per capita state and local public expenditures ($)	
- ECAB: Economic ability index, in which income, retail sales,  and the value of output (manufactures, mineral, and agricultural) per capita are equally weighted.	
- MET: Percentage of population living in standard metropolitan areas	
- GROW: Percent change in population, 1950-1960
- YOUNG: Percent of population aged 5-19 years	
- OLD: Percent of population over 65 years of age	
- WEST: Western state (1) or not (0) 

## Get Data, put in same directory as this file

###### 5.1 Data diagnostics ######
lab5 <- read.table("publicspending.txt", header = TRUE)

## First, we want to check the names of all of our variables
head(lab5)
## Then we can get descriptive stats for all of our variables
summary(lab5)
## We can also get a covariance matrix and correlation matrix
	#of all of the variables in our dataset.
cov(lab5)
cor(lab5)
## Finally, we can plot the bivariate relationships in our data
plot(lab5)
## To actually see the graphs, we may want to reduce the number of plots
	#by only looking at a subset of the items 
plot(lab5[ , 1:3])


###### 5.2 Multiple regression ######

###### 5.2.1 Multiple regression model
mod1 <-lm(EX ~ ECAB + MET + GROW, data = lab5)
summary(mod1)

## Let's look at a summary object.
## Name the summary(mod1) as m1sum and take a look at what are inside.
m1sum <- summary(mod1)
names(m1sum)
m1sum$coef  # returns the t table. Same as m1sum$coefficients

m1sum$resid  # returns the residuals
m1sum$r.squared # returns the R^2

###### 5.2.2 Plot the regression
###### (1) termplot()
## The termplot() function can be used to plot the predicted Y against
## its Xs. When having multiple predictors, termplot() will 
## generate one plot for each predictor. 
## We can use the par(mfrow=..) function to combine multiple simple plots
## as panels in a single figure.
par(mfrow = c(2, 2))
termplot(mod1, se = TRUE, partial.resid = TRUE)
par(mfrow = c(1,1)) # change back to the original layout 

## Choose which predictor to plot
termplot(mod1,  se = TRUE, partial.resid = TRUE, terms= "ECAB")
#  You can save that to a file, like a pdf
dev.print(pdf, file = "mod1.ecab.pdf", onefile = FALSE, paper = "special")


### Spawning useful input values for predict
#   More useful than just creating a sequence of integers across range
#   predictOMatic() gives you the quartile values for a variable, paired with
#   the mean of the other variables
library(rockchalk)
predictOMatic(mod1)
summarize(lab5$GROW)  # Compare the values with predictOMatic output
predictOMatic(mod1, interval = "confidence")  # same, but wait, there's more!
predictOMatic(mod1, predVals = "auto", intervals = "confidence") # makes single set

## You can do sort of the same thing with newdata() and predict()
new1 <- newdata(mod1, predVals="auto", divider="quantile") # quantile is default
new1
predict(mod1, newdata = new1)
## And using standard deviations instead of quartiles...
(new1 <- newdata(mod1, predVals="auto", divider="std.dev."))
predict(mod1, newdata = new1)
## Get more values 
(new2 <- newdata(mod1, predVals = "margins", n = 10))



###### (2) rockchalk::plotPlane()
## The plotPlane() function in the rockchalk package creates a 3D plot of 
## the predicted Y against a plane formed by two Xs. 
library(rockchalk)
plotPlane(mod1, plotx1 = "ECAB", plotx2 = "MET")



###### 5.2.3 The fancy t-test
mod2 <-lm(EX ~ ECAB + MET + GROW + OLD + YOUNG, data= lab5)
## I'd like to test whether the coefficient of "GROW" (b3) is significantly
## different from the coefficient of "YOUNG" (b5).
m2sum <- summary(mod2)
## Remember the function from slide 48, 51 of the Multiple regression lecture?
m2sum$coef  # returns a matrix of the t table.
m2sum$coef[ ,1] # returns the first column of the t table, which contains the regression coefficients. 
# Note that b3 is the fourth element, and b5 is the sixth element in the vector.

# Give a name to the result of vcov(mod2). The result is a matrix. 
vc <- vcov(mod2) 

# Again, we use [,] to specify the elements in the matrix. 
# For example, vc[4,6] is the element in the forth row and the six column.

fancyt <- (m2sum$coef[4,1] - m2sum$coef[6,1])/sqrt(
                          vc[4,4]+vc[6,6]-2* vc[4,6])
fancyt 

#Finally, we can get a p-value for this "fancy t-test":
pt(fancyt, 42, lower.tail=FALSE)
# 42 is our degrees of freedom for the t-test, obtained from summary(mod2).
# Since "fancyt" is positive, we want the probability of scoring higher than it (lower.tail=FALSE);
# if it were negative, we would want the probability of scoring lower than it (lower.tail=TRUE).
# If the probability is less than 0.025 or greater than 0.975, 
# the estimates are significantly different (given alpha = 0.05).
# In this case, the effects of the two predictors are not significantly different from the other.


