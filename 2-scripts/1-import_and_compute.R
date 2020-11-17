# Purpose: Import mtg data
# Author: T. Burel & R. Vezy
# Date: 02/11/2020


# Install / load packages -------------------------------------------------

# install.packages("remotes")
# remotes::install_github("VEZY/XploRer")
library(XploRer)
library(ggplot2)
source("2-scripts/0-functions.R")

# import mtg --------------------------------------------------------------

mtg_files = list.files("1-reconstruction/1-automatic", full.names = TRUE)

length_diff = 
  lapply(mtg_files, function(x){
    corr_branch_diff(
      filepath = gsub(".mtg",".csv",file.path("3-outputs/branches_df",
                                              basename(x))),
      file_auto = x, 
      file_corr = file.path("1-reconstruction/2-auto_and_manual",
                                           basename(x)))
  })
