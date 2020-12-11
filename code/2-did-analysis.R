# _______________________________________________________________
## regression results (tables 1 and b1)
## August 19, 2020
## description: generates regression results presented in table 1 and table b1
# _______________________________________________________________ 

rm(list = ls()) 
source("code/helper-scripts/_preamble.R")

dt <- read_rds("data/ccc.rds")
dt <- dt[week <= ymd("2015-03-01")]

# _______________________________________________________________
## did models ----
# _______________________________________________________________

didModel <- function(dv, fform = "simple", data) {
  if(fform == "simple") {
    form <- str_c(dv, "~ ever_ccc + post + I(ever_ccc * post) | 0 | 0 | section_code")
  } else if(fform == "fes") {
    form <- str_c(dv, "~ I(ever_ccc * post) | section_code + week | 0 | section_code")
  } 
  felm(as.formula(form), data = data)
}

# _______________________________________________________________
## specifications ----
# _______________________________________________________________

# outcome variables:
count_dvs <- c(rep("total", 2), rep("confirmed", 2))

# logged:
log_dvs <- str_c("log(", count_dvs, " + 1)")

# inverse-hyperbolic sine:
IHS <- function(x) {log(x + sqrt(x ^ 2 + 1))}
ihs_dvs <- str_c("IHS(", count_dvs, ")")

# linear-probability model:
lpm_dvs <- str_c("I(", count_dvs, "> 0)")

# functional forms:
ffs <- rep(c("simple", "fes"), 2)

# _______________________________________________________________
## estimation ----
# _______________________________________________________________

# estimating models with alternative outcomes:
l <- map2(count_dvs, ffs, didModel, data = dt)
l_log <- map2(log_dvs, ffs, didModel, data = dt)
l_ihs <- map2(ihs_dvs, ffs, didModel, data = dt)
l_lpm <- map2(lpm_dvs, ffs, didModel, data = dt)

# summary stats for regressions:
summary_tab <- RegSummary(l)

# _______________________________________________________________
## regression table ----
# _______________________________________________________________

# stacking results across specifications:
res_tab <- bind_rows(
  RegTab(l, trans = "Cases"), 
  RegTab(l_log, trans = "Log(Cases + 1)"),
  RegTab(l_ihs, trans = "IHS(Cases)"),
  RegTab(l_lpm, trans = "1(Cases $>$ 0)"),
  summary_tab
) 
names(res_tab)[grepl("model_", names(res_tab))] <- str_c("(", 1:length(l), ")")

tab_1 <- res_tab %>% filter(transformation %in% c("Cases", "Log(Cases + 1)", ""))
tab_b1 <- res_tab %>% filter(!(transformation %in% c("Cases", "Log(Cases + 1)")))

# formatting regression table
tab_1 <- tab_1 %>%
  gt(groupname_col = "transformation") %>%
  tab_spanner("Total Cases", 2:3) %>%
  tab_spanner("Confirmed Cases", 4:5) %>%
  cols_label(name = "") %>%
  text_transform(locations = cells_body(columns = everything()),
    fn = function(x) str_replace_all(x, "cl_se", "")) %>%
  text_transform(locations = cells_body(columns = everything()),
    fn = function(x) str_replace_all(x, "estimate", "CCC x Post"))

tab_b1 <- tab_b1 %>%
  gt(groupname_col = "transformation") %>%
  tab_spanner("Total Cases", 2:3) %>%
  tab_spanner("Confirmed Cases", 4:5) %>%
  cols_label(name = "") %>%
  text_transform(locations = cells_body(columns = everything()),
    fn = function(x) str_replace_all(x, "cl_se", "")) %>%
  text_transform(locations = cells_body(columns = everything()),
    fn = function(x) str_replace_all(x, "estimate", "CCC x Post"))

# _______________________________________________________________
## writing latex files ----
# _______________________________________________________________

# table 1
tab_title <- "Effect of CCC on Confirmed and Total Cases"
tab_1 %>% out_latex(title = tab_title, fname = "table-1")

# table b1:
tab_b1 %>% 
  out_latex(title = str_c(tab_title, ": Alternative Specifications"), fname = "table-b1")

