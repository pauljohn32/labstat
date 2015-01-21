Change plots around line 229 back to plot(JOBPERF ~ IQ, data = mydata)



########################################################
### Psyc 650/790 and Pols 706                        ###
### Lab 2: Reading and exploring data                ###
########################################################

###### 2.1 Directories and Files
#####################################################
### Working directory is the physical directory in 
###    your computer in which you are currently working. 
### Having the working directory set correctly is very 
###    convenient. You can both read and write files to 
###    the proper place without typing path names.
#####################################################
getwd()   # print the current working directory 
setwd("C:\\lab650")   # set your working directory


#####################################################
### (3) Reading in an external data set
### The most common way is to use the function 
###    read.table() to read in text files.  
### If you are trying to read in an excel file,  
###   save it as a .CSV (Comma Delimited) file first,  
###   and then use read.csv() instead of read.table().
### In both functions, a file is refered to by its name 
###    and sometimes its path. 
### Must use UNIX traditional forward slash "/" to 
###    separate directories. Windows users can also use
###    double backward slash "\\".
#####################################################
mydata1 <- read.table(file="C:/lab650/job1.txt")

### After setting a working directory, you can read 
### and write files from/to the directory without 
### typing path names.
mydata <- read.csv(file="job1.txt")

### If the first row in your data file is the names of the variables,
### add this argument in the function: header=TRUE
mydata2 <- read.table(file="job2.txt", header=TRUE)
head(mydata2)


###### 2.2 Data frames ###### 
########################################################
### We've talked about how to create data vector in R.
###   A data vector only contains one-dimensional data.
###   We usually use a data vector to store a variable.
###
### Most of time, it is convenient to put multiple 
###    variables together into a data set. 
###
### A data frame is an R object used to store rectangular 
###   (two-dimensional) grids of data. 
### Usually each row corresponds to measurements on 
###    the same subject. Each column is a data vector 
###    containing data for one of the variables.
########################################################


###### 2.2.1 
#####################################################
### (1) Using data sets in R packages
### Many R packages contain built-in data sets.
###    A built-in data set can be read into the  
###    current workspace via the data() command.
### Let's take the UsingR pacakge for example.
#####################################################
install.packages("UsingR") # install UsingR package
library(UsingR) # load the package to R session
help(package="UsingR") # take a look at what's in the package

data(babies) # read in babies data to the workspace
ls()   # look at the list of objects in the workspace
babies  # simply type the name of the data frame

head(babies) # show the first 6 rows
colnames(babies) # returns column names. Also see rownames()


#####################################################
### (2) Creating data frames with R
#####################################################
x <- c(100, 95, 93, 97) # define a data vector (variable) x
y <- c(95, 98, 86, 91) # define y

dat <- data.frame(x, y) # create a data frame, cols are variables
## You can see dat in your Workspace now
dat  


###### 2.1.3 Accessing values in a data frame
#####################################################
### Recall that entries of a data vector are accessed
###    with the [] notation. To access entries of a  
###    data frame, we use the [row, column] notation.
###    We can specify entries we want by indices, 
###    names, or a logical vector. 
###
### We can also use a dollar sign "$" to access a variable  
###    in a data frame.
#####################################################
mydata <- read.csv(file="job.csv", header=TRUE)
mydata  # this is the data frame
head(mydata)

### (1) Specify entries by indices
mydata[1, 2]  # the entry at row 1 and column 2
mydata[1:10, ] # the first ten rows (all columns)
mydata[ , 4:5] # the 4th and 5th columns
mydata[c(2, 3, 5), 1:3] # rows 2, 3, and 5 of columns 1-3
mydata[-1:-400, ] # all data except for the first 400 rows

###(2) Specify entries by names
mydata["1" , "AGE"]
mydata[1:20, c("IQ", "AGE", "WBEING", "SATIS")]

###(3) Specify entries by a logical vector
mydata[mydata$FEMALE == 0, ]  # select data for males
## Because mydata$FEMALE == 0 returns a logical vector, 
## and mydata[mydata$FEMALE == 0, ] returns the rows of 
## mydata for which the logical vector's values are true.

mydata[mydata$AGE > 50, ]

###(4) Accessing a single variable by "$"
mydata$IQ   # returns the IQ variable in mydata

###### 2.1.4 Descriptive statistics of two-dimensional data
dim(mydata) # returns dimensions of a data frame
dim(mydata[ , c("IQ", "AGE", "WBEING", "SATIS")])

summary(mydata) # a summary of each variable
summary(mydata[ , c("IQ", "AGE", "WBEING", "SATIS")])

table(mydata$FEMALE, mydata$JOBPERF) # frequncy table

cov(mydata$AGE, mydata$JOBPERF) # covariance
cor(mydata$AGE, mydata$JOBPERF) # correlation

### Note that each column in a data frame is 
### a data vector, so all the one-dimensional 
### descriptive functions applies here.
mean(mydata$IQ)
sd(mydata$IQ)
range(mydata$IQ)

### We can create a new variable in the data frame
### by directly assigning values to it.
mydata$IQ.centered <- mydata$IQ - mean(mydata$IQ)
summary(mydata) 

###### 2.1.5 Factors (categorical variables)
#####################################################
### When reading in data using data.frame() or  
###    read.table()/ read.csv(), R guesses the 
###    types of variables. By default, numeric variables  
###    will still be numeric, while character data and 
###    logical data will be the translated 
###    into factors (categorical variables).
###
### But sometimes we need to tell R specifically that 
###   some of the numeric variables are actually
###   factors.
###
### The factor() function converts a numeric variable
###    into a factor. The labels= argument specifies
###    labels for the factor levels. 
#####################################################

### The following command creates a new variable FEMALE.f in mydata, 
### by copying all the values of FEMALE, but removing the numerical
### attribute. 
mydata$FEMALE.f <- factor(mydata$FEMALE)
levels(mydata$FEMALE.f) # look at the catagories (aka levels)

### In addition, the factor() function can add labels 
### for the factor levels. The original labels are "0" and "1"
### which are listed in alpha-numberical order, so we need to specify 
### the new labels in corresponding order. 
### Note that in the data 0=male, and 1=female.
mydata$FEMALE.f <- factor(mydata$FEMALE, labels=c("Male", "Female"))
levels(mydata$FEMALE.f)
mydata$TURNOVER.f <- factor(mydata$TURNOVER, labels=c("No", "Yes"))
levels(mydata$TURNOVER.f)

summary(mydata)

###### 2.1.6 The with() function
#####################################################
### It could be cumbersome to type the data frame name
###    all the time when referring to a variable.
### The with(data frame, command) function can help  
###    us avoid this problem.
#####################################################
### The following command is a better way to 
### make a two-way table than table(mydata$FEMALE, mydata$JOBPERF)
with(mydata, table(FEMALE, JOBPERF))

### Another example:
with(mydata, cov(IQ, JOBPERF))

###### 2.1.7 Exporting data
#####################################################
### To write a R data frame to a file, use 
###    write.table() / write.csv() function. 
###
### Make sure that you have set the working directory,
###    so that you don't have to type the path of 
###    the file. 
### The argument sep= in write.table() specifies 
###    the separator string in you data file.  
###    Values within each row are separated by 
###    this string.
### Some commonly used separators are
###    comma ",", space " ", and tab "\t".
### The argument row.names=FALSE indicates that  
###    row names will not be written into file.
### The argument quote=FALSE tells R not to 
###    write quotes for character or factor columns.
#####################################################
write.table(mydata, file="out.txt", sep="\t", row.names=FALSE, quote = FALSE)

write.csv(mydata, file="out.csv", row.names=FALSE, quote = FALSE)

###### 2.2 Plots and Tables of multivariate data ######
###### 2.2.1 Scatter plot
###(1) Two-way scatter plot, plot(x, y) function
plot(mydata$IQ, mydata$JOBPERF)

###(2) Scatter plot matrix  # Use all rows of cols 2, 3, 4
pairs(mydata[, c(2, 3, 4)]) 

###(3) A more complex example (two groups)
#  Store two new datasets-- one for males, one for females
mydata_m <- mydata[mydata$FEMALE==0, ]  # copy rows where FEMALE==0
mydata_f <- mydata[mydata$FEMALE==1, ]  # copy rows where FEMALE==1

plot(mydata$IQ, mydata$JOBPERF, xlab="IQ", ylab="Job Performance", type="n")
points(mydata_m$IQ, mydata_m$JOBPERF, col="black", pch=1) #  col= sets the color
points(mydata_f$IQ, mydata_f$JOBPERF, col="grey80", pch=4)  # pch= sets the shape
legend("topleft", legend=c("Male","Female"), col=c("black","grey80"), pch=c(1,4))
?points

###### 2.2.2 Box plot
###(1) Single box plot, boxplot()
boxplot(mydata$IQ)
boxplot(mydata$JOBPERF)

###(2) Box plots of multiple groups, boxplot(y ~ x)
boxplot(mydata$JOBPERF ~ mydata$FEMALE.f)  # accepts an equation
boxplot(mydata$JOBPERF ~ mydata$FEMALE.f, ylab="Job Performance", 
        xlab="Gender", names=c("Male","Female"))  #  Add labels 

boxplot(JOBPERF ~ FEMALE.f, data=mydata)  
# Cleaner way to indicate where the variables come from
# Not all functions allow this format but it's preferred

###### 2.2.3 Cross-Tabulation
###(1) descr package::CrossTable(x,y) function 
install.packages("descr")
library(descr)
myTable1 <- with(mydata, CrossTable(FEMALE.f, TURNOVER.f))
myTable1

###(2) memisc package::genTable(y~x) function
install.packages("memisc")
library(memisc)
myTable2 <- with(mydata, genTable(TURNOVER.f ~ FEMALE.f))
myTable2
myTable3 <- with(mydata, genTable(percent(TURNOVER.f) ~ FEMALE.f))
myTable3

###### 2.2.4 Bar plot
### A bar plot is a graphic presentation of a cross tabulation table.
barplot(myTable3[1:2,], beside=T, names=c("Men","Women"), 
        col=c("blue","red"), density=c(90,40), 
        angle=c(45,-45), ylab="Turnover", xlab="Gender")
legend("topright", legend = levels(mydata$TURNOVER.f), 
       fill=c("blue","red"), density=c(90,40), 
       angle = c(45,-45), cex=1.2)

# Note that barplot() uses "col=" but legend() uses "fill="
