#############################################################################################################
## Creating a combination of all scores for each site                                                      ##
##                                                                                                         ##
## This code takes the file of scores from the Limestone which have been scaled from 1 to 5,10,15, or 20    ##
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

# Limestone

Limestone.Scaled <- read.delim("Limestone Scale Combinations.txt", row.names=1, stringsAsFactors=FALSE)

View(Limestone.Scaled)

#### Transpose the Vectors to have Parameters as columns ####

#install.packages("optimbase")
#library(optimbase)

as.matrix(Limestone.Scaled) #convert data.frame to matrix

Limestone.Scaled.T <- t(Limestone.Scaled) #transpose the data so parameters are columns, scales are rows

View(Limestone.Scaled.T)

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


parameter1 <- as.vector(Limestone.Scaled.T[1:4,1])
parameter2 <- as.vector(Limestone.Scaled.T[1:4,2])
parameter3 <- as.vector(Limestone.Scaled.T[1:4,3])
parameter4 <- as.vector(Limestone.Scaled.T[1:4,4])
parameter5 <- as.vector(Limestone.Scaled.T[1:4,5])
parameter6 <- as.vector(Limestone.Scaled.T[1:4,6])
parameter7 <- as.vector(Limestone.Scaled.T[1:4,7])
parameter8 <- as.vector(Limestone.Scaled.T[1:4,8])
parameter9 <- as.vector(Limestone.Scaled.T[1:4,9])

#### Create Combinations ####

setwd("F:/Andrew BSI DATA") #output files too large for home drive so set to local HDD

Limestone.combinations <- expand.grid(parameter1
                                     , parameter2
                                     , parameter3
                                     , parameter4
                                     , parameter5
                                     , parameter6
                                     , parameter7
                                     , parameter8
                                     , parameter9
)


object.size(Limestone.combinations)

head(Limestone.combinations)

#### Export Data ####

write.table(Limestone.combinations, file="Limestone_combinations.txt", sep="\t")

#### Sum rows ####

Limestone.scores <- as.matrix(rowSums(Limestone.combinations))

object.size(Limestone.scores)

head(Limestone.scores)

write.table(Limestone.scores, file="Limestone_scores.txt", sep="\t") #assumes we are saving tot he working directory

#### Plotting Data ####

hist(Limestone.scores, main = "Limestone Score Distribution", xlab = "Score")

png(file="Limestone_scores_histogram.png")
hist(Limestone.scores, main = "Limestone Score Distribution", xlab = "Score")
dev.off()