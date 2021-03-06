library(tidyverse)
library(ggthemes)
library(extrafont)
library(ggrepel)


loadfonts(device = "win")


horror_2020 <- horror %>%
  
  filter(startYear == 2020)


ggplot(horror_2020, aes(numVotes, averageRating, label = primaryTitle)) +
  
  geom_point(size = 4, color = "gray54") +
  
  geom_label_repel(fill = "firebrick4", color = "white", fontface = "bold", family = "Trebuchet MS", segment.color = "gray54") +
  
  geom_vline(xintercept = mean(horror_2020$numVotes), linetype = "dashed", color = "gray 54") +
  
  geom_hline(yintercept = mean(horror_2020$averageRating), linetype = "dashed", color = "gray 54") +
  
  theme_few() +
  
  xlab("\nNumber of Ratings") +
  
  ylab("Average Rating\n") +
  
  ggtitle("IMDB Horror Movie Ratings 2019", subtitle = "") +
  
  theme(axis.text = element_text(size = 16, face = "bold", family = "Trebuchet MS"),
        axis.title = element_text(size = 18, face = "bold", family = "Trebuchet MS"),
        plot.title = element_text(size = 22, face = "bold", family = "Trebuchet MS", hjust = 0.5),
        plot.subtitle = element_text(size = 16, face = "italic", family = "Trebuchet MS", hjust = 0.5),
        legend.position = "none")

ggsave(filename = "horror_2020_scatter.png", width = 21.333, height = 10.666)


horror_2019 <- horror %>%
  
  filter(startYear == 2019)

ggplot(horror_2019, aes(numVotes, averageRating, label = primaryTitle)) +
  
  geom_point(size = 4, color = "gray54") +
  
  geom_label_repel(fill = "firebrick4", color = "white", fontface = "bold", family = "Trebuchet MS", segment.color = "gray54") +
  
  geom_vline(xintercept = mean(horror_2019$numVotes), linetype = "dashed", color = "gray 54") +
  
  geom_hline(yintercept = mean(horror_2019$averageRating), linetype = "dashed", color = "gray 54") +
  
  theme_few() +
  
  xlab("\nNumber of Ratings") +
  
  ylab("Average Rating\n") +
  
  ggtitle("IMDB Horror Movie Ratings 2019", subtitle = "excluding Us and It Chapter Two") +
  
  xlim(0, 75000) +
  
  theme(axis.text = element_text(size = 16, face = "bold", family = "Trebuchet MS"),
        axis.title = element_text(size = 18, face = "bold", family = "Trebuchet MS"),
        plot.title = element_text(size = 22, face = "bold", family = "Trebuchet MS", hjust = 0.5),
        plot.subtitle = element_text(size = 16, face = "italic", family = "Trebuchet MS", hjust = 0.5),
        legend.position = "none")

ggsave(filename = "horror_2019_scatter_truncated.png", width = 21.333, height = 10.666)



horror_best <- horror_adj %>%
  
  filter(startYear > 1965, 
         startYear < 2020) %>%
  
  group_by(startYear) %>%
  
  filter(adj_score == max(adj_score))


ggplot(horror_best, aes(startYear, averageRating, label = primaryTitle)) +
  
  geom_line() +
  
  geom_point(size = 4, color = "gray54") +
  
  geom_label_repel(fill = "firebrick4", color = "white", fontface = "bold", family = "Trebuchet MS", segment.color = "gray54") +
  
  theme_few() +
  
  xlab("\nYear") +
  
  ylab("Adjusted Average Rating\n") +
  
  ggtitle("IMDB Top Horror Movie by Year Since 1975", subtitle = "movies ranked using a blended score based on popularity and quality") +
  
  theme(axis.text = element_text(size = 16, face = "bold", family = "Trebuchet MS"),
        axis.title = element_text(size = 18, face = "bold", family = "Trebuchet MS"),
        plot.title = element_text(size = 22, face = "bold", family = "Trebuchet MS", hjust = 0.5),
        plot.subtitle = element_text(size = 16, face = "italic", family = "Trebuchet MS", hjust = 0.5),
        legend.position = "none")

ggsave(filename = "horror_best_by_year.png", width = 21.333, height = 10.666)