#### TEST

raw.scores2 = matrix(c(1,2,3,4,5,6,7,8,9,10), nrow=1, ncol=10)


#Scale Raw Scores

scales <- matrix (c(1,20), nrow=1, ncol=2) 

# scales <- matrix( c(1, 1, 1, 1, 5, 10, 15, 20), nrow=4, ncol=2)

# Scale rows in raw.scores by weight.matrix

min = (scales[1,1])
max = (scales[1,2])

# Rescale

#ReScale10<- as.data.frame(rescale(raw.scores2, to=c(min, max)))

# Data test

my.data <- read.delim("H:/PhD Data/BSI/BSI 2013-14 Summer Scholarship/BSI Ruahines Scoring System/PhD/raw_data_for_r.txt", row.names=1, stringsAsFactors=FALSE)
#View(my.data)

my.data.rescaled <- as.data.frame(sapply(my.data, rescale, to = c(min, max)))

# Export data

write.table(my.data.rescaled, "H:/PhD Data/BSI/BSI 2013-14 Summer Scholarship/BSI Ruahines Scoring System/PhD/R matrices/Raw Data Scaled/1-20_scale.txt", sep="\t")