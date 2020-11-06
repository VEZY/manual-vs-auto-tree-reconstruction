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
    corr_branch_diff(file_auto = x, 
                     file_corr = file.path("1-reconstruction/2-auto_and_manual",
                                           basename(x)))
  })

names(length_diff) = gsub(".mtg","", basename(mtg_files))

length_diff$A1B1$relative
length_diff$A1B2$relative

# Compute relative error mean and sd:
relative_error = c(length_diff$A1B1$relative,2,3,4)
mean()
sd()

# Interpret boxplot:
boxplot(relative_error)

# Identify corrections in links between nodes in branches:
autoplot(MTG_corr)