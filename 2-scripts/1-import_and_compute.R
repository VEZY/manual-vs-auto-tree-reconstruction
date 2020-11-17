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
      file_auto = x, 
      file_corr = file.path("1-reconstruction/2-auto_and_manual",
                                           basename(x)))
  })
names(length_diff) = gsub(".mtg","", basename(mtg_files))

dplyr::bind_rows(length_diff, .id = "branch")%>%
  data.table::fwrite(x = ., file = "3-outputs/branches_df/total.csv")



# Find errors in automatic reconstruction ---------------------------------

# Identify corrections in links between nodes in branches:

MTG_corr_A1B1 = read_mtg("1-reconstruction/2-auto_and_manual/A1B1.mtg")
autoplot(MTG_corr_A1B1)

MTG_corr_A1B2 = read_mtg("1-reconstruction/2-auto_and_manual/A1B2.mtg")
MTG_auto_A1B2 = read_mtg("1-reconstruction/1-automatic/A1B2.mtg")
autoplot(MTG_corr_A1B2)
autoplot(MTG_auto_A1B2)

autoplot(MTG_corr_A1B2)

MTG_corr_A2B3 = read_mtg("1-reconstruction/2-auto_and_manual/A2B3.mtg")
autoplot(MTG_corr_A2B3)

MTG_corr_A3B4 = read_mtg("1-reconstruction/2-auto_and_manual/A3B4.mtg")
autoplot(MTG_corr_A3B4)

MTG_corr_A4B6 = read_mtg("1-reconstruction/2-auto_and_manual/A4B6.mtg")
autoplot(MTG_corr_A4B6)

MTG_corr_A5B7 = read_mtg("1-reconstruction/2-auto_and_manual/A5B7.mtg")
autoplot(MTG_corr_A5B7)

