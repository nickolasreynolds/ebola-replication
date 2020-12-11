# _______________________________________________________________
## plots
## August 19, 2020
## description: generates figures 1 and A2
# _______________________________________________________________ 

rm(list = ls()) 
source("code/helper-scripts/_preamble.R")

dt <- read_rds("data/ccc.rds")
# write_csv(dt, "data/ccc.csv")

# _______________________________________________________________
## plotting did ----
# _______________________________________________________________ 

# averages by week and group:
plot_dt <- dt[, .(
  log_conf = mean(log(confirmed + 1)),
  log_total = mean(log(total + 1))), 
  by = list(ever_ccc, post, week)]

plot_dt[, treat := factor(ever_ccc)]

xmin_rect <- as.POSIXct("2014-10-15")
xmax_rect <- as.POSIXct("2015-03-01")

# _______________________________________________________________
# figure 1: total cases:
ggplot(data = plot_dt, 
  aes(x = week, y = log_total, 
    lty = treat, shape = treat, group = treat)) +
  geom_rect(aes(xmin = xmin_rect, xmax = xmax_rect, ymin = 0, ymax = .6), 
    fill = "grey70", color = "transparent", alpha = .2) + 
  geom_line(lwd = 1) + 
  scale_x_datetime("", date_labels = "%b-%y", date_breaks = "1 months") + 
  geom_point(size = 3) + 
  scale_linetype_manual("", values = c(3, 1), labels = c("Never CCC", "1 CCC Facility")) + 
  scale_shape_discrete("", labels = c("Never CCC", "1 CCC Facility")) + 
  ylab("Log(Total Cases + 1)") +
  annotate("text", x = as.POSIXct("2014-09-10"), y = .25, 
    label = "Implementation\nStarts (mid-Oct)", family = "mono") + 
  annotate("text", x = as.POSIXct("2015-02-05"), y = .1, 
    label = "Decomissioning\nStarts (March)", family = "mono") + 
  theme_bw() + opts +
  theme(
    legend.background = element_blank(),
    legend.position = c(.87, .92), 
    axis.text.x = element_text(size = 14))

ggsave(filename = "figures/figure-1.pdf", width = 10, height = 5)

# _______________________________________________________________
# figure a2: confirmed cases
ggplot(data = plot_dt, 
  aes(x = week, y = log_conf, 
    lty = treat, shape = treat, group = treat)) +
  geom_rect(aes(xmin = xmin_rect, xmax = xmax_rect, ymin = 0, ymax = .3), 
    fill = "grey70", color = "transparent", alpha = .2) + 
  geom_line(lwd = 1) + 
  scale_x_datetime("", date_labels = "%b-%y", date_breaks = "1 months") + 
  geom_point(size = 3) + 
  scale_linetype_manual("", values = c(3, 1), labels = c("Never CCC", "1 CCC Facility")) + 
  scale_shape_discrete("", labels = c("Never CCC", "1 CCC Facility")) + 
  ylab("Log(Confirmed Cases + 1)") +
  annotate("text", x = as.POSIXct("2014-09-10"), y = .2, 
    label = "Implementation\nStarts (mid-Oct)", family = "mono") + 
  annotate("text", x = as.POSIXct("2015-02-05"), y = .2, 
    label = "Decomissioning\nStarts (March)", family = "mono") + 
  theme_bw() + opts +
  theme(legend.position = c(.87, .85), axis.text.x = element_text(size = 14))

ggsave(filename = "figures/figure-a2.pdf", width = 10, height = 5)

