## ----echo =FALSE---------------------------------------------------------
options(width = 75)

## ------------------------------------------------------------------------
# Read in data
lab4 <- read.table("salary_subset.txt", header=TRUE)
library(rockchalk)
summarize(lab4)

## ------------------------------------------------------------------------
# outcome (dependent variable) regressed on predictor (independent variable)
lm(salary ~ pub, data= lab4)

## ------------------------------------------------------------------------
# outcome (dependent variable) regressed on predictor (independent variable)
lm(salary ~ pub, data= lab4)

## ------------------------------------------------------------------------
# outcome (dependent variable) regressed on predictor (independent variable)
lm(salary ~ pub, data= lab4)

## ------------------------------------------------------------------------
mod1 <- lm(salary ~ pub, data= lab4)

## ------------------------------------------------------------------------
summary(mod1)

## ------------------------------------------------------------------------
anova(mod1)

## ------------------------------------------------------------------------
names(mod1)

## ------------------------------------------------------------------------
vcov(mod1)

## ------------------------------------------------------------------------
confint(mod1)

## ------------------------------------------------------------------------
confint(mod1, level = 0.99)

## ------------------------------------------------------------------------
predict(mod1)

## ------------------------------------------------------------------------
fitted(mod1)

## ------------------------------------------------------------------------
resid(mod1)

## ----fig.align='center'--------------------------------------------------
cor(lab4$salary, lab4$pub)
# Now make a scatterplot and add a line based on our model
plot(salary ~ pub, data= lab4) 
abline(mod1)

## ----fig.align='center'--------------------------------------------------
plot(salary ~ pub, data= lab4) 
abline(47940.4, 1148.2)  # abline(intercept, slope)

## ----fig.align='center'--------------------------------------------------
termplot(mod1, se=TRUE, partial.resid=TRUE)

## ------------------------------------------------------------------------
# Find the range of our predictor
range(lab4$pub)
# Use the range to create a 1 column data.frame covering that range
regData <- data.frame("pub" = seq(1, 40)) 
# Create a new data.frame storing predicted values
regData.pred <- predict(mod1, newdata = regData, interval = "conf")
# Bind those two data.frames together
regData <- cbind(regData, regData.pred)

## ----fig.align='center'--------------------------------------------------
plot(salary ~ pub, data= lab4)
lines(fit ~ pub, data=regData)                    #plot the predicted values
lines(lwr ~ pub, data=regData, lty=3, col="red")  #plot the lower boundary
lines(upr ~ pub, data=regData, lty=4, col="red")  #plot the upper boundary
legend("topleft", legend=c("predicted", "conf-lower", "conf-upper"),
       lty=c(1,3,4), col=c("black","red","red"))

## ----fig.align='center'--------------------------------------------------
range(lab4$pub)
regData <- data.frame("pub" = seq(1, 40)) 
regData.pred <- predict(mod1, newdata = regData, interval = "conf")
matplot(x = regData, y = regData.pred , type = "l")
points(salary ~ pub, data= lab4, col = gray(.7))

## ------------------------------------------------------------------------
head(lab4) # gender has two levels, 0 and 1
lab4$gender <- factor(lab4$gender) # turn gender into a factor
levels(lab4$gender) # look at the levels
lab4$gender <- factor(lab4$gender, label=c("male", "female")) # assign labels
summary(lab4) # check your work

## ------------------------------------------------------------------------
mod2 <- lm(salary ~ gender, data= lab4) 
contrasts(lab4$gender)

## ------------------------------------------------------------------------
summary(mod2)

## ----fig.align='center'--------------------------------------------------
plot(salary ~ gender, data = lab4)
abline(mod2)

## ----fig.align='center'--------------------------------------------------
termplot(mod2, se = T, partial.resid =T)

## ----fig.align='center'--------------------------------------------------
termplot(mod2, se = T, partial.resid =T, ylab = "salary")

## ----fig.align='center'--------------------------------------------------
plot(salary ~ gender, data = lab4)
regData <- data.frame("gender" = levels(lab4$gender))
regData.pred <- predict(mod2, newdata = regData, interval = "conf")
regData <- cbind(regData, regData.pred)

## ----eval = FALSE--------------------------------------------------------
## plot(salary ~ gender, data = lab4)
## # Predicted values
## lines( x=c(0.75, 1.25), y = c(regData$fit[1], regData$fit[1]), col="green", lwd=2)
## lines( x=c(1.75, 2.25), y = c(regData$fit[2], regData$fit[2]), col="green", lwd=2)
## # Upper values
## lines( x=c(0.85, 1.15), y = c(regData$upr[1], regData$upr[1]), col="red", lwd=2)
## lines( x=c(1.85, 2.15), y = c(regData$upr[2], regData$upr[2]), col="red", lwd=2)
## # Lower values
## lines( x=c(0.85, 1.15), y = c(regData$lwr[1], regData$lwr[1]), col="red", lwd=2)
## lines( x=c(1.85, 2.15), y = c(regData$lwr[2], regData$lwr[2]), col="red", lwd=2)

## ----echo = FALSE, fig.align='center'------------------------------------
plot(salary ~ gender, data = lab4)
lines( x=c(0.75, 1.25), y = c(regData$fit[1], regData$fit[1]), col="green", lwd=2)
lines( x=c(1.75, 2.25), y = c(regData$fit[2], regData$fit[2]), col="green", lwd=2)
lines( x=c(0.85, 1.15), y = c(regData$upr[1], regData$upr[1]), col="red", lwd=2)
lines( x=c(1.85, 2.15), y = c(regData$upr[2], regData$upr[2]), col="red", lwd=2)
lines( x=c(0.85, 1.15), y = c(regData$lwr[1], regData$lwr[1]), col="red", lwd=2)
lines( x=c(1.85, 2.15), y = c(regData$lwr[2], regData$lwr[2]), col="red", lwd=2)

