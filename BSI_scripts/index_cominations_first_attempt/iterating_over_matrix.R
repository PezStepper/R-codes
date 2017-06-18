# Test

# https://www.r-bloggers.com/iterators-in-r/

x = expand.grid(1:4, 1:4, 1:4)

library(iterators)
library(foreach)


foreach(i = iter(x, by = "row"), .combine = c) %dopar% sum(i)