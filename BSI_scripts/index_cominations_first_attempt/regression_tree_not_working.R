#### Regression Tree BSI Raw Data ####

setwd("H:/PhD Data/BSI/2013-14 Summer Scholarship/PhD")

mydata <- read.delim("field_data_movement_combined.txt", row.names = 1)

parameter1 <- (mydata[,1])
parameter2 <- (mydata[,2])
parameter3 <- (mydata[,3])
parameter4 <- (mydata[,4])
parameter5 <- (mydata[,5])
parameter6 <- (mydata[,6])
parameter7 <- (mydata[,7])
parameter8 <- (mydata[,8])
parameter9 <- (mydata[,9])
parameter10 <- (mydata[,10])
parameter11 <- (mydata[,11])
parameter12 <- (mydata[,12])
parameter13 <- (mydata[,13])
parameter14 <- (mydata[,14])
parameter15 <- (mydata[,15])
parameter16 <- (mydata[,16])
parameter17 <- (mydata[,17])
bed.movement <- (mydata[,18])

# Regression Tree Example
library(rpart)

# grow tree 
fit <- rpart(bed.movement~parameter1+parameter2+parameter3
             +parameter4+parameter5+parameter6+parameter7+parameter8
             +parameter9+parameter10+parameter11+parameter12+parameter13+parameter14
             +parameter15+parameter16+parameter17,
             method="anova", data=mydata)


printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
summary(fit) # detailed summary of splits

# create additional plots 
par(mfrow=c(1,2)) # two plots on one page 
rsq.rpart(fit) # visualize cross-validation results  	

# plot tree 
plot(fit, uniform=TRUE, 
     main="Regression Tree for BSI Raw Data")
text(fit, use.n=TRUE, all=TRUE, cex=.8)