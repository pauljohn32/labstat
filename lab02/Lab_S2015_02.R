## ----eval = FALSE--------------------------------------------------------
## install.packages("UsingR") # install UsingR package

## ------------------------------------------------------------------------
library(UsingR) # load the package to R session

## ------------------------------------------------------------------------
help(package="UsingR") # take a look at what's in the package
ls()   # look at the list of objects in the workspace

## ----eval = FALSE--------------------------------------------------------
## rm(list = ls())

## ------------------------------------------------------------------------
babies  # simply type the name of the data frame

## ------------------------------------------------------------------------
head(babies) # show the first 6 rows

## ------------------------------------------------------------------------
colnames(babies) # returns column names. Also see rownames()

## ------------------------------------------------------------------------
x <- c(100, 95, 93, 97) # define a data vector (variable) x
y <- c(95, 98, 86, 91) # define y
dat <- data.frame(x, y) # create a data frame, cols are variables
## You can see dat in your Workspace now
dat

## ------------------------------------------------------------------------
getwd()

## ----eval = FALSE--------------------------------------------------------
## # see lab 1 for examples on setwd()
## setwd()

## ------------------------------------------------------------------------
# Check out ?read.table
mydata1 <- read.table(file = "job1.txt")

## ------------------------------------------------------------------------
mydata <- read.csv(file = "job.csv", header = TRUE)
head(mydata)

## ------------------------------------------------------------------------
mydata[1, 2]  # the entry at row 1 and column 2
mydata[1:10, ] # the first ten rows (all columns)

## ------------------------------------------------------------------------
mydata[ , 4:5] # the 4th and 5th columns

## ------------------------------------------------------------------------
mydata[c(2, 3, 5), 1:3] # rows 2, 3, and 5 of columns 1-3

## ------------------------------------------------------------------------
mydata[-1:-400, ] # all data except for the first 400 rows

## ------------------------------------------------------------------------
mydata["1" , "AGE"]
mydata[1:20, c("IQ", "AGE", "WBEING", "SATIS")]

## ------------------------------------------------------------------------
mydata[mydata$FEMALE == 0, ]  # select data for males

## ------------------------------------------------------------------------
mydata[mydata$AGE > 50, ]

## ------------------------------------------------------------------------
mydata$IQ

## ------------------------------------------------------------------------
dim(mydata) # returns dimensions of a data frame
summary(mydata) # a summary of each variable

## ------------------------------------------------------------------------
dim(mydata[ , c("IQ", "AGE", "WBEING", "SATIS")])
summary(mydata[ , c("IQ", "AGE", "WBEING", "SATIS")])

## ------------------------------------------------------------------------
table(mydata$FEMALE, mydata$JOBPERF)

## ------------------------------------------------------------------------
cov(mydata$AGE, mydata$JOBPERF)
cor(mydata$AGE, mydata$JOBPERF)

## ------------------------------------------------------------------------
mean(mydata$IQ)
sd(mydata$IQ)
range(mydata$IQ)

## ------------------------------------------------------------------------
mydata$IQ.centered <- mydata$IQ - mean(mydata$IQ)
summary(mydata)

## ------------------------------------------------------------------------
mydata$FEMALE.f <- factor(mydata$FEMALE)
levels(mydata$FEMALE.f) # look at the catagories (aka levels)

## ------------------------------------------------------------------------
mydata$FEMALE.f <- factor(mydata$FEMALE, labels=c("Male", "Female"))
levels(mydata$FEMALE.f)
mydata$TURNOVER.f <- factor(mydata$TURNOVER, labels=c("No", "Yes"))
levels(mydata$TURNOVER.f)

## ------------------------------------------------------------------------
summary(mydata[ , c("FEMALE", "FEMALE.f", "TURNOVER", "TURNOVER.f")])

## ------------------------------------------------------------------------
# Equal to table(mydata$FEMALE, mydata$JOBPERF)
with(mydata, table(FEMALE, JOBPERF))
# Another example
with(mydata, cov(IQ, JOBPERF))

## ------------------------------------------------------------------------
plot(JOBPERF ~ IQ, data = mydata)

## ------------------------------------------------------------------------
pairs(mydata[, c(2, 3, 4)]) 

## ------------------------------------------------------------------------
mydata_m <- mydata[mydata$FEMALE==0, ]  # copy rows where FEMALE==0
mydata_f <- mydata[mydata$FEMALE==1, ]  # copy rows where FEMALE==1

## ------------------------------------------------------------------------
plot(JOBPERF ~ IQ, data = mydata, xlab="IQ", ylab="Job Performance", 
     type="n")
points(JOBPERF ~ IQ, data = mydata_m, col="black", 
       pch=1) #  col= sets the color

## ----eval = FALSE--------------------------------------------------------
## plot(JOBPERF ~ IQ, data = mydata, xlab="IQ", ylab="Job Performance",
##      type="n")
## points(JOBPERF ~ IQ, data = mydata_m, col="black",
##        pch=1) #  col= sets the color
## points(JOBPERF ~ IQ, data = mydata_f, col="grey80",
##        pch=4)  # pch= sets the shape
## legend("topleft", legend=c("Male","Female"), col=c("black","grey80"),
##        pch=c(1,4))

## ----echo = FALSE--------------------------------------------------------
plot(JOBPERF ~ IQ, data = mydata, xlab="IQ", ylab="Job Performance", type="n")
points(JOBPERF ~ IQ, data = mydata_m, col="black", pch=1) #  col= sets the color
points(JOBPERF ~ IQ, data = mydata_f, col="grey80", pch=4)  # pch= sets the shape
legend("topleft", legend=c("Male","Female"), col=c("black","grey80"), pch=c(1,4))

## ------------------------------------------------------------------------
boxplot(mydata$IQ)

## ------------------------------------------------------------------------
boxplot(mydata$JOBPERF)

## ----eval = FALSE--------------------------------------------------------
## boxplot(mydata$JOBPERF ~ mydata$FEMALE.f)  # accepts an equation
## boxplot(mydata$JOBPERF ~ mydata$FEMALE.f, ylab="Job Performance",
##         xlab="Gender", names=c("Male","Female"))  #  Add labels
## 
## # Equivalent to first plot above but cleaner to read
## boxplot(JOBPERF ~ FEMALE.f, data=mydata)
## 
## # Commented out in lab code but try running it!

## ----eval = FALSE--------------------------------------------------------
## # Run this line if you need to install the package
## install.packages("descr")

## ------------------------------------------------------------------------
library(descr)
myTable1 <- with(mydata, CrossTable(FEMALE.f, TURNOVER.f))

## ------------------------------------------------------------------------
myTable1

## ----eval = FALSE--------------------------------------------------------
## # Run this line if you need to install the package
## install.packages("memisc")

## ------------------------------------------------------------------------
library(memisc)

## ------------------------------------------------------------------------
myTable2 <- with(mydata, genTable(TURNOVER.f ~ FEMALE.f))
myTable2
myTable3 <- with(mydata, genTable(percent(TURNOVER.f) ~ FEMALE.f))
myTable3

## ----eval = FALSE--------------------------------------------------------
## barplot(myTable3[1:2,], beside=T, names=c("Men","Women"),
##         col=c("blue","red"), density=c(90,40), angle=c(45,-45),
##         ylab="Turnover", xlab="Gender")
## legend("topright", legend = levels(mydata$TURNOVER.f),
##        fill=c("blue","red"), density=c(90,40), angle = c(45,-45),
##        cex=1.2)
## 
## # Note that barplot() uses "col=" but legend() uses "fill="

## ----echo = FALSE--------------------------------------------------------
barplot(myTable3[1:2,], beside=T, names=c("Men","Women"), 
        col=c("blue","red"), density=c(90,40), angle=c(45,-45),
        ylab="Turnover", xlab="Gender")
legend("topright", legend = levels(mydata$TURNOVER.f), 
       fill=c("blue","red"), density=c(90,40), angle = c(45,-45),
       cex=1.2)

## ----eval = FALSE--------------------------------------------------------
## write.table(mydata, file="out.txt", sep="\t", row.names=FALSE,
##             quote = FALSE)
## write.csv(mydata, file="out.csv", row.names=FALSE, quote = FALSE)

