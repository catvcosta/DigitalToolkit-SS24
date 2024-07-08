library(tidyverse)
library(psych)

# Exercise 1. Data types
  
typeof("Anna") # "character"
typeof(-10) # "double"
typeof(FALSE) # "logical"
typeof(3.14) # "double"
typeof(as.logical(1)) # "logical"

# Exercise 2. True or False?
  
7+0i == 7 # TRUE
9 == 9.0 # TRUE
"zero" == 0L # FALSE
"cat" == "cat" # TRUE
TRUE == 1 # TRUE

# Exercise 3. Output of the operations and explanation
  
10 < 1 # FALSE. Well, 10 is bigger than 1!
5 != 4 # TRUE. 5 is different than 4
5 - FALSE # 5. Since TRUE == 1, FALSE == 0(?), then 5-0=5
1.0 == 1 # TRUE, doubles and ints are equivalent. However, typeof(1) is "double"(?)
4 *9.1 # 36.4, regular multiplication
"a" + 1 # Error: no numeric value assigned to a, so can't add a string and a number
0/0 # NaN: this operation is not mathematically defined
b* 2 # Error: object 'b' not found: again, error because no value is assigned to a variable b
(1-2)/0 # -Inf: is.infinite((1-2)/0) is TRUE, R represents infinite numbers using Inf or -Inf 
10 <- 20 # Error since 10 is an invalid name for a variable
NA == NA # NA: NA is an indicator of missingness. NA is identical to NA, but doesn't equal it
-Inf == NA # NA: not totally sure about this one, I would suspect it to be FALSE


# Exercise 4. noisy.csv, what to keep and what to discard

noisy <- read_csv("noisy.csv")
head(as.data.frame(noisy), n = 20)
spec(noisy)
summary(noisy)
describe(noisy)
colnames(noisy)

# It's hard to know exactly what is important without a task, but from this quick analysis, I would keep:
# 10. Parameter
# 11. Value
# 16. ITEM
# 17. CONDITION
# 19. Reading.time
# 20. Newline. (and maybe filter out all the NA's)
# 21. Sentence..or.sentence.MD5.
# I don't think any of the other columns is very useful. But I'm not sure :)