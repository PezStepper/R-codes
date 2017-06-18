#############################################################################################################
## Creating a combination of all scores for each site                                                      ##
##                                                                                                         ##
## This code takes the file of scores from the Tamaki which have been scaled from 1 to 5,10,15, or 20     ##
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

# Tamaki

Tamaki.Scaled <- read.delim("H:/PhD Data/BSI/2013-14 Summer Scholarship/PhD/Corrected Field Data/Scale combinations for R/Tamaki Scale Combinations.txt", row.names=1, stringsAsFactors=FALSE)

View(Tamaki.Scaled)

#### Transpose the Vectors to have Parameters as columns ####

install.packages("optimbase")
library(optimbase)

as.matrix(Tamaki.Scaled) #convert data.frame to matrix

Tamaki.Scaled.T <- t(Tamaki.Scaled) #transpose the data so parameters are columns, scales are rows

View(Tamaki.Scaled.T)

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


parameter1 <- as.vector(Tamaki.Scaled.T[1:4,1])
parameter2 <- as.vector(Tamaki.Scaled.T[1:4,2])
parameter3 <- as.vector(Tamaki.Scaled.T[1:4,3])
parameter4 <- as.vector(Tamaki.Scaled.T[1:4,4])
parameter5 <- as.vector(Tamaki.Scaled.T[1:4,5])
parameter6 <- as.vector(Tamaki.Scaled.T[1:4,6])
#parameter7 <- as.vector(Tamaki.Scaled.T[1:4,7])
#parameter8 <- as.vector(Tamaki.Scaled.T[1:4,8])
#parameter9 <- as.vector(Tamaki.Scaled.T[1:4,9])
#parameter10 <- as.vector(Tamaki.Scaled.T[1:4,10])
parameter11 <- as.vector(Tamaki.Scaled.T[1:4,11])
parameter12 <- as.vector(Tamaki.Scaled.T[1:4,12])
parameter13 <- as.vector(Tamaki.Scaled.T[1:4,13])
parameter14 <- as.vector(Tamaki.Scaled.T[1:4,14])
parameter15 <- as.vector(Tamaki.Scaled.T[1:4,15])
parameter16 <- as.vector(Tamaki.Scaled.T[1:4,16])
parameter17 <- as.vector(Tamaki.Scaled.T[1:4,17])

#### Create Combinations ####

setwd("F:/Andrew BSI DATA") #output files too large for home drive so set to local HDD

Tamaki.combinations <- expand.grid(parameter1
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

png(file="Tamaki_scores_histogram.png")
hist(Tamaki.scores, main = "Tamaki Score Distribution", xlab = "Score")
dev.off()