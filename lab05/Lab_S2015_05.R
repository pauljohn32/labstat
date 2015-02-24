## ------------------------------------------------------------------------
getwd()
if (!file.exists("publicspending.txt")){
    lab5.url <- "http://pj.freefaculty.org/guides/stat/DataSets/PublicSpending/publicspending.txt"
    download.file(lab5.url, destfile = "publicspending.txt")
}
lab5 <- read.table("publicspending.txt", header = TRUE)

## ----echo = FALSE--------------------------------------------------------
options(width = 75)

## ------------------------------------------------------------------------
library(rockchalk)

## ------------------------------------------------------------------------
head(lab5)

## ------------------------------------------------------------------------
colnames(lab5) <- tolower(colnames(lab5))
names(lab5)

## ------------------------------------------------------------------------
summarize(lab5)

## ----eval = FALSE--------------------------------------------------------
## cov(lab5)
## 
## > cov(lab5)
## Error: is.numeric(x) || is.logical(x) is not TRUE

## ----cov-----------------------------------------------------------------
cov(lab5[ , 1:6])

## ----cor2----------------------------------------------------------------
cor(lab5[ , 1:6])

## ----fig.align="center"--------------------------------------------------
plot(lab5[ , 1:6])

## ------------------------------------------------------------------------
mod1 <-lm(ex ~ ecab, data = lab5)

## ------------------------------------------------------------------------
summary(mod1)

## ------------------------------------------------------------------------
vcov(mod1)

## ------------------------------------------------------------------------
sqrt(diag(vcov(mod1)))

## ------------------------------------------------------------------------
mean(lab5$ecab)
# b0 + b1ecab_at_mean
118.9832 + 1.7329*96.75417

## ------------------------------------------------------------------------
lab5$ecabmc <- scale(lab5$ecab,  center = TRUE, scale = FALSE)

## ----fig.align="center"--------------------------------------------------
cor(lab5$ecab, lab5$ecabmc)
plot(ecabmc ~ ecab, lab5) # check your work

## ------------------------------------------------------------------------
mod2 <-lm(ex ~ ecabmc, data = lab5)
anova(mod2)
anova(mod2, mod1) # compare new with original

## ------------------------------------------------------------------------
summary(mod2)

## ----echo = FALSE--------------------------------------------------------
options(width = 70)

## ------------------------------------------------------------------------
summary(meanCenter(mod1))

## ----fig.align="center"--------------------------------------------------
plot(ex ~ ecab, data = lab5)

## ----fig.align="center"--------------------------------------------------
plot(ex ~ ecab, xlab = "Economic capability", ylab = "Per capita public expenditure", 
     main = "Expenditure Predicted by Economic Capability", type = "n", data = lab5)
with(lab5[lab5$west == 0, ], points(ecab, ex, pch = 0))
with(lab5[lab5$west != 0, ], points(ecab, ex, pch = 4))
abline(mod1)
legend("bottomright",legend=c("Eastern", "Western"), pch=c(0,4), title = "States")

## ----eval = FALSE--------------------------------------------------------
## pdf("SampleGraph.pdf", width=7.5, height=5)
## plot(ex ~ ecab, xlab = "Economic capability", ylab = "Per capita public expenditure",
##      main = "Expenditure Predicted by Economic Capability", type = "n", data = lab5)
## with(lab5[lab5$west == 0, ], points(ecab, ex, pch = 0))
## with(lab5[lab5$west != 0, ], points(ecab, ex, pch = 4))
## abline(mod1)
## legend("bottomright",legend=c("Eastern", "Western"), pch=c(0,4), title = "States")
## dev.off()

