library(tidyverse)
library(psych)
library(esquisse)

# 1. What do the following evaluate to and why?
  
!TRUE # Evaluates to FALSE ! = not
FALSE + 0 # 0 since FALSE = 0
5 & TRUE # TRUE & = and, and since both values are true themselves it evaluates to TRUE
0 & TRUE # FALSE since 0 evaluates to FALSE
1 - FALSE # 1 since FALSE = 0
FALSE + 1 # 1 since FALSE = 0
1 | FALSE # TRUE if there is one value that evaluates to TRUE, the OR operator returns TRUE
FALSE | NA # NA same logic as previous

# 2. In moses.csv saved as "moses" why do the following fail?

moses <- read_csv("moses.csv")

Summary(moses) # Summary should not be capitalized
read_csv(moses.csv) # .csv is unnecessary
tail(moses, n==10) # n=10, not n==10
describe(Moses) # mo ses is not capitalized
filter(moses, CONDITION == 102) # Because there's no 102 condition(?)
arragne(moses, ID) # arrange, not arragne
mutate(moses, ITEMS = as.character("ITEM")) # No "" around ITEM needed

# 3. Clean up the Moses illusion data using pipes.

moses <- read_csv("moses.csv")
moses_uniq <- moses |>
  rename(ID = MD5.hash.of.participant.s.IP.address, ANSWER = Value) |>
  select(ID, ITEM, CONDITION, ANSWER, Label, Parameter) |>
  na.omit() |>
  filter(Parameter == "Final", Label != "instructions", CONDITION %in% 1:2) |>
  arrange(ITEM, CONDITION, desc(ANSWER)) |>
  mutate(ITEM = as.numeric(ITEM))
# unique(select(filter(ITEM == 2), ANSWER)) for some reason, I couldn't pipe this?
moses_uniq2 <- unique(select(filter(moses_uniq, ITEM == 2), ANSWER)) # Extra from the class

# 4. Two new variables (printing and dont.know)

moses <- read_csv("moses.csv")
printing_moses <- moses |>
  rename(ID = MD5.hash.of.participant.s.IP.address, ANSWER = Value) |>
  select(ID, ITEM, CONDITION, ANSWER, Label, Parameter) |>
  mutate(ITEM = as.numeric(ITEM)) |>
  filter(ITEM == 32)

printing <- c("Typing machine", "inventing printing", "for inventing the pressing machine", "the book printer", 
              "inventing the book press/his bibles", "letterpress", "Printing", "bookpress", "Print", "finding a way to print books",
              "Book print", "telegraph", "printing press", "Printing books", "press", "Letterpressing", "book printing",
              "letter press", "printer", "Buchdruck", "Drucka")
dont.know <- c("don't know", "who", "Don't know", "Don't Know", "gf") # Only in the press question (?)

# 5. Preprocess noisy channel data. Make two data frames: for reading times and for acceptability judgments.

noisy <- read_csv("noisy.csv")

acceptability <- noisy |>
  rename(ID = MD5.hash.of.participant.s.IP.address, Rating = Value) |>
  filter (Label == "experiment",PennElementType == "Scale") |>
  select(ID, ITEM, CONDITION, Rating) |>
  mutate(Rating = as.numeric(Rating)) |>
  na.omit()

reading <- noisy |>
  rename(ID = MD5.hash.of.participant.s.IP.address, SENTENCE = Sentence..or.sentence.MD5.) |>
  filter(Label == "experiment", PennElementType != "Scale", PennElementType != "TextInput", Reading.time != "NULL") |>
  mutate(Reading.time = as.numeric(Reading.time)) |>
  filter(Reading.time >= 80 & Reading.time <= 2000) |>
  select(ID, ITEM, CONDITION, SENTENCE, Reading.time, Parameter) |>
  na.omit()
  
# 6. Solve the logic exercise from the slides.

"
1. !bird
2. !canswim
3. bird & canswim
4. !bird & canswim
5. !bird & !canswim
6. bird & !canswim
7. bird | canswim
8. canswim | (!bird & !canswim) -> !bird | can swim
9. bird | canswim | (!bird & !canswim) -> bird | !bird
10. !bird & !canswim & (bird & !canswim) # Not sure about this one -> bird & !bird
"
