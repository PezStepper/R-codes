#############################################################################################################
## Creating a combination of all scores for each site                                                      ##
##                                                                                                         ##
## This code takes the file of scores from the Tamaki which have been scaled from 1 to 5,10,15, or 20    ##
## and creates a vector of each weighting, then creates a combination of all scores by mixing different    ##
## weightings for each parameter. The scores for each index combination are then summed to produce all     ##
## possible scores. These should be combined with other sites to find the best predictor                   ##
##                                                                                                         ##
## Scirpt v1.1 Created By A.Neverman 19/05/2017                                                            ##
##                                                                                                         ##
## This version has been adjusted for the reduced index                                                    ##
#############################################################################################################


#### Set Working Directory ####

setwd("H:/PhD Data/BSI/2013-14 Summer Scholarship/PhD/Corrected Field Data/Revised/Scale Cominations (revised)")

#### Import Data ####

# Tamaki

Tamaki.Scaled <- read.delim("Tamaki Scale Combinations.txt", row.names=1, stringsAsFactors=FALSE)

View(Tamaki.Scaled)

#### Transpose the Vectors to have Parameters as columns ####

#install.packages("optimbase")
#library(optimbase)

as.matrix(Tamaki.Scaled) #convert data.frame to matrix

Tamaki.Scaled.T <- t(Tamaki.Scaled) #transpose the data so parameters are columns, scales are rows

View(Tamaki.Scaled.T)

#### Vectors of weighted scores ####

# Assumes file has parameters as columns, and weightings as rows

# parameter1 = Bed Compaction 
# parameter2 = Develpoment of geomorphic units 
# parameter3 = Bed Homogeneity
# parameter4 = Water Surface Slope
# parameter5 = Hydraulic radius
# parameter6 = Width:Depth
# parameter7 = Channel Bedform Clusters
# parameter8 = Degree of Mortaring
# parameter9 = Active Channel Width vs. Wetted Channel Width


parameter1 <- as.vector(Tamaki.Scaled.T[1:4,1])
parameter2 <- as.vector(Tamaki.Scaled.T[1:4,2])
parameter3 <- as.vector(Tamaki.Scaled.T[1:4,3])
parameter4 <- as.vector(Tamaki.Scaled.T[1:4,4])
parameter5 <- as.vector(Tamaki.Scaled.T[1:4,5])
parameter6 <- as.vector(Tamaki.Scaled.T[1:4,6])
parameter7 <- as.vector(Tamaki.Scaled.T[1:4,7])
parameter8 <- as.vector(Tamaki.Scaled.T[1:4,8])
parameter9 <- as.vector(Tamaki.Scaled.T[1:4,9])

#### Create Combinations ####

setwd("F:/Andrew BSI DATA") #output files too large for home drive so set to local HDD

Tamaki.combinations <- expand.grid(parameter1
                                     , parameter2
                                     , parameter3
                                     , parameter4
                                     , parameter5
                                     , parameter6
                                     , parameter7
                                     , parameter8
                                     , parameter9
)


object.size(Tamaki.combinations)

head(Tamaki.combinations)

#### Export Data ####

write.table(Tamaki.combinations, file="Tamaki_combinations.txt", sep="\t")

#### Sum rows ####

Tamaki.scores <- as.matrix(rowSums(Tamaki.combinations))

object.size(Tamaki.scores)

head(Tamaki.scores)

write.table(Tamaki.scores, file="Tamaki_scores_test.txt", sep="\t") #assumes we are saving tot he working directory

#### Plotting Data ####

hist(Tamaki.scores, main = "Tamaki Score Distribution", xlab = "Score")

png(file="Tamaki_scores_histogram.png")
hist(Tamaki.scores, main = "Tamaki Score Distribution", xlab = "Score")
dev.off()