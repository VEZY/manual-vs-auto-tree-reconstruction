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
MTG_auto$.symbol

mutate_mtg(MTG_auto, length = sqrt((node$XX - parent(node$XX))^2 + 
                                     (node$YY - parent(node$YY))^2 +
                                     (node$ZZ - parent(node$ZZ))^2), 
           .symbol = "N")
MTG_auto$node_2$length = 0.0
mutate_mtg(MTG_corr, length = sqrt((node$XX - parent(node$XX))^2 + 
                                     (node$YY - parent(node$YY))^2 +
                                     (node$ZZ - parent(node$ZZ))^2), 
           .symbol = "N")
MTG_corr$node_2$length = 0.0
MTG_corr_df = data.tree::ToDataFrameNetwork(MTG_corr,"length")
MTG_auto_df = data.tree::ToDataFrameNetwork(MTG_auto,"length")



sum(MTG_auto_df$length)-sum(MTG_corr_df$length)
sum(MTG_auto_df$length)/sum(MTG_corr_df$length)


    
MTG_auto_df[is.na(MTG_auto_df$length),]