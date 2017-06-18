### Bed Stability Index scaling ###

# Test 

# raw data from BCI Scoring shannon index
raw.scores = matrix(c(2.12,	1.52,	2.14,	2.02,	1.89,
                      2.03,	2.1,	2.13,	1.76,	1.65), nrow=1, ncol=10)

# Rescale data to 1 to 10

ReScale<- as.data.frame(rescale(raw.scores, to=c(1,10)))

# Rescale data to adjustable min and max

min = 1
max = 20

ReScale2<- as.data.frame(rescale(raw.scores, to=c(min, max)))