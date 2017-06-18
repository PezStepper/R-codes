#############################################################################################################
## This script takes the score vectors for each site and combines them in to a matrix to be correlated     ##
## with bed movement data.                                                                                 ##
#############################################################################################################

# Sites
# Manawatu
# Ngamoko
# Coppermine
# Mangapuaka
# Tamaki
# Mangatautou
# Matanganui
# Matanganui Tributary
# Limestone Creek
# Coal Creek


#### Import individual site score vectors ####

setwd("F:/Andrew BSI DATA")

Manawatu <- read.delim(file="manawatu_scores.txt", header = TRUE)
Ngamoko <- read.delim(file="Ngamoko_scores_test.txt", header = TRUE)
Coppermine <- read.delim(file="Coppermine_scores_test.txt", header = TRUE)
Mangapuaka <- read.delim(file="Mangapuaka_scores_test.txt", header = TRUE)
Tamaki <- read.delim(file="Tamaki_scores_test.txt", header = TRUE)
Mangatautou <- read.delim(file="Mangatautou_scores_test.txt", header = TRUE)
Matanganui <- read.delim(file="Matanganui_scores_test.txt", header = TRUE)
Matanganui.Tributary <- read.delim(file="Matanganui_Tributary_scores_test.txt", header = TRUE)
# Limestone <- read.delim(file="Limestone_scores_test.txt", header = TRUE)
Coal <- read.delim(file="Coal_scores_test.txt", header = TRUE)

bed.movement <- read.delim(file= "H:/PhD Data/BSI/2013-14 Summer Scholarship/PhD/bed_movement.txt", header = TRUE, row.names = 1)

#### Merge vectors to a matrix ####

# REMEBER TO LEAVE SOME VALIDATION SITES OUT

# I will leave Limestone creek out as it's the only site without extremes needed to set scaling

# Test

score.matrix.test <- data.frame(Manawatu
                           , Ngamoko
                          )

head(score.matrix.test)  # check the rows and columns have the same values as corresponding rows in individual vectors
head(Manawatu)
head(Ngamoko)

# Real

score.matrix <- data.frame(Manawatu
                          , Ngamoko
                          , Coppermine
                          , Mangapuaka
                          , Tamaki
                          , Mangatautou
                          , Matanganui
                          , Matanganui.Tributary
                          , Coal
                          )

head(score.matrix)

#### Export Data ####

write.table(score.matrix, file="score_matrix.txt", sep="\t") #assumes we are saving tot he working directory

### Code for correlation between bed movement and scores

#### Transpose the bed movement to have sites as columns ####

install.packages("optimbase")
library(optimbase)

as.data.frame(bed.movement) #convert data.frame to matrix

bed.movement.T <- t(bed.movement[-9,]) #transpose the data, and drop column 9 (Limestone Creek)

View(bed.movement.T)


# THE BELOW CODE IS STILL IN BETA #

#### Correlation ####

# Parallel processing  http://gforge.se/2015/02/how-to-go-parallel-in-r-basics-tips/ , https://www.r-bloggers.com/parallel-r-loops-for-windows-and-linux/

test <- c(score.matrix[1,])
bed.test <- c(bed.movement.T)

cor(as.numeric(test), as.vector(bed.test)) #working : HOW CAN I LOOP THIS?

bed.mov<- c(bed.movement.T)

# LOOP TEST # WORKING

bed.mov<- c(bed.movement.T)

bed.test <- c(bed.movement.T)

test.b <- data.frame(matrix(ncol = 9, nrow = 4)) #Working : creates an empty dataframe to populate

for(i in 1:4){
  for(j in 1:9){
  test.b[i,j] <- c(score.matrix[i,j])
  }
} # working creates rows int he empty data from equal to the score matrix rows but as numeric

matrix.test <- data.frame(matrix(nrow = 4, ncol = 1)) # creates dataframe

for(i in 1:4){
    matrix.test[i,] <- cor(as.numeric(test.b[i,]), as.vector(bed.test))
} #working : adds correlation of score.matrix rows and movement to the matrix.test dataframe


cor(as.numeric(test.b[2,]), as.vector(bed.test)) #working : HOW CAN I LOOP THIS?


#https://stat.ethz.ch/pipermail/r-help//2009-November/409838.html

# Full Scale # BETA

concant.matrix <- data.frame(matrix(ncol = 9, nrow = length(score.matrix[,1]))) #working : following test.b above

for(i in 1:67108864){for(j in 1:9){concant.matrix[i,j] <- c(score.matrix[i,j])}} # testing not working

head(concant.matrix)

correlation.matrix <- data.frame(matrix(ncol = 1, nrow = length(score.matrix[,1]))) #working : following matrix.test above

for(i in 1:length(score.matrix[,1])){
  matrix.test[i,] <- cor(as.numeric(concant.matrix[i,]), as.vector(bed.test))
} #testing not working

head(matrix.test)

# Full Scale Parallel # BETA

install.packages("foreach") #parallel computing
library(foreach)

install.packages("parallel")
library(parallel)
detectCores() #detect no. of cores

install.packages("doSNOW") # install and register parallel backend
library(doSNOW)

cl<-makeCluster(cores[24]-1) #change the argument to your number of CPU cores. -1 core if you want (I recommend)
registerDoSNOW(cl)

test.b <- data.frame(matrix(ncol = 9, nrow = 4)) #Working : creates an empty dataframe to populate

foreach(i = 1:4) %dopar% {
  foreach(j = 1:9) %dopar%{
    test.b[i,j] <- c(score.matrix[i,j])
    }
  } # testing not working

stopCluster(cl) # stops the parallel cluster