### Creating a matrix of all combinations of a sequence ###
### (i.e. index weighting combinations) ###
### and multiplying by a vector (i.e. raw data) ###

# Last Edited 13/06/2017 to test method for BSI weighting #

#### Examples #### 

# Creating a matrix of all combinations 
# See http://fluvialgeomorphologyadventures.blogspot.co.nz/2017/06/r-create-matrix-with-all-combinations.html

# Create a matrix of a variable with 3 variables whose values can be 1, 2, 3, or 4

x = expand.grid(1:4, 1:4, 1:4)

# Here we have variables Height, Weight, and Sex, and a matrix of their combinations

# We use seq() to give min value, max value, and increment.i.e 60, 70, 80

# Can use c() to give exact numbers ie c(60, 70, 80) 
# or c(63, 72, 93, 108) if not a sequence

expand.grid(height = seq(60, 80, 10), weight = seq(100, 200, 50),
            sex = c("Male","Female")) #sequence is in structure seq(min value, max value, step)

# Here we create the matrix of weights for the BCI. Weights can be 5, 10, 15, 20

weight.matrix = expand.grid( variable1 = seq(5, 20, 5),
variable2 = seq(5, 20, 5),
variable3 = seq(5, 20, 5),
variable4 = seq(5, 20, 5),
variable5 = seq(5, 20, 5),
variable6 = seq(5, 20, 5),
variable7 = seq(5, 20, 5),
variable8 = seq(5, 20, 5),
variable9 = seq(5, 20, 5),
variable10 = seq(5, 20, 5)
)

# Here we create a vector of scores for the 10 variables. These scores
# would represnt the raw data for each of the variables int he index

raw.scores = matrix(c(1,2,3,4,5,6,7,8,9,10), nrow=1, ncol=10)

# We use the sweep function to multiply each row of the matrix by the vector
# In effect this is trying all possible combinations of the index
# See http://fluvialgeomorphologyadventures.blogspot.co.nz/2017/06/r-multiply-matrix-rows-or-columns-by.html

swept = sweep(weight.matrix, 2, raw.scores, `*`) # in the form (matrix, 1 or 2 for column or row respectively, vector, function)
