library(tidyverse)
library(psych)
library(esquisse)
library(dplyr)

moses <- read_csv("moses_clean.csv")
questions <- read_csv("questions.csv")
  
merged <- moses |>
  full_join(questions, by=c("ITEM", "CONDITION", "LIST")) |>
  select(ITEM, CONDITION, ID, ANSWER, CORRECT_ANSWER, LIST) |>
  mutate(ACCURATE = ifelse(CORRECT_ANSWER == ANSWER,
                           yes = "correct",
                           no = ifelse(ANSWER == "dont_know",
                                       yes = "dont_know",
                                       no = "incorrect")),
         CONDITION = case_when(CONDITION == "1" ~ 'illusion',
                               CONDITION == "2" ~ 'no illusion',
                               CONDITION == '100' ~ 'good filler',
                               CONDITION == '101' ~ 'bad filler')) |>
  group_by(CONDITION, ACCURATE) |>
  summarise(Count = n())
  # arrange() to find the one that gets the most correct answerS??

install.packages(
  c('grid', 
    'gridExtra', 
    'ggplot2', 
    'ggsignif', 
    'ggdendro', 
    'maps', 
    'mapproj',
    'RColorBrewer', 
    'GGally', 
    'patchwork', 
    'plotly',
    'palmerpenguins',
    'colorBlindness'
  )
)
