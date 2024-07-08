# Catarina Costa, assignment 4

library(tidyverse)
##### library(psych)
##### library(dplyr)

##  Read and preprocess the new Moses illusion data (moses_clean.csv).

moses <- read_csv('moses_clean.csv')
questions <- read.csv('questions.csv')
cleaned_moses <- moses |>
  inner_join(questions, by=c("ITEM", "CONDITION", "LIST")) |>
  select(ITEM, CONDITION, ID, ANSWER, CORRECT_ANSWER, LIST) |>
  mutate(ACCURATE = ifelse(CORRECT_ANSWER == ANSWER,
                           yes = "correct",
                           no = ifelse(ANSWER == "dont_know",
                                       yes = "dont_know",
                                       no = "incorrect")),
         CONDITION = case_when(CONDITION == '1' ~ 'illusion',
                               CONDITION == '2' ~ 'no illusion',
                               CONDITION == '100' ~ 'good filler',
                               CONDITION == '101' ~ 'bad filler'))

# 1. Calculate the percentage of "correct", "incorrect", and "don't know" answers 
# in the two critical conditions.

cleaned_moses |>
  group_by(CONDITION, ACCURATE) |>
  filter(CONDITION == 'illusion' | CONDITION == 'no illusion') |>
  summarise(Perc = (n()/length(cleaned_moses)))

# CONDITION == 'illusion' correct: ~12% | incorrect: ~17% | don't know: ~8%
# CONDITION == 'no illusion' correct: ~25% | incorrect: ~5% | don't know: ~7%

# 2. Which question was the easiest and which was the hardest (across all)?

cleaned_moses |>
  filter(ACCURATE == 'correct') |>
  group_by(ITEM, ACCURATE) |>
  summarise(Count = n()) |>
  arrange(-Count)

cleaned_moses |>
  filter(ACCURATE == 'incorrect') |>
  group_by(ITEM, ACCURATE) |>
  summarise(Count = n()) |>
  arrange(-Count)

# Easiest = 103, hardest = 17

# 3. Of the Moses illusion questions, which question fooled most people?

cleaned_moses |>
  filter(CONDITION == 'illusion') |> 
  filter(ACCURATE == 'incorrect') |>
  group_by(CONDITION, ITEM, ACCURATE) |>
  summarise(Count = n()) |>
  arrange(-Count)

# The illusion question that most people got incorrect: 2 and 12

# 4. Which participant was the best in answering questions? Who was the worst?

cleaned_moses |>
  group_by(ID, ACCURATE) |>
  filter(ACCURATE == 'correct') |>
  summarise (Count = n()) |>
  arrange(-Count)

cleaned_moses |>
  group_by(ID, ACCURATE) |>
  filter(ACCURATE == 'incorrect') |>
  summarise (Count = n()) |>
  arrange(-Count)

# Best participant: 880f21222ca0914d0b9f29de0e9cf92a, worst: 19c2d7b9ded0b515c030e3b36dd11909

## ___________________________________________________

  
## Read and inspect the updated new noisy channel data (noisy_rt.csv and noisy_aj.csv).

noisy_rt <- read_csv('noisy_rt.csv')
noisy_aj <- read.csv('noisy_aj.csv')

# 1. Acceptability judgment data: Calculate the mean rating in each condition. 
# How was the data spread out? Did the participants rate the sentences differently?

noisy_aj |>
  group_by(CONDITION) |>
  summarise(Mean = mean(RATING))

# Means: implausible: 1.88, plausible: 4.23

describe(noisy_aj)

noisy_aj |>
  group_by(ID) |>
  summarise(Mean = mean(RATING)) # Yes. Very different means.

# 2. Reading times: calculate the average length people spent reading each sentence fragment
# in each condition. Did the participant read the sentences differently in each condition?

noisy_rt |>
  group_by(CONDITION) |>
  summarise(Mean = mean(RT))

# Averages: implausible: 860., plausible: 851.

noisy_rt |>
  group_by(ID, CONDITION) |>
  summarise(Mean = mean(RT)) # Actually the mean values are quite similar for each participant.

# 3. Make one data frame out of both data frames. Keep all the information but remove redundancy.

noisy <- noisy_aj |>
  inner_join(noisy_rt, by=c("ITEM", "CONDITION", "ID")) |>
  select(ITEM, CONDITION, ID, RATING, SENTENCE, RT, IA)
