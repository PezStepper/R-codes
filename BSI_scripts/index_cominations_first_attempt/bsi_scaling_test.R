### Bed Stability Index scaling ###

### WORKING SCRIPT ####


# raw data from BCI Scoring shannon index
raw.scores = matrix(c(2.12,	1.52,	2.14,	2.02,	1.89,
                      2.03,	2.1,	2.13,	1.76,	1.65), nrow=1, ncol=10)

# Rescale data to 1 to 10. NB Rescales by Column

ReScale<- as.data.frame(rescale(raw.scores, to=c(1,10)))

# Rescale data to adjustable min and max

min = 1 
max = 20 #change to max weight

ReScale2<- as.data.frame(rescale(raw.scores, to=c(min, max)))

# Adjust scores to nearest 0.5



#### Trial on Ruahine Raw Data ####

# Import Data

my.data <- read.delim("H:/PhD Data/BSI/BSI 2013-14 Summer Scholarship/BSI Ruahines Scoring System/raw_data_for_r.txt", row.names=1, stringsAsFactors=FALSE)
View(my.data)

my.data.rescaled <- as.data.frame(sapply(my.data, rescale, to = c(1,10)))

# Summing the columns or rows. NEED TO WATCH FOR ROUNDING

colSums(my.data.rescaled)

colSums(my.data)

rowSums <- as.data.frame(rowSums(my.data.rescaled))

#### Applying index to data ####

# I have scaled the data 1 - 10 

