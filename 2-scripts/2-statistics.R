# Purpose: Compute statistics, e.g. error in length and/or biomass
# Author: T. Burel & R. Vezy
# Date: 17/11/2020


library(data.table)
library(tidyverse)
library(reshape2)

# Import csv files --------------------------------------------------------

dfs = fread("3-outputs/branches_df/total.csv",data.table = FALSE)

# Compute statistics:

dfs%>%
  select(-from,-to)%>%
  reshape2::melt(c("branch","reconstruction"))%>%
  ggplot(.,aes(y = value, x = branch, color = reconstruction))+
  facet_wrap(variable~.,scales = "free_y")+
  geom_boxplot()

# Number of nodes before and after correction;
dfs%>%
  group_by(branch,reconstruction)%>%
  summarise(number_nodes = n())

dfs%>%
  ggplot(.,aes(x = length, color = reconstruction))+
  facet_wrap(branch~., scales = "free_y")+
  geom_freqpoly()

dfs%>%
  ggplot(.,aes(x = radius, color = reconstruction))+
  facet_wrap(branch~., scales = "free_y")+
  geom_freqpoly()

dfs%>%
  ggplot(.,aes(x = biomass, color = reconstruction))+
  facet_wrap(branch~., scales = "free_y")+
  geom_freqpoly(binwidth = 0.005)

dfs%>%
  ggplot(.,aes(x = biomass, fill = reconstruction))+
  facet_wrap(branch~., scales = "free_y")+
  geom_histogram(binwidth = 0.005)

dfs%>%
  ggplot(.,aes(y = biomass, x = radius,
               color = reconstruction))+
  facet_wrap(branch~., scales = "free_y")+
  geom_point()



df_stats = 
  dfs%>%
  group_by(branch,reconstruction)%>%
  summarise(length = sum(length),
            # volume = sum(volume),
            biomass = sum(biomass))%>%
  reshape2::melt(c("branch","reconstruction"))%>%
  reshape2::dcast(branch+variable~reconstruction)%>%
  group_by(branch,variable)%>%
  summarise(automatic = sum(automatic),
            corrected = sum(corrected),
            error_abs = automatic-corrected,
            error_rel = (1-corrected/automatic)*100)

# Boxplot with relative error per variable and branch
ggplot(df_stats, aes(x = variable, y = error_rel))+
  geom_boxplot()+
  geom_point(aes(color = branch))+
  ylab("Relative error (%)")+
  labs(color = "Branch")

stats = boxplot(df_stats$error_rel~df_stats$variable, plot= FALSE)$stats[3,]


# Why we don't estimate well biomass for some branches? 

dfs%>%
  ggplot(.,aes(x = length, color = reconstruction))+
  facet_wrap(branch~., scales = "free")+
  geom_density(aes(fill = reconstruction), alpha=0.4)

ggsave(filename = "fig_4.png", path = "3-outputs/plots",
      width = 16.0, height = 8, units = "cm")

# Good in general in the plot just before, but we see here 
# that short nodes are not well estimated at all (<2.5 cm),
# and that some lengths are almost absent in some branches.

dfs%>%
  ggplot(.,aes(x = radius, color = reconstruction))+
  facet_wrap(branch~., scales = "free")+
  geom_density(aes(fill = reconstruction), alpha=0.4)
# Radius OK in general, but A1B1 have few nodes with 
# very high values, which leads to high biomass then.

dfs%>%
  ggplot(.,aes(x = biomass, color = reconstruction))+
  facet_wrap(branch~., scales = "free")+
  geom_density(aes(fill = reconstruction), alpha=0.4)

# A1B2: a lot of corrections was done for nodes with very little 
# biomass. But some nodes with very high biomass leads 
# to an overall overestimation of the biomass (error at the branch
# base).


# Average error -----------------------------------------------------------

df_stats%>%
  group_by(variable)%>%
  summarise(error_mean = mean(error_rel),
            error_sd = sd(error_rel),
            error_median = median(error_rel))

# 5.20% +/- 10.4
