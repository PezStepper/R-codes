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

Manawatu <- read.delim(file="Manawatu_scores.txt", header = TRUE)
Ngamoko <- read.delim(file="Ngamoko_scores.txt", header = TRUE)
Coppermine <- read.delim(file="Coppermine_scores.txt", header = TRUE)
Mangapuaka <- read.delim(file="Mangapuaka_scores.txt", header = TRUE)
Tamaki <- read.delim(file="Tamaki_scores.txt", header = TRUE)
Mangatautou <- read.delim(file="Mangatautou_scores.txt", header = TRUE)
Matanganui <- read.delim(file="Matanganui_scores.txt", header = TRUE)
Matanganui.Tributary <- read.delim(file="Matanganui_Tributary_scores.txt", header = TRUE)
Limestone <- read.delim(file="Limestone_scores.txt", header = TRUE)
Coal <- read.delim(file="Coal_scores.txt", header = TRUE)

bed.movement <- read.delim(file= "H:/PhD Data/BSI/2013-14 Summer Scholarship/PhD/bed_movement.txt", header = TRUE, row.names = 1)

#### Merge vectors to a matrix ####

# REMEBER TO LEAVE SOME VALIDATION SITES OUT

# I will leave Limestone creek out as it's the only site without extremes needed to set scaling

# Create a matrix of all the possible scores for each site

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

#install.packages("optimbase")
#library(optimbase)

as.data.frame(bed.movement) #convert data.frame to matrix

bed.movement.T <- t(bed.movement[-9,]) #transpose the data, and drop column 9 (Limestone Creek)

View(bed.movement.T)


#### Correlation ####

#https://stat.ethz.ch/pipermail/r-help//2009-November/409838.html

# Needed to concantenate the data as it was reading in as a list rather than numeric data.

concant.matrix <- data.frame(matrix(ncol = 9, nrow = length(score.matrix[,1]))) #creates emptp matrix with 9 columns for 9 sites 
#and rows equal to total possible score combinations

# Now we will loop through the score matrix and concantenate each row and put it in the concant matrix. Note this can be modified for parallel processing.

for(i in 1:length(score.matrix[,1])){ #for each row
  for(j in 1:9){ #for each site
    concant.matrix[i,j] <- c(score.matrix[i,j])
    }
  } 

head(concant.matrix) #shows the first few rows of data. Use to manually validate process worked

tail(concant.matrix) # Shows the last few rows

write.table(concant.matrix, file="all_sites_scores_matrix.txt", sep="\t") #output thes the matrix

correlation.matrix <- data.frame(matrix(ncol = 1, nrow = length(score.matrix[,1]))) #creates an empty dataframe to store the
#correlations of each score combination vs bed movement data. This data will be used to find the highest correlation achieved
#and trace back using th rw number to find the combinations of parameter weightings used

bed.concant <- c(bed.movement.T)

# Now we will loop through and do the correlation on each row. Note this can be modified for parallel processing.

for(i in 1:length(score.matrix[,1])){
  correlation.matrix[i,] <- cor(as.numeric(concant.matrix[i,]), as.vector(bed.concant))
} 

head(correlation.matrix)

tail(correlation.matrix)

write.table(correlation.matrix, file="correlation_matrix.txt", sep="\t")

max(correlation.matrix) # Find the max correlation in the 1 row

which.max(correlation.matrix[,1]) # Find the column number which contains the max correlation