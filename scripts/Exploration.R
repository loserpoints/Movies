test <- horror_adj %>%
  
  filter(startYear == 2004)


test2 <- akas2 %>%
  
  filter(title == "The Blue Elephant")




basics2 <- read.csv("title.basics.tsv.gz", sep = "\t")

akas2 <- read.csv("title.akas.tsv.gz", sep = "\t", stringsAsFactors = F)




ggplot(horror, aes(numVotes, averageRating)) +
  
  geom_point() +
  
  geom_smooth(method = "lm")


sd(horror$averageRating)

horror_adj <- horror %>%
  
  group_by(startYear) %>%
  
  arrange(numVotes) %>%
  
  mutate(vote_rank = row_number()) %>%
  
  arrange(averageRating) %>%
  
  mutate(rating_rank = row_number()) %>%
  
  mutate(popularity = rescale(vote_rank, to = c(0, 5)),
         quality = rescale(rating_rank, to = c(0, 5)),
         adj_score = popularity + quality)





horror_2020 <- horror_adj %>%
  
  filter(startYear == 2019)



horror_best_stacked <- horror_best %>%
  
  select(startYear, primaryTitle, popularity, quality) %>%
  
  filter(startYear >= 1980) %>%
  
  arrange(startYear, -quality) %>%
  
  group_by(startYear) %>%
  
  mutate(n = row_number()) %>%
  
  filter(n == 1) %>%
  
  ungroup() %>%
  
  pivot_longer(cols = popularity:quality) %>%
  
  mutate(name = factor(name, levels = c("quality", "popularity")))



ggplot(horror_best_stacked, aes(x= 1, value, fill = name)) +
  
  facet_wrap(~startYear,  strip.position = "left", ncol = 1) +
  
  geom_bar(stat = "identity") +
  
  geom_text(data = horror_best_stacked %>% filter(name == "popularity"), aes(label = primaryTitle), color = "black", fontface = "bold", family = "Trebuchet MS", hjust = 1.25) +
  
  theme_few() +
  
  coord_flip() +
  
  xlab("\nYear") +
  
  ylab("Adjusted Average Rating\n") +
  
  ggtitle("IMDB Highest Rated Horror Movie by Year Since 1975", subtitle = "") +
  
  theme(axis.text = element_text(size = 16, face = "bold", family = "Trebuchet MS"),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title = element_text(size = 18, face = "bold", family = "Trebuchet MS"),
        plot.title = element_text(size = 22, face = "bold", family = "Trebuchet MS", hjust = 0.5),
        plot.subtitle = element_text(size = 16, face = "italic", family = "Trebuchet MS", hjust = 0.5),
        strip.text = element_text(angle = 180),
        legend.position = "right")

ggsave(filename = "horror_best_by_year.png", width = 21.333, height = 10.666)  











horror_popularity <- horror_adj %>%
  
  select(startYear, numVotes) %>%
  
  group_by(startYear) %>%
  
  summarize_all(sum)



ggplot(horror_popularity, aes(startYear, numVotes)) +
  
  geom_point() +
  
  geom_line()




test <- df_list [70] %>%
  
  as.data.frame(.)



best_ever <- horror_adj %>%
  
  filter(startYear >= 1960) %>%
  
  arrange(-adj_score) %>%
  
  top_n(99, adj_score) %>%
  
  select(primaryTitle, startYear, popularity, quality) %>%
  
  mutate(rank = row_number(),
         facet = ifelse(rank < 34, 1, 
                        ifelse(rank < 67, 2, 3))) %>%
  
  mutate(label = paste0(rank, " - ", primaryTitle, " (", startYear, ")")) %>%
  
  arrange(-rank) %>%
  
  mutate(label = factor(label, levels = label))


ggplot(best_ever, aes(-rank, y = 1, label = label)) +
  
  facet_wrap(~facet, scales = "free") +
  
  geom_tile(stat = "identity", fill = "dodgerblue3", alpha = 0.2) +
  
  geom_text(size = 5, family = "Trebuchet MS") +
  
  theme_few() +
  
  coord_flip() +
  
  xlab("") +
  
  ylab("") +
  
  ggtitle("IMDB Top 99 Horror Movies Since 1960", subtitle = "movies ranked using a blended score based on popularity and quality") +
  
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        plot.title = element_text(size = 22, face = "bold", family = "Trebuchet MS", hjust = 0.5),
        plot.subtitle = element_text(size = 16, face = "italic", family = "Trebuchet MS", hjust = 0.5),
        strip.background = element_blank(),
        strip.text = element_blank())

ggsave(filename = "imdb_top_99_horror.png", height = 10.666, width = 21.333)







ggplot(best_ever, aes(quality, popularity, label = label)) +
  
  geom_point(size = 4, color = "gray54") +
  
  geom_label_repel(fill = "firebrick4", color = "white", fontface = "bold", family = "Trebuchet MS", segment.color = "gray54") +
  
  geom_vline(xintercept = mean(best_ever$quality), linetype = "dashed", color = "gray 54") +
  
  geom_hline(yintercept = mean(best_ever$popularity), linetype = "dashed", color = "gray 54") +
  
  theme_few() +
  
  xlab("\nQuality") +
  
  ylab("Popularity\n") +
  
  ggtitle("IMDB Horror Movie Ratings Since 1960", subtitle = "") +
  
  theme(axis.text = element_text(size = 16, face = "bold", family = "Trebuchet MS"),
        axis.title = element_text(size = 18, face = "bold", family = "Trebuchet MS"),
        plot.title = element_text(size = 22, face = "bold", family = "Trebuchet MS", hjust = 0.5),
        plot.subtitle = element_text(size = 16, face = "italic", family = "Trebuchet MS", hjust = 0.5),
        legend.position = "none")
