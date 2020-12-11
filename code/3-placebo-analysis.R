# _______________________________________________________________
## placebo results (table b2)
## August 19, 2020
## description: generates placebo results presented in table b2
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
## placebo tests ----
# _______________________________________________________________

pl_dt <- dt[, 
  .(section_code, week, ever_ccc, confirmed, total, post)]

placebo_weeks <- dt[post == 0, unique(week)]

# Need data pre-post, so can't use the first or last week in pre-period:
placebo_weeks <- placebo_weeks[2:(length(placebo_weeks) - 1)]
placebo_weeks <- c(ymd(placebo_weeks), ymd("2014-10-15"))

dvs <- c("log(total + 1)", "log(confirmed + 1)")

l <- l_conf <- list()
for(i in 1:length(placebo_weeks)) {
  temp_dt <- copy(pl_dt)
  # subsetting to pre-period
  temp_dt <- temp_dt[post == 0]
  # dropping actual post variable
  temp_dt[, post := NULL] 
  # recoding fake post-period
  temp_dt[, post := as.integer(week >= placebo_weeks[i])]
  
  if(placebo_weeks[i] < ymd("2014-10-15")) {
    l[[i]] <- didModel(dv = "log(total + 1)", fform = "fes", data = temp_dt)
  } else {
    l[[i]] <- didModel(dv = "log(total + 1)", fform = "fes", data = pl_dt)
  }
  rm(temp_dt)
}

# _______________________________________________________________
## formatting regression table and writing latex file ----
# _______________________________________________________________

# count section fes:
section_fe <- sapply(l, function(x) length(unique(x$fe$section_code)))
section_fe <- c("Section FEs", section_fe)

# count week fes:
week_fe <- sapply(l, function(x) length(unique(x$fe$week)))
week_fe <- c("Week FEs", week_fe)

# table b2:
stargazer(l, 
  omit = "^section_code|^week|^pl_post|ever_ccc$",
  column.labels = format(placebo_weeks, format = "%b-%d"),
  covariate.labels = c("CCC x Placebo Start Date"),
  dep.var.labels = "Log(Total Cases + 1)",
  add.lines = list(section_fe, week_fe),
  keep.stat = "n",
  p.auto = TRUE,
  column.sep.width = "0pt",
  digits = 3,
  report = "vcs*",
  title = "Placebo Tests for CCC Analysis",
  label = "tab:did-ccc-placebo",
  out = "tables/table-b2.tex")