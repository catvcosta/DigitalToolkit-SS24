# Catarina Costa, assignment 5

# Make 10 plots overall.

"
1. 3 plots for the Moses illusion data (line, point, and bar)
2. 3 plots for the noisy channel reading time data (line, point, and bar)
3. 3 plots for the noisy channel acceptability rating data (line, point, and bar)
4. Ugly, unreadable, and violating many WCOG guidelines dataset.
"

#### My line and point graphs are not so good. I'm not sure if I'm using
## the datasets in the best way, but I didn't have time to think of more
# preprocessing steps this week. :(

library(tidyverse)
library(esquisse)
library(patchwork)
library(cowplot)

set_i18n("en")

moses <- read_csv("moses_clean.csv")
questions <- read_csv("questions.csv")

moses.preprocessed <-
  moses |> 
  inner_join(questions, by=c("ITEM", "CONDITION", "LIST")) |>
  select(ID, ITEM, CONDITION, QUESTION, ANSWER, CORRECT_ANSWER) |>
  mutate(ACCURATE = ifelse(CORRECT_ANSWER == ANSWER,
                           yes = "correct",
                           no = ifelse(ANSWER == "dont_know",
                                       yes = "dont_know",
                                       no = "incorrect")),
         CONDITION = case_when(CONDITION == '1' ~ 'illusion',
                               CONDITION == '2' ~ 'no illusion',
                               CONDITION == '100' ~ 'good filler',
                               CONDITION == '101' ~ 'bad filler')) 
esquisser()

noisy_rt <- read.csv("noisy_rt.csv")
esquisser()

noisy_aj <- read_csv("noisy_aj.csv")
esquisser()

noisy <- read_csv("noisy.csv")
noisy.rt <- 
  noisy |>
  rename(ID = "MD5.hash.of.participant.s.IP.address",
         SENTENCE = "Sentence..or.sentence.MD5.") |>
  mutate(RT = as.numeric(Reading.time)) |>
  filter(Label == "experiment",
         PennElementType != "Scale",
         PennElementType != "TextInput",
         Reading.time != "NULL",
         RT > 80 & RT < 2000) |>
  select(ID, ITEM, CONDITION, SENTENCE, RT, Parameter) |>
  na.omit()

noisy.summary <- 
  noisy.rt |>
  group_by(ITEM, CONDITION, Parameter) |>
  summarise(RT = mean(RT)) |>
  group_by(CONDITION, Parameter) |>
  summarise(MeanRT = mean(RT),
            SD = sd(RT)) |>
  rename(IA = Parameter)

noisy.summary |>
  ggplot() +
  aes(x=as.numeric(IA), y=MeanRT, colour=CONDITION) +
  geom_line() +
  geom_point() +
  facet_wrap(.~CONDITION) +
  stat_sum() +
  # geom_errorbar(aes(ymin=MeanRT-2*SD, ymax=MeanRT+2*SD)) +
  coord_polar() +
  theme_classic() +
  labs(x = "Interest area",
       y = "Mean reading time in ms",
       title = "Noisy channel data",
       subtitle = "Reading times only",
       caption = "Additional caption",
       colour="Condition",
       size = "Count")
esquisser()

# 1.1

plot1_1 <- 
  ggplot(moses) +
  aes(x = ITEM, y = CONDITION) +
  geom_line(colour = "#EF562D") +
  theme_minimal()

# 1.2

plot1_2 <- ggplot(moses.preprocessed) +
  aes(x = ITEM, y = CONDITION) +
  geom_point(
    shape = "circle open",
    size = 1.5,
    colour = "#B22222"
  ) +
  coord_flip() +
  theme_light()

# 1.3

plot1_3 <- ggplot(moses.preprocessed) +
  aes(x = ACCURATE, y = ITEM, fill = CONDITION) +
  geom_col() +
  scale_fill_manual(
    values = c(`bad filler` = "#F8766D",
               `good filler` = "#31B425",
               illusion = "#20AFEC",
               `no illusion` = "#FF61C3")
  ) +
  #labs(
   # x = "Accurate",
    #y = "Item",
    #title = "Accurate Answers per Item"
  #) +
  theme_linedraw()

# 2.1

plot2_1 <- ggplot(noisy_rt) +
  aes(x = IA, y = RT) +
  geom_line(colour = "#0C4C8A") +
  theme_minimal()

# 2.2

plot2_2 <- ggplot(noisy_rt) +
  aes(x = ITEM, y = RT, colour = ID) +
  geom_jitter(size = 1.5) +
  scale_color_hue(direction = 1) +
  coord_flip() +
  theme_minimal()

# 2.3

plot2_3 <- ggplot(noisy_rt) +
  aes(x = ITEM, y = RT) +
  geom_col(fill = "#440154") +
  #labs(
   # x = "Item",
    #y = "Reading Time",
    #title = "Reading Time per Item (ms)"
  #) +
  coord_flip() +
  theme_gray()

# 3.1

plot3_1 <- ggplot(noisy.summary) +
  aes(x = SD, y = MeanRT) +
  geom_line(colour = "#440154") +
 # labs(title = "Mean RT & Standard Deviation") +
  theme_minimal()

# 3.2

plot3_2 <- ggplot(noisy_aj) +
  aes(x = RATING, y = ID, colour = CONDITION, group = ITEM) +
  geom_point(shape = "circle", size = 1.5) +
  scale_color_hue(direction = 1) +
#  labs(title = "Rating per ID") +
  theme_minimal()

# 3.3

plot3_3 <- ggplot(noisy_aj) +
  aes(x = ID, y = RATING) +
  geom_col(fill = "#440154") +
  coord_flip() +
  theme_linedraw()

# 4

ggplot(noisy_rt) +
  aes(x = ITEM, y = RT, fill = RT, colour = ID, group = IA) +
  geom_path() +
  scale_fill_distiller(palette = "Greys", direction = 1) +
  scale_color_brewer(palette = "Greys", direction = 1) +
  labs(x = "xyz", y = "=") +
  coord_flip() +
  theme_dark()

plots <-
  plot_grid(plot1_1 + theme(legend.position="none"), 
            plot1_2 + theme(legend.position="none"), 
            plot1_3 + theme(legend.position="none"), 
            plot2_1 + theme(legend.position="none"),
            plot2_2 + theme(legend.position="none"),
            plot2_3 + theme(legend.position="none"),
            plot3_1 + theme(legend.position="none"),
            plot3_2 + theme(legend.position="none"),
            plot3_3 + theme(legend.position="none"),
            align = "h"
            rel_widths = c(1, 2, 3))

# Export plots
ggsave("cowplot_plots.png", height=8, dpi=300)
ggsave("cowplot_plots.pdf", dpi=300)

