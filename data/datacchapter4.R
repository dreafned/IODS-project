#Datasets inside R

# access the MASS package
library(MASS)
library(corrplot)
library(tidyverse)
# load the data
data("Boston")

# explore the dataset
str(Boston)
summary(Boston)

# plot matrix of the variables

pairs(Boston)

#Correlations plot

# MASS, corrplot, tidyverse and Boston dataset are available

# calculate the correlation matrix and round it
cor_matrix<-cor(Boston) %>% round(2)

# print the correlation matrix
cor_matrix

# visualize the correlation matrix
corrplot(cor_matrix, method="circle", type = "upper",cl.pos = "b", tl.pos = "d", tl.cex = 0.6)

#Scale the whole dataset

# MASS and Boston dataset are available

# center and standardize variables
boston_scaled <- scale(Boston)

# summaries of the scaled variables
summary(boston_scaled)

# class of the boston_scaled object
class(boston_scaled)

# change the object to data frame

boston_scaled <- as.data.frame(boston_scaled)

class(boston_scaled)

#Creating a factor variable

# MASS, Boston and boston_scaled are available

# summary of the scaled crime rate

summary(Boston$crim)
# create a quantile vector of crim and print it
bins <- quantile(boston_scaled$crim)
bins

# create a categorical variable 'crime'
crime <- cut(boston_scaled$crim, breaks = bins, include.lowest = TRUE, label = c("low","med_low","med_high","high"))

# look at the table of the new factor crime
table(crime)

# remove original crim from the dataset
boston_scaled <- dplyr::select(boston_scaled, -crim)

# add the new categorical value to scaled data
boston_scaled <- data.frame(boston_scaled, crime)

#Divide and conquer: train and test sets

# boston_scaled is available

# number of rows in the Boston dataset 
n <- nrow(boston_scaled)

# choose randomly 80% of the rows
ind <- sample(n,  size = n * 0.8)

# create train set
train <- boston_scaled[ind,]

# create test set 
test <- boston_scaled[-ind,]

# save the correct classes from test data
correct_classes <- test$crime

# remove the crime variable from test data
test <- dplyr::select(test, -crime)

# Linear Discriminant analysis

# MASS and train are available

# linear discriminant analysis
lda.fit <- lda(crime ~., data = train)

# print the lda.fit object
lda.fit

# the function for lda biplot arrows
lda.arrows <- function(x, myscale = 1, arrow_heads = 0.1, color = "red", tex = 0.75, choices = c(1,2)){
  heads <- coef(x)
  arrows(x0 = 0, y0 = 0, 
         x1 = myscale * heads[,choices[1]], 
         y1 = myscale * heads[,choices[2]], col=color, length = arrow_heads)
  text(myscale * heads[,choices], labels = row.names(heads), 
       cex = tex, col=color, pos=3)
}

# target classes as numeric
classes <- as.numeric(train$crime)

# plot the lda results
plot(lda.fit, dimen = 2, col = classes,pch = classes)
lda.arrows(lda.fit, myscale = 5)

#Predict LDA

# lda.fit, correct_classes and test are available

# predict classes with test data
lda.pred <- predict(lda.fit, newdata = test)

# cross tabulate the results
table(correct = correct_classes, predicted = lda.pred$class)

#Towards clustering: distance measures

# load MASS and Boston
library(MASS)
data('Boston')

# euclidean distance matrix
dist_eu <- dist(Boston)

# look at the summary of the distances
summary(dist_eu)

# manhattan distance matrix
dist_man <- dist(Boston, method = "manhattan")

# look at the summary of the distances
summary(dist_man)

#K-means clustering

# Boston dataset is available

# k-means clustering
km <-kmeans(Boston, centers = 3)

# plot the Boston dataset with clusters
pairs(Boston, col = km$cluster)

#K-means: determine the k
# MASS, ggplot2 and Boston dataset are available
set.seed(123)

# determine the number of clusters
k_max <- 10

# calculate the total within sum of squares
twcss <- sapply(1:k_max, function(k){kmeans(Boston, k)$tot.withinss})

# visualize the results
qplot(x = 1:k_max, y = twcss, geom = 'line')

# k-means clustering
km <-kmeans(Boston, centers = 2)

# plot the Boston dataset with clusters
pairs(Boston, col = km$cluster)








