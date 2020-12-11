
preamble <- function() {
  
  # _______________________________________________________________
  # packages
  pkgs <-
    c(
      "data.table",
      "tidyverse",
      "sf",
      "lubridate",
      "haven",
      "lfe",
      "scales",
      "grid",
      "gridExtra",
      "broom",
      "gt",
      "stargazer"
    )
  suppressMessages(sapply(pkgs, require, character.only = TRUE))
  
  # _______________________________________________________________
  # helper scripts with functions/options:
  source("code/helper-scripts/_plot-opts.R")
  source("code/helper-scripts/_reg-functions.R")
}

preamble()
