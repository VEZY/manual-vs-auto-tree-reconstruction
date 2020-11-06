
#' Compute total length difference
#' 
#' Compute the relative and absolute error between two branches 
#'
#' @param file_auto Automatic reconstructed branch
#' @param file_corr Automatic + corrected branch 
#'
#' @return A list withe the relative (%) and absolute (m) difference between branches length
#' @export
corr_branch_diff = function(file_auto,file_corr){
  MTG_auto = read_mtg(file_auto)
  MTG_corr = read_mtg(file_corr)
  
  # Compute node length from coordinates:
  mutate_mtg(MTG_auto, length = sqrt((node$XX - parent(node$XX))^2 + 
                                       (node$YY - parent(node$YY))^2 +
                                       (node$ZZ - parent(node$ZZ))^2), 
             .symbol = "N")
  # First node is a plant node, so first real node of interest is the second:
  MTG_auto$node_2$length = 0.0

  mutate_mtg(MTG_corr, length = sqrt((node$XX - parent(node$XX))^2 + 
                                       (node$YY - parent(node$YY))^2 +
                                       (node$ZZ - parent(node$ZZ))^2), 
             .symbol = "N")
  MTG_corr$node_2$length = 0.0

  # Transform to data.frame:
  MTG_corr_df = data.tree::ToDataFrameNetwork(MTG_corr,"length")
  MTG_auto_df = data.tree::ToDataFrameNetwork(MTG_auto,"length")
  
  # Compute statistics:
  error_abs = sum(MTG_auto_df$length)-sum(MTG_corr_df$length)
  error_rel = (1-sum(MTG_corr_df$length)/sum(MTG_auto_df$length))*100
  
  list(relative = error_rel, absolute = error_abs)
}



