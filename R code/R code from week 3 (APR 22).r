# Lecture 22 APR 2024 -----------------------------------------------------
# library(tidyverse)
library(readr)
library(psych)

# Data types
log <- TRUE
int <- 1L
dbl <- 1.0
cpx <- 1+0i
chr <- "one"
nan <- NaN
inf <- Inf
ninf <- -Inf
mis <- NA
ntype <- NULL

# Data type exercises
# = is for assignment; == is for equality
log == int
int == dbl 
dbl == cpx 
cpx == chr 
chr == nan 
nan == inf 
inf == ninf
ninf == mis
mis == ntype

5L + 2 
3.7 * 3L
99999.0e-1 - 3.3e+3
10 / as.complex(2)
as.character(5) / 5

# Removing from the environment
x <- "bad"
rm(x)

# Moses illusion data
moses <- read_csv("moses.csv")
moses
print(moses)
print(moses, n=Inf)
View(moses)
head(moses)
head(as.data.frame(moses))
tail(as.data.frame(moses), n = 20)
spec(moses)
summary(moses)
describe(moses)
colnames(moses)

# Functions
print(1:10)
set.seed(123) # This makes sure you get the same random result every time
dbinom(x = 6, size = 9, prob = 0.5)
dbinom(6, 9, 0.5)
dbinom(prob = 0.5, size = 9, x = 6)
dbinom(0.5, 9, 6)
dbinom(6, 9, prob = 0.5)
dbinom(x = 6, 9, prob = 0.5)

# Clean up data
select(moses, c(ITEM, CONDITION, Value, 
                MD5.hash.of.participant.s.IP.address,
                Label, Parameter))
na.omit(moses)
filter(moses, Parameter == "Final")
arrange(moses, ITEM)
rename(moses, ID = MD5.hash.of.participant.s.IP.address)

# Noisy channel data
# FIXME your turn!

# Session information
sessionInfo()
