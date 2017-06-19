#############################################################################################################
## Creating a combination of all scores for each site                                                      ##
##                                                                                                         ##
## This code takes the file of scores from the Matanganui.Tributary which have been scaled from 1 to 5,10,15, or 20    ##
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

# Matanganui.Tributary

Matanganui.Tributary.Scaled <- read.delim("Matanganui Tributary Scale Combinations.txt", row.names=1, stringsAsFactors=FALSE)

View(Matanganui.Tributary.Scaled)

#### Transpose the Vectors to have Parameters as columns ####

#install.packages("optimbase")
#library(optimbase)

as.matrix(Matanganui.Tributary.Scaled) #convert data.frame to matrix

Matanganui.Tributary.Scaled.T <- t(Matanganui.Tributary.Scaled) #transpose the data so parameters are columns, scales are rows

View(Matanganui.Tributary.Scaled.T)

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


parameter1 <- as.vector(Matanganui.Tributary.Scaled.T[1:4,1])
parameter2 <- as.vector(Matanganui.Tributary.Scaled.T[1:4,2])
parameter3 <- as.vector(Matanganui.Tributary.Scaled.T[1:4,3])
parameter4 <- as.vector(Matanganui.Tributary.Scaled.T[1:4,4])
parameter5 <- as.vector(Matanganui.Tributary.Scaled.T[1:4,5])
parameter6 <- as.vector(Matanganui.Tributary.Scaled.T[1:4,6])
parameter7 <- as.vector(Matanganui.Tributary.Scaled.T[1:4,7])
parameter8 <- as.vector(Matanganui.Tributary.Scaled.T[1:4,8])
parameter9 <- as.vector(Matanganui.Tributary.Scaled.T[1:4,9])

#### Create Combinations ####

setwd("F:/Andrew BSI DATA") #output files too large for home drive so set to local HDD

Matanganui.Tributary.combinations <- expand.grid(parameter1
                                     , parameter2
                                     , parameter3
                                     , parameter4
                                     , parameter5
                                     , parameter6
                                     , parameter7
                                     , parameter8
                                     , parameter9
)


object.size(Matanganui.Tributary.combinations)

head(Matanganui.Tributary.combinations)

#### Export Data ####

write.table(Matanganui.Tributary.combinations, file="Matanganui_Tributary_combinations.txt", sep="\t")

#### Sum rows ####

Matanganui.Tributary.scores <- as.matrix(rowSums(Matanganui.Tributary.combinations))

object.size(Matanganui.Tributary.scores)

head(Matanganui.Tributary.scores)

write.table(Matanganui.Tributary.scores, file="Matanganui_Tributary_scores_test.txt", sep="\t") #assumes we are saving tot he working directory

#### Plotting Data ####

hist(Matanganui.Tributary.scores, main = "Matanganui Tributary Score Distribution", xlab = "Score")

png(file="Matanganui_Tributary_scores_histogram.png")
hist(Matanganui.Tributary.scores, main = "Matanganui Tributary Score Distribution", xlab = "Score")
dev.off()