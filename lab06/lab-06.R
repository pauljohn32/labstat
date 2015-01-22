########################################################
### Psyc 650/790 and Pols 706                        ###
### Lab 6: Multiple Regression (2)                   ###
########################################################

library(rockchalk)
lab6 <- read.table("publicspending.txt", header=T)


###### 6.1 R^2 always gets bigger when more variables are added ######

mod1 <- lm(EX ~ ECAB, data= lab6)
summary(mod1)

mod2 <- lm(EX ~ ECAB + MET , data= lab6)
summary(mod2)

mod3 <- lm(EX ~ ECAB + MET + GROW, data= lab6)
summary(mod3)


## Plot MET for three levels of GROW
plotSlopes(mod3, plotx="MET", modx="GROW")
## Also works for non-linear relationships
mod4 <- lm(EX ~ ECAB + MET + GROW + I(MET^2), data= lab6)
plotCurves(mod4, plotx="MET", modx="GROW")


###### 6.2 Making a publication quality table with regression models ######
######(1) rockchalk::outreg()
## The outreg() function in rockchalk creates LaTeX or HTML code 
## for a professionally acceptable regression table.
## The input of the outreg() function must be a lm()/glm() model or a 
## list of lm()/glm() models. 

## How does it work with Lyx?
## a) Run the outreg() function, copy the output.
## b) Start the lyx window, go to the "File" menu, open a new .lyx file.
## c) Go to the "Insert" menu, click "Tex Code". It creates a empty box.
## d) Paste the outreg() output into the box.
## e) Go to the "View" menu, click "View [PDF(pdflatex)]". 
##    This will pop up a PDF file which contains the regression table.
outreg(mod1)
outreg(list(mod1, mod2, mod3)) 

## How does it work with HTML?
## a) Run the outreg() function with the type argument set to "html"
## b) outreg() will create an html file and open it in a browser window
## c) Check the outreg() output for the html file location: "/tmp/..."
## d) Find this file and right click to open in Word
## e) Alternatively, open word and File -> Open the html file
outreg(list(mod1, mod2, mod3), type="html") 


######(2) memisc::mtable()
## The mtable() function in memisc creates a publication quality table
## directly in R console, which can be further edited in a 
## Microsoft Office programs. 
library(memisc)
onetable <- mtable(mod1) # Create a table with one model
onetable 

multitable <- mtable("Model 1"=mod1,"Model 2"=mod2,"Model 3"=mod3, summary.stats=c("sigma","R-squared","F","p","N")) # A table with multiple models
			
multitable  # The output table can be copied/pasted and edited in excel



###### 6.3 Computing Delta R^2 (=sr^2) ######
######(1) Delta R^2 is change in R^2 from dropping one or more variables
## Remember how we can save the summary output to an object
## and then we can reference the individual elements of summary
summod1 <- summary(mod1)  #lm(EX ~ ECAB, data= lab6)
summod1$r.squared

summod2 <- summary(mod2)  #lm(EX ~ ECAB + MET , data= lab6)
summod2$r.squared

summod3 <- summary(mod3)  #lm(EX ~ ECAB + MET + GROW , data= lab6)
summod3$r.squared

deltaR_MET <- summod2$r.squared - summod1$r.squared
deltaR_MET  # The gain in prediction when adding one variable

deltaR_GROW <- summod3$r.squared - summod2$r.squared
deltaR_GROW # The gain in prediction when adding one variable

deltaR_MET_GROW <- summod3$r.squared - summod1$r.squared
deltaR_MET_GROW # The gain in prediction when adding a set of variables
## You may have noticed that deltaR_MET_GROW = deltaR_MET + deltaR_GROW


######(3) Computing delta R^2 using rockchalk::getDeltaRsquare()
## Same deltaR^2 info as sumSquares, but ONLY delta^R^2 info
## There is a really helpful reminder output with this function
#install.packages("rockchalk")
#library(rockchalk)
getDeltaRsquare(mod3) 


## Note that the sum of the dR-sqrs of MET and GROW in this output is NOT equal to
## the R^2 loss of dropping both variables from the model at the same time.
## This is because of shared variance i.e., ___________


###### 6.4 Testing delta R^2 ######
######(1) The anova() function
anova(mod2, mod1, test="F") # testing deltaR_MET
# A significant F statistic indicates that MET can predict a significant
# proportion of variation (deltaR_MET = 3.55%) in EX above and beyond ECAB. 
# In other words, model 2 has a stronger predictive ability than model 1.

anova(mod3, mod2, test="F")
anova(mod3, mod1, test="F")

######(2) The drop1() function
drop1(mod3, test="F")
# Each p-value indicates whether the loss in prediction would be significant
# if we were to drop this one variable from the model.

# Note that this cannot be used for testing the change in R^2 of 
# adding/dropping a SET of variables. 

## 
mcDiagnose(mod3)
## R_j of .7 or so is worrisome...
## VIF = variance inflation factor
