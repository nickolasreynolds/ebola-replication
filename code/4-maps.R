# _______________________________________________________________
## maps
## August 19, 2020
## description: generates figure a1
# _______________________________________________________________ 

rm(list = ls()) 
source("code/helper-scripts/_preamble.R")

map_list <- read_rds("data/ccc-map.rds")

# _______________________________________________________________
# figure a1a
ggplot() +
  geom_sf(data = map_list[[3]], aes(fill = log(total + 1)), color = "transparent") +
  geom_sf(data = map_list[[1]], fill = "transparent") +
  scale_fill_gradient2("Log(VHF Entries + 1)",
    midpoint = 2.3, low = "white", high = "black", mid = "grey90") + 
  theme_bw() + opts +
  theme(legend.position = "bottom")

ggsave(filename = "figures/figure-a1a.pdf")

# _______________________________________________________________
# figure a1b
ggplot() +
  geom_sf(data = map_list[[1]], fill = "transparent") +
  geom_sf(data = map_list[[2]], aes(shape = "Community Care Center"),
    size = 3, show.legend = "point") +
  scale_shape_discrete("") +
  theme_bw() + opts + 
  theme(legend.position = "bottom")

ggsave(filename = "figures/figure-a1b.pdf")

