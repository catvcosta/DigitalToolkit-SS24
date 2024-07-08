library(tidyverse)
library(psych)

moses <- read_csv("moses.csv")
colnames(moses)
ren_moses <- rename(moses, ID = MD5.hash.of.participant.s.IP.address, ANSWER = Value)
new_moses <- select(ren_moses, ID, ITEM, CONDITION, ANSWER, Label, Parameter)
moses.na <- na.omit(new_moses)
moses.filter <- filter(moses.na, Parameter == "Final", Label != "instructions", CONDITION %in% 1:2)
moses.sort <- arrange(moses.filter, ITEM, CONDITION, desc(ANSWER))
# ITEM | ITEM, CONDITION | desc(ID) | desc(is.na(ANSWER)) 

install.packages('esquisse')
library(esquisse)

mutation_moses <- mutate(moses.sort, ITEM = as.numeric(ITEM))

moses_uniq <- unique(select(filter(mutation_moses, ITEM == 2), ANSWER))

# VALUE %in% DATA
# filter(moses, CONDITION == 1)
# filter(moses, CONTIDTION %in% 1)
# CONDITION >=1 & CONDITION <2
# CONDITION == 1| CONDITION == 2 -> conditions 1-2
# CONDITION %in% 1:2 "

# mutate(moses, CLASS = TRUE)
# mutate(moses, NUMBER = 1:598)