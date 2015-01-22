########################################################
### Psyc 650/790 and Pols 706                        ###
### Lab 1: Getting started with R                    ###
########################################################

###### 1.1 Interacting with R ######
#####################################################
### You type an R command at the > prompt in the Console   
###    window, then press the Enter Key. The result or 
###   error/warning massages will show in the console.                           
###                                                  
### Most of time we don't like to run R commands on  
###   a line-by-line basis. Instead we write commands
###   in separate files (.R), which can be saved and 
###   sent to the prompt.                            
###                                                  
### Choose an R program editor:                      
###  (1) R built-in editor: Easy to get started.     
###  (2) RStudio: Recommended for Mac users.       
###  (3) Emacs: Dr. Johnson's favorite.              
###  (4) Notepad +  +  with NppToR: Friendly Windows option. 
###                                                  
### Everything starting with '#' is considered as    
###   a comment. R will skip all the characters      
###   after the number sign until it finds new line  
###   command.                                       
#####################################################

###### 1.2 Using R as a calculator ######
3 + 2  # Addition
3 - 1  # Subtraction
7 * 8  # Multiplication
9 / 3  # Division
3 ^ 2  # Power
sqrt(36) # Square root
log(7) # Natural logarithm
exp(10) # Exponential

1 + 3 * log(10) - (exp(7) - 3) / 4

###### 1.3 Assignment ######
#####################################################
### It is convinient to name a value so that we can  
###   use it later. We do so by assigning values to  
###   objects.                                       
###                                                  
### The left-pointing arrow (<-) is the assignment   
###   operator. The object names could include       
###   letters, numbers, and dots or underscores.      
###   A name should start with a letter.             
###                                                  
### If you assign two values to a same object,       
###   the latter will overwrite the former. But R is 
###   case-sensitive, X and x are different names.   
#####################################################
x <- 1
x   # The value can be printed by typing the object name
x <- 2 + 5  # The result is saved in the object 'x'
x
z <- "Hello!"  # We may save an object as text.
z

X <- 5
X + x
X <- log(2) # This will overwrite the previous value.
X + x


###### 1.4 Getting help ######
## When R was installed, HTML format help files were copied 
## onto your hard drive. To access these files, just type
help.start()

## To request an R document for a specific function, use '?'. 
?log

## To request help by keywords, use '??'.
??logarithm

## Go to R homepage: www.r-project.org.
## Google is your good friend too.
#####################################################


###### 1.5 Data vectors ######
#####################################################
### An object can contain more than one value.    
###   More complex data structures include:          
###   data vector, data matrix, data frame...        
###                                                  
### Let talk about data vector first.                
#####################################################

###### 1.5.1 Generate data vectors (one-dimenson list of numbers)
#####################################################
### (1)                                              
### We can store a variable's values in a data       
###   vector, using the c() function. c() combines items
###   into one object.               
#####################################################
midterm <- c(99, 87, 96, 100, 82, 79, 88, 85, 94, 90)
midterm

#####################################################
### (2)                                              
### Many other functions also return vectors as      
###   results. For example the sequence operator (:) 
###   generates consecutive numbers, while the        
###   sequence function seq() does much the          
###   same thing, but more flexibly.                 
#####################################################
f <- 1:20
f  # Again, values can be printed by typing the name

g <- seq(1,20) # seq(start value, end value, interval)

h <- seq(1,20, by = 0.2) # specify interval 

#####################################################
### (3)                                              
### We can create repeat scores by using rep().  
###   rep() actually stands for 'replicate'.
#####################################################
k <- rep(1, 5)  # rep(value, number of times)
k

l <- rep(1:10, 5)  # rep() can accept complex values
l

#####################################################
### (4)                                              
### There are a couple of distribution functions that    
###   can be used to generate a vector of random     
###   numbers from a specified distribution.      
#####################################################
datn <- rnorm(1000,24,3)  # Generates 1000 random numbers 
## from a normal disribution
## with an expected value of 24 
## and a standard deviation of 3.  

datp <- rpois(1000,3)     # 1000 random numbers 
## from a poisson disribution
## with an expected value of 3. 


###### 1.5.2 Descriptive statistics of one-dimenson data
#####################################################
### Let's find the mean, median, variance,           
###   standard deviation, minimum, maximum...        
###   for the midterm data.                          
#####################################################
midterm <- c(99, 87, 96, 100, 82, 79, 88, 85, 94, 90)

mean(midterm)
median(midterm)
var(midterm)
sd(midterm)
min(midterm)
max(midterm)
range(midterm)
length(midterm)
table(midterm) # returns frequency of each element in the vector
sum(midterm)
summary(midterm)

## If there are some missing data...
midterm2 <- c(99, NA, 96, 100, 82, NA, 88, 85, 94, 90)
mean(midterm2)  # This does not work. We need to tell R
## to remove the missing values before 
## computing descriptive statistics.

mean(midterm2, na.rm=TRUE)

## Try these functions on datn
## Recall that we already have datn <- rnorm(1000,24,3)
mean(datn)
median(datn)
sd(datn)

###### 1.5.3 Vector arithmetic
#####################################################
### The standard arithmetic operators and functions  
###   apply to vectors on an element-wise basis.     
#####################################################
c(1, 2, 3, 4) - 4

c(1, 2, 3, 4)/4

c(1, 2, 3, 4)/c(4, 3, 2, 1)   # 1/4, 2/3, 3/2, 4/1

log(c(1, 2, 3, 4))  # applies log to each

## Can you tell what this is?
sum((midterm - mean(midterm))^2)/(length(midterm)-1)


###### 1.4.4 Accessing data by using vector indices
#####################################################
### In a data vector, each observation x1, x2, ..,xn,
###   is referred to by its index using square brackets,
###   as in x[1], x[2], ..., x[n].                   
#####################################################
midterm 

midterm[2]
midterm[length(midterm)]

midterm[1:4] # take more than one element at a time.
midterm[c(1:4, 8, 10)]
midterm[1, 2, 3, 4, 8, 10]  # This is NOT THE SAME


###### 1.6 Plotting data: Histogram and Kernel Density Plot
#####################################################
### To plot a histogram, use hist().                   
###                                                  
### To supperimpose a kernel density plot on the top 
###   of a histogram, use lines(density()).          
#####################################################
## Recall that the usage of rnorm() is 
## rnorm(# of observations, mean, standard deviation)
mydata <- rnorm (1000, 0, 1) 

?hist
hist(mydata) # frequencies on Y-axis
hist(mydata, prob=TRUE) # proportions on Y-axis
hist(mydata, prob=TRUE, xlab="X-Variable Name") # Label the X-axis
hist(mydata, prob=TRUE, xlab="X-Variable Name", 
     ylab="Proportion of Cases") # Label the Y-axis
hist(mydata, prob=TRUE, xlab="X-Variable Name", 
     ylab="Proportion of Cases", main="My First Histogram") 
    # Gives the figure a title
hist(mydata, prob=TRUE, xlab="X-Variable Name", 
     ylab="Proportion of Cases", breaks=50) 
    # sets the number of bins

lines(density(mydata)) # add a kernel density plot 
                      ## on the top of a histogram


dev.print(pdf, "histo-1.pdf") # Save the figure to a pdf
                              # See Plot-2 under Rcourse folder


###### 1.7 Workspace ######
#####################################################
### Everything that has a name in R is called        
###   an object. The workspace is your current R     
###   working environment and includes any           
###   user-defined objects (vectors, matrices,       
###   data frames, lists, functions).                
###                                                  
### The ls() function will list all the objects in   
###   a workspace. We can remove object(s) from the  
###   workspace by rm().                             
#####################################################
getwd()
setwed()
ls()
rm(x) # Object x will be deleted
rm(list = ls(all = TRUE)) # delete all objects

## You can get all kinds of information about your objects
## Let's use the histogram object as an example
h1 <- hist(mydata, prob=TRUE, xlab="X-Variable Name", 
           ylab="Proportion of Cases", 
           main="My First Histogram", breaks=10) 
h1
attributes(h1) 
names(h1)
h1$mids   # The $ allows you to access a specific attribute of the object


#####################################################
### At the end of an R session, you can save an image
###   of the current workspace that is automatically 
###   reloaded the next time R is started. But we    
###   don't usally do that.                          
###                                                  
### Note that the workspace consists only of R objects, 
###   not of any of the output that you have generated 
###   during a session. If you want to save your     
###   output, use "Save to File" from the File Menu  
###   or use standard cut-and-paste facilities.      
###                                                  
### PS, there are ways to export your data and       
###   save them in some specific formats for further 
###   uses (we'll get to that next week). Most of     
###   time we don't need to keep them in the R image.
#####################################################


###### 1.8 Packages ######
#####################################################
### A package is a collection of R functions, data,  
###   and compiled code in a well-defined format.    
###   R comes with a standard set of packages.       
###   Others can be download and installed from      
###   www.r-project.org. Once installed, the packages
###   need to be loaded into the session to be used. 
###                                                  
### A package can be download and installed using    
###   the install.packages() function.               
###                                                  
### To load a package to R session, use library().   
#####################################################
install.packages("rockchalk") 
library(rockchalk)
help(package="rockchalk")

## Now, try the summarize() function in rockchalk package
summarize(mydata)
