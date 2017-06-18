#############################################################################################################
## Creating a combination of all scores for each site                                                      ##
##                                                                                                         ##
## This code takes the file of scores from the Limestone which have been scaled from 1 to 5,10,15, or 20     ##
## and creates a vector of each weighting, then creates a combination of all scores by mixing different    ##
## weightings for each parameter. The scores for each index combination are then summed to produce all     ##
## possible scores. These should be combined with other sites to find the best predictor                   ##
##                                                                                                         ##
## Scirpt v1.0 Created By A.Neverman 16/05/2017                                                            ##
##                                                                                                         ##
#############################################################################################################


#### Set Working Directory ####

setwd("H:/PhD Data/BSI/2013-14 Summer Scholarship/PhD/Corrected Field Data/Scale combinations for R")

#### Import Data ####

# Limestone

Limestone.Scaled <- read.delim("H:/PhD Data/BSI/2013-14 Summer Scholarship/PhD/Corrected Field Data/Scale combinations for R/Limestone Creek Scale Combinations.txt", row.names=1, stringsAsFactors=FALSE)

View(Limestone.Scaled)

#### Transpose the Vectors to have Parameters as columns ####

install.packages("optimbase")
library(optimbase)

as.matrix(Limestone.Scaled) #convert data.frame to matrix

Limestone.Scaled.T <- t(Limestone.Scaled) #transpose the data so parameters are columns, scales are rows

View(Limestone.Scaled.T)

#### Vectors of weighted scores ####

# Assumes file has parameters as columns, and weightings as rows

# parameter1 = Bed Compaction 
# parameter2 = Develpoment of geomorphic units 
# parameter3 = Reworking of the active bed/banks
# parameter4 = Clast Size Distribution (D16-D84)
# parameter5 = Bed Homogeneity
# parameter6 = Bar development
# parameter7 = Bar Vegetation
# parameter8 =  Growth - Slime
# parameter9 = Macrophyte Growth - Weeds
# parameter10 = Bryophyte Growth - Moss
# parameter11 = Water Surface Slope
# parameter12 = Hydraulic radius
# parameter13 = Width:Depth
# parameter14 = Channel Bedform Clusters
# parameter15 = Shannon Index
# parameter16 = Degree of Mortaring
# parameter17 = Active Channel Width vs. Wetted Channel Width


parameter1 <- as.vector(Limestone.Scaled.T[1:4,1])
parameter2 <- as.vector(Limestone.Scaled.T[1:4,2])
parameter3 <- as.vector(Limestone.Scaled.T[1:4,3])
parameter4 <- as.vector(Limestone.Scaled.T[1:4,4])
parameter5 <- as.vector(Limestone.Scaled.T[1:4,5])
parameter6 <- as.vector(Limestone.Scaled.T[1:4,6])
#parameter7 <- as.vector(Limestone.Scaled.T[1:4,7])
#parameter8 <- as.vector(Limestone.Scaled.T[1:4,8])
#parameter9 <- as.vector(Limestone.Scaled.T[1:4,9])
#parameter10 <- as.vector(Limestone.Scaled.T[1:4,10])
parameter11 <- as.vector(Limestone.Scaled.T[1:4,11])
parameter12 <- as.vector(Limestone.Scaled.T[1:4,12])
parameter13 <- as.vector(Limestone.Scaled.T[1:4,13])
parameter14 <- as.vector(Limestone.Scaled.T[1:4,14])
parameter15 <- as.vector(Limestone.Scaled.T[1:4,15])
parameter16 <- as.vector(Limestone.Scaled.T[1:4,16])
parameter17 <- as.vector(Limestone.Scaled.T[1:4,17])

#### Create Combinations ####

setwd("F:/Andrew BSI DATA") #output files too large for home drive so set to local HDD

Limestone.combinations <- expand.grid(parameter1
                                    , parameter2
                                    , parameter3
                                    , parameter4
                                    , parameter5
                                    , parameter6
                                    #, parameter7 - excluding from the index
                                    #, parameter8 - excluding from the index
                                    #, parameter9 - excluding from the index
                                    #, parameter10 - excluding from the index
                                    , parameter11
                                    , parameter12
                                    , parameter13
                                    , parameter14
                                    , parameter15
                                    , parameter16
                                    ,parameter17
)


object.size(Limestone.combinations)

head(Limestone.combinations)

#### Export Data ####

write.table(Limestone.combinations, file="Limestone_combinations.txt", sep="\t")

#### Sum rows ####

Limestone.scores <- as.matrix(rowSums(Limestone.combinations))

object.size(Limestone.scores)

head(Limestone.scores)

write.table(Limestone.scores, file="Limestone_scores_test.txt", sep="\t") #assumes we are saving tot he working directory

#### Plotting Data ####

png(file="Limestone_scores_histogram.png")
hist(Limestone.scores, main = "Limestone Score Distribution", xlab = "Score")
dev.off()