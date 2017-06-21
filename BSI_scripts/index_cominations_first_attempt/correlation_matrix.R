# https://cran.r-project.org/web/packages/corrgram/corrgram.pdf
# https://cran.r-project.org/web/packages/corrgram/index.html


setwd("H:/PhD Data/BSI/2013-14 Summer Scholarship/PhD")

mydata <- read.delim("field_data_movement_combined.txt", row.names = 1)

mydata2 <- data.frame(mydata$Bed.Compaction, mydata$Develpoment.of.geomorphic.units
            ,mydata$Bed.Homogeneity, mydata$Water.Surface.Slope, mydata$Width.Depth, mydata$Channel.Bedform.Clusters
            , mydata$Degree.of.Mortaring, mydata$Active.Channel.Width.vs..Wetted.Channel.Width
            , mydata$Bed.Movement....)

# https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html

install.packages("corrgram")
library(corrgram)

cor(mydata2)

corrgram(mydata2, lower.panel=panel.shade, upper.panel=panel.cor)

# P values

install.packages("Hmisc")
library(Hmisc)

cor <- rcorr(as.matrix(mydata), type="pearson")

# cor$r shows the correlation matrix, cor$p the matrix with corresponding p-values.

cor$r

cor$p

install.packages("psych")
library(psych)

cor.test(mydata$Bed.Compaction, mydata$Bed.Movement....)