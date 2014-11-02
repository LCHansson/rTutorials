## Commands using base-R (mostly) for data investigation
# The following datasets are used in this script:
# - iris (base)
# - airquality (base)

## Inspection ----
str(letters)
str(iris$Species)
str(iris)

head(iris)
tail(iris, n = 3)

## Summarization ----
# summary() can be used to describe vectors...
summary(letters)
summary(iris$Species)
summary(iris$Sepal.Length)

# ...and used on tabular data it spits out one summary per column
summary(iris)


## Aggregation ----
# Use aggregate() for quick summarization of data.
# This function can use the formula() object. This is a slightly more complex way of
# looking at data, but can be a very efficient tool to gain slightly more complex
# insights on the nature of data.
aggregate(. ~ Species, data = iris, FUN = mean)
aggregate(. ~ Month, data = airquality, FUN = sum)

# Frequency tables of vectors or data frames can be done using table().
table(Nile)

# Note: DO NOT pass an entire data frame with many variables to table() since
# this will cause it to tabulate all possible combinations of variables in the
# data set. If you really want to try it to obtain a better understanding of how
# table() works, make sure to try it on a really small dataset, like table(cars).
table(iris[,c("Species", "Petal.Width")])
with(iris, table(Species, Large.Petals = Petal.Width > 1.5))
with(iris, table(Species, Large.Petals = Petal.Width > 1.5, Large.Sepals = Sepal.Width > 3))

# table() returns an object that can be used as input in other functions, like
# prop.table() to return a list of proportions.
myTable <- with(iris, table(Species, Large.Petals = Petal.Width > 1.5))
prop.table(myTable)
# If we want frequencies to su up only row or column wise, we can pass a 1 (for
# rows) or 2 (columns) as an additional argument to prop.table()
prop.table(myTable, 1)
prop.table(myTable, 2)


## Handling missing values ----
# Sometimes data will have NA values in it
summary(airquality$Solar.R)
# We can locate the positions of NA values using which()...
which(is.na(airquality$Solar.R))
# ...and print the values using this as an input
airquality[which(is.na(airquality$Solar.R)),]

# Missing values can be handled in several ways. We can remove them from a vector...
myVec <- airquality$Solar.R
length(myVec)
myVec <- myVec[!is.na(myVec)]
length(myVec)

# ...or from a data frame...
myDF <- airquality
dim(myDF)
myDF <- myDF[!is.na(airquality$Solar.R),]
dim(myDF)

# More importantly, we can also impute missing values.
myDF <- airquality
require(Hmisc)
myDF$Solar.R <- impute(myDF$Solar.R, fun = median)

