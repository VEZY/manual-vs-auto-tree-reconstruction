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
lengt_diff$A2B3$relative
length_diff$A3B4$relative
length_diff$A4B6$relative
length_diff$A5B7$relative

# Compute relative error mean and sd:

relative_error = c(length_diff$A1B1$relative,length_diff$A1B2$relative,
                   lengt_diff$A2B3$relative,length_diff$A3B4$relative, 
                   length_diff$A4B6$relative,length_diff$A5B7$relative)

error_vec = c(length_diff$A1B1$relative,length_diff$A1B2$relative,
             length_diff$A2B3$relative,length_diff$A3B4$relative, 
             length_diff$A4B6$relative,length_diff$A5B7$relative)

mean(error_vec)

sd(error_vec)

# Interpret boxplot:
boxplot(error_vec)

# Identify corrections in links between nodes in branches:

MTG_corr_A1B1 = read_mtg("1-reconstruction/2-auto_and_manual/A1B1.mtg")
autoplot(MTG_corr_A1B1)

MTG_corr_A1B2 = read_mtg("1-reconstruction/2-auto_and_manual/A1B2.mtg")
autoplot(MTG_corr_A1B2)

MTG_corr_A2B3 = read_mtg("1-reconstruction/2-auto_and_manual/A2B3.mtg")
autoplot(MTG_corr_A2B3)

MTG_corr_A3B4 = read_mtg("1-reconstruction/2-auto_and_manual/A3B4.mtg")
autoplot(MTG_corr_A3B4)

MTG_corr_A4B6 = read_mtg("1-reconstruction/2-auto_and_manual/A4B6.mtg")
autoplot(MTG_corr_A4B6)

MTG_corr_A5B7 = read_mtg("1-reconstruction/2-auto_and_manual/A5B7.mtg")
autoplot(MTG_corr_A5B7)

