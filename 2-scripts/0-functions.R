
#' Compute total length difference
#' 
#' Compute the relative and absolute error between two branches 
#'
#' @param file_auto Automatic reconstructed branch
#' @param file_corr Automatic + corrected branch 
#' @param wood_density Wood density used to compute the biomass (default to 0.5)
#'
#' @return A list withe the relative (%) and absolute (m) difference between branches length
#' @export
corr_branch_diff = function(file_auto,file_corr,wood_density = 0.5){
  MTG_auto = read_mtg(file_auto)
  MTG_corr = read_mtg(file_corr)
  
  # Compute node length from coordinates:
  mutate_mtg(MTG_auto, 
             length = sqrt((node$XX - parent(node$XX))^2 + 
                             (node$YY - parent(node$YY))^2 +
                             (node$ZZ - parent(node$ZZ))^2),
             radius_parent = parent(node$radius),
             volume = (node$length*pi/3)*(node$radius_parent^2 + node$radius^2 +
                                            node$radius_parent * node$radius),
             .symbol = "N")
  
  # First node is a plant node, so first real node of interest is the second:
  MTG_auto$node_2$length = 0.0
  MTG_auto$node_2$volume = 0.0

  mutate_mtg(MTG_corr, length = sqrt((node$XX - parent(node$XX))^2 + 
                                       (node$YY - parent(node$YY))^2 +
                                       (node$ZZ - parent(node$ZZ))^2),
             radius_parent = parent(node$radius),
             volume = (node$length*pi/3)*(node$radius_parent^2 + node$radius^2 +
                                            node$radius_parent * node$radius), 
             .symbol = "N")
  
  MTG_corr$node_2$length = 0.0
  MTG_corr$node_2$volume = 0.0
  
  # Transform to data.frame:
  MTG_corr_df = data.tree::ToDataFrameNetwork(MTG_corr,"length","volume","radius")
  MTG_auto_df = data.tree::ToDataFrameNetwork(MTG_auto,"length","volume","radius")
  
  # Biomass in kg
  MTG_corr_df$biomass = MTG_corr_df$volume*wood_density*1000
  MTG_auto_df$biomass = MTG_auto_df$volume*wood_density*1000
  
  dplyr::bind_rows(corrected = MTG_corr_df, 
                   automatic = MTG_auto_df,
                   .id = "reconstruction")
}
