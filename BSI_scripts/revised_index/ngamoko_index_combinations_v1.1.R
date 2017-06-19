#############################################################################################################
## Creating a combination of all scores for each site                                                      ##
##                                                                                                         ##
## This code takes the file of scores from the Ngamoko which have been scaled from 1 to 5,10,15, or 20    ##
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

# Ngamoko

Ngamoko.Scaled <- read.delim("Ngamoko Scale Combinations.txt", row.names=1, stringsAsFactors=FALSE)

View(Ngamoko.Scaled)

#### Transpose the Vectors to have Parameters as columns ####

#install.packages("optimbase")
#library(optimbase)

as.matrix(Ngamoko.Scaled) #convert data.frame to matrix

Ngamoko.Scaled.T <- t(Ngamoko.Scaled) #transpose the data so parameters are columns, scales are rows

View(Ngamoko.Scaled.T)

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


parameter1 <- as.vector(Ngamoko.Scaled.T[1:4,1])
parameter2 <- as.vector(Ngamoko.Scaled.T[1:4,2])
parameter3 <- as.vector(Ngamoko.Scaled.T[1:4,3])
parameter4 <- as.vector(Ngamoko.Scaled.T[1:4,4])
parameter5 <- as.vector(Ngamoko.Scaled.T[1:4,5])
parameter6 <- as.vector(Ngamoko.Scaled.T[1:4,6])
parameter7 <- as.vector(Ngamoko.Scaled.T[1:4,7])
parameter8 <- as.vector(Ngamoko.Scaled.T[1:4,8])
parameter9 <- as.vector(Ngamoko.Scaled.T[1:4,9])

#### Create Combinations ####

setwd("F:/Andrew BSI DATA") #output files too large for home drive so set to local HDD

Ngamoko.combinations <- expand.grid(parameter1
                                     , parameter2
                                     , parameter3
                                     , parameter4
                                     , parameter5
                                     , parameter6
                                     , parameter7
                                     , parameter8
                                     , parameter9
)


object.size(Ngamoko.combinations)

head(Ngamoko.combinations)

#### Export Data ####

write.table(Ngamoko.combinations, file="Ngamoko_combinations.txt", sep="\t")

#### Sum rows ####

Ngamoko.scores <- as.matrix(rowSums(Ngamoko.combinations))

object.size(Ngamoko.scores)

head(Ngamoko.scores)

write.table(Ngamoko.scores, file="Ngamoko_scores_test.txt", sep="\t") #assumes we are saving tot he working directory

#### Plotting Data ####

hist(Ngamoko.scores, main = "Ngamoko Score Distribution", xlab = "Score")

png(file="Ngamoko_scores_histogram.png")
hist(Ngamoko.scores, main = "Ngamoko Score Distribution", xlab = "Score")
dev.off()