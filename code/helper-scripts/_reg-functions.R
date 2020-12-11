# _______________________________________________________________
## reg-functions
## August 19, 2020
# _______________________________________________________________ 

# _______________________________________________________________
# helper function for regression tables:
RegTab <- function(l, trans, d = 3) {
  model_data <- map_dfr(l, tidy, .id = "model") %>%
    filter(term == "I(ever_ccc * post)") %>%
    mutate(outcome = map_chr(l, "lhs")) %>%
    mutate(
      stars = case_when(
        p.value < .01 ~ "***",
        p.value < .05 & p.value > .01 ~ "**",
        p.value < .1 & p.value > .05 ~ "*",
        p.value > .1 ~ ""
      )
    ) %>%
    mutate(
      cl_se = str_c("(", round(std.error, d), ")", stars),
      estimate = round(estimate, d) %>% as.character()# ,
      # N = map_dbl(l, "N") %>% format(big.mark = ",")
    )
  
  model_data %>%
    dplyr::select(model, estimate, cl_se) %>%
    pivot_longer(-model) %>%
    pivot_wider(names_from = "model", names_prefix = "model_",) %>%
    mutate(transformation = trans)
}

# _______________________________________________________________
RegSummary <- function(l) {
  fe_rows <- map(l, "fe") %>% 
    map_dfc(function(x) if(length(x) == 0) {c(section_code = "", week = "")} 
      else (map_dbl(x, n_distinct))) %>%
    mutate(name = c("Sections", "Weeks"), transformation = "") %>%
    dplyr::select(name, everything())
  
  fe_df <- rbind(
    c("N", map_dbl(l, "N"), ""),
    fe_rows)
  
  names(fe_df) <- c("name", str_c("model_", 1:length(l)), "transformation")
  return(fe_df)
}

# _______________________________________________________________
out_latex <- function(x, title = "", fname = NULL) {
  split_tab <- x %>% as_latex() %>%
    str_split("\n") %>%
    .[[1]]
  
  start <- str_detect(split_tab, "begin\\{longtable\\}") %>% which()
  end <- str_detect(split_tab, "end\\{longtable\\}") %>% which()
  notes <- str_detect(split_tab, "\\bNotes\\b") %>% which()
  
  main_tab <- split_tab[(start + 1):(end - 1)]
  
  start_tblr <- split_tab[start] %>% str_replace("longtable", "tabular")
  new_notes <- str_c("\\caption*{\\footnotesize", 
    str_replace(split_tab[notes], "\\\\\\\\ ", ""), 
    "}")
  start_caption <- str_c("\\caption{", title, "}")
  
  if(is.null(fname)) {
    label <- str_c("\\label{tab:", "XX", "}")
  } else {
    label <- str_c("\\label{tab:", fname, "}")
  }
  
  main_tab <- main_tab %>% 
    str_replace_all("multicolumn\\{1\\}\\{l\\}", "multicolumn\\{3\\}\\{l\\}")
  
  full_tab <- c(
    str_c("% Generated:", Sys.time()),
    "\\begin{table}[ht!]",
    "\\centering",
    start_caption,
    label,
    start_tblr,
    main_tab, 
    "\\end{tabular}",
    new_notes, 
    "\\end{table}")
  
  if(is.null(fname)) {
    cat(full_tab, sep = "\n")
  } else {
    cat(full_tab, sep = "\n", file = str_c("tables/", fname, ".tex"))
  }
}
