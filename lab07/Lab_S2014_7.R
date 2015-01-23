#########################################################
### Psyc 650/790 and Pols 706                         ###
### Lab 7: Model Diagnostics and Nonlinear Regression ###
#########################################################


# Check WorkingExamples in R Files
# regression-quadratic-1.R

###### 7.1 Model Diagnostics ######
###### 7.1.1 Residual plot

library(rockchalk)

## That requires "car" package, Companion To Applied Regression. If
## (somehow magically) you don't have that yet
install.packages("car")
library(car)

## The dataset, named "cars", contains 50 observations of
## the speed and stopping distance (in a controlled setting)
## of a random selection of cars during the 1920s.
data(cars)
summary(cars)

## Our question is how does speed relate to stopping distance.
## We hypothesize that speed should increase stopping distance.
## We'll run this simple regression model to test our question:
mod1 <- lm(dist ~ speed, data = cars)
summary(mod1)
## The results tend to support our hypothesis, but let's make sure
## that we've met all of our assumptions for regression.

## First, let's plot the values of our independent variable against the residuals:
## We'll include the residuals as a variable in our dataset, just
## for convenience.
cars$res <- resid(mod1)
plot(res ~ speed, data = cars, xlab = "Speed (mph)", 
     ylab = "Stopping Residuals",
     main = "Residuals for Stopping Distance")
     
## It's may not seem obvious, but the variance of the error 
## (aka the residuals) increases as speed increases. 



###### 7.1.2 plot(model)
## We can look at all the diagnostic plots that Dr. Johnson 
## brought up in lecture:
par(mfrow = c(2, 2)) # show 2 columns and 2 rows of plots
plot(mod1)
## This gives us: 
## Residuals vs. fitted values, 
## Q-Q plot, 
## Scale-Location plot, 
## and Residuals vs. Leverage
## Please refer to Dr. Johnson's lecture for more information about these plots.
par(mfrow = c(1, 1)) # switch back to 1 plot at a time

	
## We might want to think about another model.

## First, let's look at the scatter plot.
plot(dist ~ speed, data = cars,
     main = "Stopping Distance of Cars in the 1920s")




###### 7.1.3 Loess Line
## Since the simplest solution left something to be desired,
## let's check out the loess line.
## Loess stands for Locally Weighted Error Sum of Squares regression.
## Yi-hat = g(Xi) where g() is some complicated fitting function
## "Weighted" means that not all points contribute equally.
## We put more weight on the observations near each Xi when 
## calculating each Yi-hat.

## First, we get the necessary values for the loess line:
loessModel <- loess(dist ~ speed, data = cars, 
             span = 2/3, degree = 1, family = "symmetric")
## "span" controls the degree of smoothing
## "degree" specifies the degree of the polynomial to be used
   ## to estimate each regression (here, we just want them to be linear).
## "family" specifies whether we want OLS ("Gaussian") or 
## an iterative M-estimation ("symmetric")

## We need to get the predicted values for the loess regression:
loessValues <- data.frame(speed = seq(5, 25, 5)) # New X with same range as original X. 
					##From summary(cars$speed), we know speed ranges from 4 to 25.
loessValues$pred <- predict(loessModel, newdata = loessValues) # Compute new Y-hat based on the loess model.
## Finally, we put it all together on our plot.

lines(pred ~ speed, data = loessValues, lty = 2, lwd = 2, col = "red")

## Let's add the regression line to see how it compares to the 
## the loess line.
abline(mod1, col = "black", lwd = 1.5, lty = 1)
legend("topleft", legend = c("OLS","loess"), 
        col = c("black", "red"), lty = c(1,2), lwd = c(1.5,2))

## The loess line and the OLS line look similar,
## but the loess line definitely appears to have a curvilinear trend.
## This gives us evidence to investigate a nonlinear model.
## (You should still have a theoretical explanation if possible.)


## rockchalk function here:
ps1 <- plotSlopes(mod1, plotx = "speed", interval = "conf")
lines(pred ~ speed, data = loessValues, lty = 2, lwd = 2, col = "red")
ps1


###### 7.2 Polynomial Models ######
## Since our linear model did not capture the relations, let's try some
   ## nonlinear models.
## First up is the quadratic model, which includes a squared term.
## To include a squared term in the model itself, we have to use
   ## the "identity" protection function using the I() syntax.
mod2 <- lm(dist ~ speed + I(speed^2), data = cars) 
summary(mod2) 
## An identical alternative is to create a squared term outside of the model:
# cars$speed2 <- cars$speed^2
# mod2 <- lm(dist ~ speed + speed2, data=cars) 
# summary(mod2)

## Plot the quadratic line
plot(dist ~ speed, data = cars, main = "Quadratic Model")

sqrValues <- data.frame(speed = seq(5, 25, 5))  # New X
ply.pt <- predict(mod2, newdata = sqrValues) # New Y-hat
lines(sqrValues$speed, ply.pt, col = "blue", lwd = 2)

#### Interpretation of the coefficients in a quadratic model:
#### yhat = b0 + b1*x + b2*x^2
#### b0: the predicted y at x = 0.
#### b1(first order coefficient): the slope of the tangent line at x = 0.
#### b2 (second order coefficient) : the change rate in instantaneous slope across x. 
		### If there is an increase in slope over time, b2 is positive.
		### If there is an decrease in slope over time, then ?b2 is negative.
		
## NOTE! We always have to put in all of the lower-order coefficients,
   ## if we include higher-order coefficients. That means, if we have a quartic
   ## model, we have to include the original coefficient, the squared coefficient,
   ## and the cubic coefficient, in addition to the quartic coefficient.
   
## Look at the example "regression-quadratic" on Dr. Johnson's webpage.
## http://pj.freefaculty.org/R/WorkingExamples/regression-quadratic-1.R

## rockchalk warning:
ps2 <- plotCurves(mod2, plotx = "speed", interval = "conf")
lines(pred ~ speed, data = loessValues, lty = 2, lwd = 2, col = "red")
ps2

  
###### 7.3 Exponential Models ###### 
## We can also specify an exponential relationship between our 
## variables. To do that, we take the natural log of the variable 
## with the exponential term, or, we can do it for both.
cars$distlog <- log(cars$dist) 
cars$speedlog <- log(cars$speed) 
mod3 <- lm(distlog ~ speedlog, data = cars)
summary(mod3)
## A one unit increase in the natural log of speed is associated with a 1.60
   ## unit increase in the natural log of stopping distance.

## It is useful to plot this relationship to see the nonlinear relationship.
plot(dist ~ speed, data = cars, main = "Double-log Model") 

logValues <- data.frame(speed = seq(5, 25, 5)) # New Xs we want to predict
logValues$speedlog <- log(logValues$speed)    
logValues$predDbl <- predict(mod3, newdata = logValues) # Predicted Y values
lines(logValues$speed, exp(logValues$predDbl)) #Here, we back-transform the data and results.


plotCurves(mod3, plotx = "speedlog", interval = "conf")

plot(mod3)

mod3.2 <- lm(distlog ~ speedlog, data = cars[-1, ])
plot(mod3.2)

#### Interpretation of the coefficients in a double-log model:
#### yhat = b0*(x)^b1
#### ln(yhat) = ln(b0) + b1*ln(x)

#### b0: the predicted y at x = 1.
#### b1: for one unit increase in ln(x), there is a b1 unit change in ln(y).
	### Or,  the "elasticity", the percentage change in yhat due to a percentage change
	### in x (some calculus required to see that).

## If we just transform the dependent variable:
mod4 <- lm(distlog ~ speed, data = cars)
summary(mod4) 

## If we just transform the independent variable (log-on-right model): 
mod5 <- lm(dist ~ speedlog, data = cars)
summary(mod5)


## Remember, theory precedes modeling. Although we can use diagnostics and exploration
## to inform theory, they should never be used to replace theory.

## Look at the example "regression-doublelog" on Dr. Johnson's webpage.
## http://pj.freefaculty.org/R/WorkingExamples/regression-doublelog.R

ps5 <- rockchalk::plotCurves(mod5, plotx = "speedlog", interval = "conf")



plot(dist ~ speed, data = cars, xlab = "Speed (mph)", 
     ylab = "Stopping Distance",
     main = "")

ps5$newdata$speed <- exp(ps5$newdata$speedlog)

lines(fit ~ speed, data = ps5$newdata)
legend("topleft", legend = c("Predicted from log(speed)"), lty = 1, col =1)

## Add quadratic prediction from ps2

lines(fit ~ speed, data = ps2$newdata, col = "red", lty = 2)



## Digression. Decide between mod2 and mod5
summary(mod2)
summary(mod5)

## Smaller AIC is better, it leads to same conclusion
AIC(mod2)
AIC(mod5)

## Are you desperate for a star? Here:
m2mc <- meanCenter(mod2, terms = "speed")
summary(m2mc)


drop1(m2mc, test = "F")



## 
## > sessionInfo()
## R version 3.1.0 beta (2014-03-28 r65330)
## Platform: x86_64-pc-linux-gnu (64-bit)

## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     

## other attached packages:
## [1] rockchalk_1.8.0 MASS_7.3-31     car_2.0-19     

## loaded via a namespace (and not attached):
## [1] compiler_3.1.0 nnet_7.3-8     tcltk_3.1.0    tools_3.1.0   
