##PJ 2013-02-16

library(foreign)
library(mvtnorm)
set.seed(2134234)

dir.create("student-Ex1", showWarnings=F)

N <- 200


drawBivarNorm <- function(N = 200){
  mu <- c(50,500)
  test <- runif(1)
  cov12 <- ifelse(test > 0.7, 30, ifelse(test > 0.3, -30, 0))
  sigma <- matrix (c(20,cov12,cov12,200), nrow=2)
  xy <- rmvnorm(N, mean = mu, sigma = sigma)
  datmvn <- as.data.frame(xy)
  colnames(datmvn) <- c("x1", "y1")
  list(datmvn = datmvn, mu = mu, sigma=sigma)
}



drawPois <- function(N = 200){
  lambda <- rgamma(1, shape=2,scale=1.1)
  y2 <- rpois (N, lambda=lambda)
  list(y2=y2, lambda=lambda)
}

drawBinomial <- function(N = 200){
  mpi <- rbeta(1, 2, 15)
  sizeN <- rpois(1, lambda=20)
  y2 <- rbinom(200, size = sizeN, prob = mpi)
  list(y2=y2, N=sizeN, mpi=mpi)
}

drawGamma <- function(N = 200){
  sh <- 1 + rpois(1, lambda=2)
  sc <- 1 + rpois(1, lambda=1)
  y2 <- rgamma(N, shape=sh, scale=sc)
  list(y2=y2, sh=sh, sc=sc)
}

drawBeta <- function(N = 200){
  sh1 <- rgamma(1, shape=2,scale=1.1)
  sh2 <- rgamma(1, shape=2,scale=1.1)
  y2 <- rbeta(N, sh1,sh2)
  list( y2=y2, sh1=sh1, sh2=sh2)
}

drawT <- function(N = 200){
  mdf <- 5
  y2 <- rt(N, df=mdf)
  list(y2=y2, mdf=mdf)
}


drawSample <- function(type){
    switch(type,
           drawPois = drawPois(),
           drawBinomial = drawBinomial(),
           drawGamma = drawGamma(),
           drawBeta = drawBeta(),
           drawT = drawT())
}




teacher <- vector("list", 50)

pdf(file=paste("Result-students.pdf", sep=""), height=5, width=5)


for(i in 1:50){
    ##creates a dataframe with 2 columns to start
    mymvn <- drawBivarNorm()
    dat <- mymvn$dat

    distro <- c("Pois", "Binomial", "Gamma", "Beta","T")

    disttype <- distro[sample(5, 1)]
    dat[["x2"]] <- drawSample(paste("draw", disttype, sep=""))$y2


    disttype <- distro[sample(5, 1)]
    dat[["x3"]] <- drawSample(paste("draw", disttype, sep=""))$y2

    dat[["x4"]] <- drawBeta()$y2

    dat[["x5"]] <- cut(dat$x4, breaks = c(0, 0.2, 0.3, 0.7, 1.0), labels = c("horrible","adequate", "fine", "sublime"))

    write.table(dat, file=paste("student-Ex1/student-",i,".txt", sep=""), row.names=F)

    write.dta(dat, file = paste("student-Ex1/student-",i,".dta", sep=""))


    teacher[[i]] <-  list(mymvn, rockchalk::summarize(dat), cor=cor(dat[, 1:5]), type = disttype)

    mx1 <- mean(dat$x1)
    my1 <- mean(dat$y1)
    mx3 <- mean(dat$x3)

    plot(y1~x1, data=dat, main=c(paste("Student-",i,sep=""), paste("sigma12=", mymvn$sigma[1,2], sep="")))

    legend("topleft",legend=c(paste("mean(x1)=", round(mx1,3)), paste("mean(y1)=",round(my1,3))), bg="white")
    legend("topright",legend=c(paste("sd(x1)=", round(sd(dat$x1),3)), paste("sd(y1)=",round(sd(dat$y1),3)), paste("cor=",round(cor(dat$x1,dat$y1), 3 ))), bg="white")

    hist(dat$x3, prob=T, main = c(paste("Student-", i, " ", disttype, sep="")))
}

dev.off()

save(teacher, file="teacher-ex1.Rda")



#### Interesting lesson in data precision and why not to write text files
### or about how to compare numbers
dat <- read.table("student-37.txt", header = TRUE)
library(foreign)

dat2 <- read.dta("student-37.dta")

dat[,1] == dat2[ ,1]
all.equal(dat[,1], dat2[,1])
all.equal(dat[,2], dat2[,2])
