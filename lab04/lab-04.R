########################################################
### Psyc 650/790 and Pols 706                        ###
### Lab 4: Simple regression                         ###
########################################################

########################################################
## Let's take a look at the salary_subset.txt data.
## Variable names:
## depart: Department (1=psychology, 2=sociology, 3=history)
## pub: Number of publications
## Salary: Annual salary ($)
## gender: 1=Female, 0=Male
########################################################

# Make sure you're in the right directory (getwd(), setwd())

lab4 <- read.table("Lab-2014/lab4/salary_subset.txt", header=TRUE)

# New summary function
library(rockchalk)
summarize(lab4)

###### 4.1 Simple regression with a continuous predictor ######
## Using lm() function to fit linear regression model
## Question 1: Can number of publication (pub) 
## predict professors' salaries (salary)?
lm(salary ~ pub, data= lab4) # salary is the DV, pub is an IV

## Remember, the variable before the tilde (~) is the
## dependent variable, or the variable being predicted.
## The variable after the tilde (~) is the independent
## variable, or the predictor variable.
## You can also put an equation on the right of ~
## We'll get to that later.

## The lm() function does not provide us
## with a lot of information, so let's store our regression 
## model as an object (mod1) so we can do more with it.
mod1 <- lm(salary ~ pub, data= lab4) 

###### (1) Using the summary() function with a regression model
## gives us summary stats about parameter estimates, standard errors,
## significance tests for the parameter estimates, the residuals 
## (the deviations of the data from the regression line), 
## and model fit information.
summary(mod1)

###### (2) The anova() function provides various sum of squares, and 
## significance test (F test) for the R-squared. It is most useful
## when comparing multiple models, to see which one is best. We'll
## cover this topic in further detail after we cover multiple regression.
anova(mod1)

###### (3) We can also generate a covariance matrix between the estimated
## intercept and slope parameters by using the vcov() function.
vcov(mod1)
cov(lab4$salary, lab4$pub)


###### (4) Since our estimates have some amount of error to them, it is
## often useful to think of our parameters as covering a range
## of possibilities, rather than staying at a single point.
## Confidence intervals [confint()] reflect this range.
confint(mod1)
## The default for R is to use a 95% confidence interval. 
## To change the default, use the 'level=' option.
confint(mod1,level=0.99) # Get a more stringent CI (99%).


###### (5) Residuals are the difference between the predicted values for the
## dependent variable, and the actual, observed values for the dependent
## variable. To see the predicted (or "fitted") values for the dependent
## variable, use the predict() or fitted() function.
predict(mod1) 
## or
fitted(mod1)

## To get the residuals from a model, use the resid() function.
resid(mod1)


###### (6) Scatterplot and best fit line
## Take a look at the correlation between salary and pub
cor(lab4$salary, lab4$pub) 
## Make a scatterplot of salary (Y axis) and pub (X axis).
plot(salary ~ pub, data= lab4) 

## Adding a regression fitted line to the scatterplot
abline(mod1) 
## or 
abline(47940.4, 1148.2)  # abline(intercept, slope)


###### (7) Adding confidence intervals of the predicted values(confidence band of the fitted line). 
 
## Option 1
termplot(mod1, se=TRUE, partial.resid=TRUE) 
## Intercept is partialed out from predicted values.

## Option 2
range(lab4$pub)
regData <- data.frame("pub" = seq(1, 40)) 
regData.pred <- predict(mod1, newdata = regData, interval = "conf")
regData <- cbind(regData, regData.pred)
## Get points plotted
plot(salary ~ pub, data= lab4)
## Add 3 lines
lines(fit ~ pub, data=regData)                    #plot the predicted values
lines(lwr ~ pub, data=regData, lty=3, col="red")  #plot the lower boundary
lines(upr ~ pub, data=regData, lty=4, col="red")  #plot the upper boundary
legend("topleft", legend=c("predicted", "conf-lower", "conf-upper"),
       lty=c(1,3,4), col=c("black","red","red"))


## Option 3
range(lab4$pub)
regData <- data.frame("pub" = seq(1, 40)) 
regData.pred <- predict(mod1, newdata = regData, interval = "conf") 
matplot(x = regData, y = regData.pred , type = "l")
points(salary ~ pub, data= lab4, col = gray(.7))



###### 4.2 Simple regression with a dichotomous categorical predictor (0 and 1) ######
## Question 2: Can gender (gender) 
## predict professors' salary (salary)?
head(lab4) # gender has two levels, 0 and 1
lab4$gender <- factor(lab4$gender)
levels(lab4$gender)
lab4$gender <- factor(lab4$gender, label=c("male", "female"))
summary(lab4)

###### (1) Regression model and extractor functions
mod2 <- lm(salary ~ gender, data= lab4) 
contrasts(lab4$gender)
summary(mod2)
## The intercept now becomes the predicted salary for males (0=Male).
## The slope is the difference in predicted salary between males and females.

## All of these functions apply to this model.
anova(mod2)
vcov(mod2)
confint(mod2)
predict(mod2) 
fitted(mod2)
resid(mod2)

###### (2) Plotting the regression
## Option 1: Wrong ways
## The following ways are wrong.
## Because the regression model (mod2) treats the two groups as 0 and 1,
## but plot() and plot.default() functions treat the two groups as 1 and 2. 
plot(salary ~ gender, data = lab4)
abline(mod2)

plot.default(lab4$salary ~ lab4$gender)
abline(mod2)

plot.default(lab4$salary ~ lab4$gender, xlim = c(0.5, 2.5))
abline(mod2)

## Option 2
termplot(mod2, se = T, partial.resid =T)
## Nice, but "Partial for gender" is an odd label

## Option 3, imitate termplot(), but no distracting "partial for" label
# Choose which plot you like:
# Points
plot.default(lab4$salary ~ lab4$gender, xlim = c(0.5, 2.5))
# Or Boxes
plot(salary ~ gender, data = lab4)

# After drawing your plot save the predicted and boundary values
regData <- data.frame("gender" = levels(lab4$gender))
regData.pred <- predict(mod2, newdata = regData, interval = "conf")
regData <- cbind(regData, regData.pred)

# draw the predicted value for each level (male and female)
lines( x=c(0.75, 1.25), y = c(regData$fit[1], regData$fit[1]), col="green", lwd=2)
lines( x=c(1.75, 2.25), y = c(regData$fit[2], regData$fit[2]), col="green", lwd=2)

# draw the upper bounds
lines( x=c(0.85, 1.15), y = c(regData$upr[1], regData$upr[1]), col="red", lwd=2)
lines( x=c(1.85, 2.15), y = c(regData$upr[2], regData$upr[2]), col="red", lwd=2)

# draw the lower bounds
lines( x=c(0.85, 1.15), y = c(regData$lwr[1], regData$lwr[1]), col="red", lwd=2)
lines( x=c(1.85, 2.15), y = c(regData$lwr[2], regData$lwr[2]), col="red", lwd=2)



###### 4.3 An exercise ######
## Use the data set ?Prestige? in the ?car? package
# install.packages("car")
library(car)  # load the car package
data(Prestige) # load the data into work space
?Prestige
head(Prestige)
# Run a regression of income (y) on education (X) 
# and also run the following functions:
# summary()
# anova()
# vcov()
# confint()
# plot()
# abline()