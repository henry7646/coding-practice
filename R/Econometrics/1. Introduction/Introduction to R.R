getwd()
setwd("C:/R/Econometrics/1. Introduction/")
.libPaths()
rm(list=ls())

library(data.table)
library(xlsx)
library(dplyr)
library(tidyverse)
library(ggplot2)

# Read the data
mydata<-fread("C:/R/Econometrics/1. Introduction/intro_auto.csv")

# List the variables
names(mydata)

# Show first lines of data
head(mydata)
mydata[1:10,]

#Descriptive statistics
summary(mydata$mpg)
sd(mydata$mpg)
length(mydata$mpg)
summary(mydata$price)
sd(mydata$price)


