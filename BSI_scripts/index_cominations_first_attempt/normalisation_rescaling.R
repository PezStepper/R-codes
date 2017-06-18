### Min-Max Normalisation ###

# http://vitalflux.com/data-science-scale-normalize-numeric-data-using-r/

# Formula for normalisation is (X - min(X))/(max(X) - min(X))

# Age vector
age <- c(25, 35, 50)
# Salary vector
salary <- c(200000, 1200000, 2000000)
# Data frame created using age and salary
df <- data.frame( "Age" = age, "Salary" = salary, stringsAsFactors = FALSE)

print(df)

normalize <- function(x) {return ((x - min(x)) / (max(x) - min(x)))}

dfNorm <- as.data.frame(lapply(df, normalize))
# One could also use sequence such as df[1:2]
dfNorm <- as.data.frame(lapply(df[1:2], normalize))

print(dfNorm)

dfNormZ <- as.data.frame( scale(df[1:2] ))

print(dfNormZ)

# https://stackoverflow.com/questions/5468280/scale-a-series-between-two-points

library(scales)

#requires scales package

s = sort(rexp(100))

ReScale<- as.data.frame(rescale(s, to=c(0,10)))

# rescale expects a vector so will through an error when trying to apply to
# a data frame. To apply to data frame you need to iterate 

# https://stackoverflow.com/questions/42932568/error-standardising-variables-in-r-only-defined-on-a-data-frame-with-all-nume

dfReScale <- as.data.frame(sapply(df, rescale, to = c(1,10)))
