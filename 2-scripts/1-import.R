# Purpose: Import mtg data
# Author: T. Burel & R. Vezy
# Date: 02/11/2020


# Install / load packages -------------------------------------------------

# install.packages("remotes")
# remotes::install_github("VEZY/XploRer")
library(XploRer)


# import mtg --------------------------------------------------------------



MTG = read_mtg("1-reconstruction/1-automatic/A1B1.mtg")
