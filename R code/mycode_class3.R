library(tidyverse)
library(psych)

moses <- read_csv("moses.csv")
moses
print(moses)
print(moses, n=Inf)
View(moses) #same as clicking on the icon
head(moses)
head(as.data.frame(moses))
tail(as.data.frame(moses), n = 20)
spec(moses)
summary(moses)
describe(moses)
colnames(moses)
head(moses, n=20)
#dbinom(x=6,size=9,prob=0.5)

print(1:10)
set.seed(123) # This makes sure you get the same random result every time
dbinom(x = 6, size = 9, prob = 0.5)
dbinom(6, 9, 0.5)
dbinom(prob = 0.5, size = 9, x = 6)
dbinom(0.5, 9, 6)
dbinom(6, 9, prob = 0.5)
dbinom(x = 6, 9, prob = 0.5)