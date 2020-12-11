# _______________________________________________________________
## run-analysis 
## August 19, 2020
## description: this sources scripts that produce all tables and figures in the manuscript and online appendix
# _______________________________________________________________

# _______________________________________________________________
## citation ----
# _______________________________________________________________

# @article{christensen:2020co,
# Author = {Christensen, Darin and Dube, Oeindrila and Haushofer, Johannes and Siddiqi, Bilal and Voors, Maarten},
#   Title = {Community-Based Crisis Response: Evidence from Sierra Leone's Ebola Outbreak},
# Journal = {AEA Papers and Proceedings},
# Volume = {110},
# Year = {2020},
# Month = {May},
# Pages = {260--264}
# }
 
# _______________________________________________________________
## data note ----
# _______________________________________________________________

# data is subset by the following conditions
# week <= ymd("2015-05-01") & mult_ccc == 0, 
# where mult_ccc is an indicator for whether a section contains multiple CCCs

# _______________________________________________________________
## figures and tables ----
# _______________________________________________________________

# cleaning workspace:
rm(list = ls())

# _______________________________________________________________ 
# to exactly replicate the standard errors, use lfe version 2.8-2
# un-comment the line below to install the legacy version, then restart R
# devtools::install_version("lfe", version = "2.8-2", repos = "http://cran.us.r-project.org")

# if you use the leading version of lfe (currently 2.8-5) there are small changes to the standard errors
# these do not change any conclusions in the paper

# _______________________________________________________________
# figure 1: trends in total cases by ccc presence
# figure a2: trends in confirmed cases by ccc presence
source("code/1-did-plots.R")

# _______________________________________________________________
# table 1: effect of cccs on confirmed and total cases
# table b1: effects of cccs on confirmed and total cases: alternative specifications
source("code/2-did-analysis.R")

# _______________________________________________________________
# table b2: placebo tests for ccc analysis
source("code/3-placebo-analysis.R")

# _______________________________________________________________
# figure a1: map of reported cases and community care centers
source("code/4-maps.R")

# _______________________________________________________________
## session info ----
# _______________________________________________________________

sessionInfo()
# R version 3.6.3 (2020-02-29)
# Platform: x86_64-pc-linux-gnu (64-bit)
# Running under: Ubuntu 18.04.5 LTS
# 
# Matrix products: default
# BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
# LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1
# 
# locale:
#   [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8       
# [4] LC_COLLATE=en_US.UTF-8     LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
# [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C              
# [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
# 
# attached base packages:
#   [1] grid      stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] stargazer_5.2.2   gt_0.1.0          broom_0.5.5       gridExtra_2.3     scales_1.1.0     
# [6] lfe_2.8-2         Matrix_1.2-18     haven_2.2.0       lubridate_1.7.8   sf_0.9-2         
# [11] forcats_0.5.0     stringr_1.4.0     dplyr_0.8.5       purrr_0.3.4       readr_1.3.1      
# [16] tidyr_1.0.2       tibble_3.0.1      ggplot2_3.3.0     tidyverse_1.3.0   data.table_1.12.8
# 
# loaded via a namespace (and not attached):
#   [1] Rcpp_1.0.4.6       lattice_0.20-41    class_7.3-17       zoo_1.8-7          assertthat_0.2.1  
# [6] digest_0.6.25      R6_2.4.1           cellranger_1.1.0   backports_1.1.5    reprex_0.3.0      
# [11] evaluate_0.14      e1071_1.7-3        httr_1.4.1         pillar_1.4.4       rlang_0.4.6       
# [16] readxl_1.3.1       rstudioapi_0.11    checkmate_2.0.0    rmarkdown_2.1      labeling_0.3      
# [21] munsell_0.5.0      xfun_0.12          compiler_3.6.3     modelr_0.1.6       pkgconfig_2.0.3   
# [26] htmltools_0.4.0    tidyselect_1.0.0   fansi_0.4.1        crayon_1.3.4       dbplyr_1.4.2      
# [31] withr_2.1.2        nlme_3.1-147       jsonlite_1.6.1     xtable_1.8-4       gtable_0.3.0      
# [36] lifecycle_0.2.0    DBI_1.1.0          magrittr_1.5       units_0.6-6        KernSmooth_2.23-17
# [41] cli_2.0.2          stringi_1.4.6      farver_2.0.3       fs_1.3.2           xml2_1.3.2        
# [46] ellipsis_0.3.1     generics_0.0.2     vctrs_0.3.0        sandwich_2.5-1     Formula_1.2-3     
# [51] tools_3.6.3        glue_1.4.1         hms_0.5.3          parallel_3.6.3     colorspace_1.4-1  
# [56] classInt_0.4-3     rvest_0.3.5        knitr_1.28         sass_0.1.2.1     