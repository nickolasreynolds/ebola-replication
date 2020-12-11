# plot options

.opts <- new.env()

.opts$opts <- theme(
  text = element_text(family = "Times"),
  panel.grid.major = element_line(colour = 'transparent'),
  panel.grid.minor = element_line(colour = 'transparent'),
  strip.background = element_rect(colour = 'grey', fill = 'transparent'),
  # panel.border = element_rect(color = 'transparent'),
  strip.text = element_text(size = 16, colour = 'black'),
  axis.text.x = element_text(size = 18, colour = 'black'),
  axis.text.y = element_text(size = 18, colour = 'black'),
  axis.title.x = element_text(size = 18, colour = 'black'),
  title = element_text(size = 16, colour = 'black'),
  axis.title.y = element_text(
    size = 18,
    angle = 90,
    colour = 'black',
    vjust = 1.1
  ),
  legend.text = element_text(size = 16),
  legend.title = element_text(size = 16)
)

.opts$map_theme <- theme(
  text = element_text(family = "Times"),
  panel.grid.major = element_line(colour = 'transparent'),
  panel.grid.minor = element_line(colour = 'transparent'),
  strip.background = element_rect(colour = 'grey', fill = 'transparent'),
  # panel.border = element_rect(color = 'transparent'),
  axis.line = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  legend.text = element_text(size = 16),
  legend.title = element_text(size = 16),
  title = element_text(size = 14, colour = 'black'),
  panel.background = element_rect(fill = 'transparent', colour = NA)
)

attach(.opts, warn.conflicts = FALSE)
