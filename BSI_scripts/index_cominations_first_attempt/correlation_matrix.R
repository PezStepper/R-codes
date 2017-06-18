# https://cran.r-project.org/web/packages/corrgram/corrgram.pdf
# https://cran.r-project.org/web/packages/corrgram/index.html


setwd("H:/PhD Data/BSI/2013-14 Summer Scholarship/PhD")

mydata <- read.delim("field_data_movement_combined.txt", row.names = 1)

# https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html

install.packages("corrgram")
library(corrgram)

cor(mydata)

corrgram(mydata, lower.panel=panel.shade, upper.panel=panel.cor)