# Purpose: Import mtg data
# Author: T. Burel & R. Vezy
# Date: 02/11/2020


# Install / load packages -------------------------------------------------

# install.packages("remotes")
# remotes::install_github("VEZY/XploRer")
library(XploRer)
library(ggplot2)

# import mtg --------------------------------------------------------------

MTG_auto = read_mtg("1-reconstruction/1-automatic/A1B2.mtg")
MTG_corr = read_mtg("1-reconstruction/2-auto_and_manual/A1B2.mtg")

autoplot(MTG_corr)

MTG_auto$attributesAll
# "XX" "YY" "ZZ"

MTG_auto$.scales
MTG_auto$.symbols

mutate_mtg(MTG_auto, length = sqrt((node$XX - parent(node$XX))^2 + 
                                     (node$YY - parent(node$YY))^2 +
                                     (node$ZZ - parent(node$ZZ))^2), 
           .symbol = "N")


print(MTG, "length")
