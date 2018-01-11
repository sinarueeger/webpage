arrests <- USArrests
names(arrests) <- tolower(names(arrests))
arrests$region <- tolower(rownames(USArrests))

map.data <- map_data("state") %>% 
  filter(region %in% c("california","nevada","oregon","washington"))
out <- merge(map.data, arrests, by = "region", all.x = TRUE)


out %>%  ggplot(aes(long, lat)) +
    geom_polygon(aes(group = group, fill = assault/murder)) 
  

map_data("world") %>%
  filter(region == 'Switzerland') %>%
  filter(order %in% c(26473, 26474)) %>% 
  mutate(order = factor(order)) %>%
  ggplot(aes(x = long, y = lat, group = group, color = order)) +
  geom_polygon() + theme(legend.position = "none") 







