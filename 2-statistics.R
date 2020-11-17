# Purpose: Compute statistics, e.g. error in length and/or biomass
# Author: T. Burel & R. Vezy
# Date: 17/11/2020



# Import csv files --------------------------------------------------------

csv_files = list.files("3-outputs/branches_df", full.names = TRUE)

dfs = 
  lapply(csv_files, function(x){
    data.table::fread(x,data.table = FALSE)
  })
names(dfs) = gsub(".csv","", basename(csv_files))


# Compute statistics:

error_abs = sum(MTG_auto_df$length)-sum(MTG_corr_df$length)
error_rel = (1-sum(MTG_corr_df$length)/sum(MTG_auto_df$length))*100

error_abs_vol = sum(MTG_auto_df$volume)-sum(MTG_corr_df$volume)
error_rel_vol = (1-sum(MTG_corr_df$volume)/sum(MTG_auto_df$volume))*100

error_abs_biomass = sum(MTG_auto_df$biomass)-sum(MTG_corr_df$biomass)
error_rel_biomass = (1-sum(MTG_corr_df$biomass)/sum(MTG_auto_df$biomass))*100

list(rel_err_length = error_rel, abs_err_length = error_abs,
     rel_err_volume = error_rel_vol, abs_err_volume = error_abs_vol,
     rel_err_biomass = error_rel_biomass,
     abs_err_biomass = error_abs_biomass,
     df_auto = MTG_auto_df, df_corr = MTG_corr_df)





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

