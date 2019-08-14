delete_cols_median_cell <- function(median_cell_raw) {
  output = subset(median_cell_raw, select = -c(double_area_km2_median, 
                                               double_delay_sum, double_harvest_sum, double_plant_sum,
                                               label, latitude_sum, longitude_sum, 
                                               onset_historicalRange_sum, onset_sum, single_area_km2_median,
                                               single_delay_sum, single_harvest_sum, single_plant_sum,
                                               total_planted_area_km2_median, year_sum, Muni_code_sum) )
  return(output)
}

rename_cols_median_cell <- function(median_cell) {
  output = median_cell %>% 
    rename(
      double_area_km2 = double_area_km2_sum,
      double_delay = double_delay_median,
      double_harvest = double_harvest_median,
      double_plant = double_plant_median,
      latitude = latitude_median,
      longitude = longitude_median,
      onset_historicalRange = onset_historicalRange_median,
      onset = onset_median,
      single_area_km2 = single_area_km2_sum,
      single_delay = single_delay_median,
      single_harvest = single_harvest_median,
      single_plant = single_plant_median,
      total_planted_area_km2 = total_planted_area_km2_sum,
      Muni_code = Muni_code_median,
      year = year_median
    ) %>%
    filter(year > 0)
  return(output)
}

rename_cols_median_muni <- function(median_muni_raw) {
  output = median_muni_raw %>%
    rename(
      double_area_km2 = double_area_km2_sum,
      double_delay = double_delay_median,
      double_harvest = double_harvest_median,
      double_plant = double_plant_median,
      latitude = latitude_median,
      longitude = longitude_median,
      onset_historicalRange = onset_historicalRange_median,
      onset = onset_median,
      single_area_km2 = single_area_km2_sum,
      single_delay = single_delay_median,
      single_harvest = single_harvest_median,
      single_plant = single_plant_median,
      total_planted_area_km2 = total_planted_area_km2_sum,
      year = year_median
    ) %>%
    filter(year > 0)
  return(output)
}

rename_cols_median_CARpoly <- function(median_CARpoly_raw) {
  output = median_CARpoly_raw %>%
    rename(
      double_area_km2 = double_area_km2_sum,
      double_delay = double_delay_median,
      double_harvest = double_harvest_median,
      double_plant = double_plant_median,
      latitude = latitude_median,
      longitude = longitude_median,
      onset_historicalRange = onset_historicalRange_median,
      onset = onset_median,
      single_area_km2 = single_area_km2_sum,
      single_delay = single_delay_median,
      single_harvest = single_harvest_median,
      single_plant = single_plant_median,
      total_planted_area_km2 = total_planted_area_km2_sum,
      year = year_median
    ) %>%
    filter(year > 0)
  
  return(output)
  
}

tidy_by_intensity_plant <- function(data, SC_name, DC_name) {
  output = data %>%
    gather(DC_name, SC_name, key = "intensity", value = "plant") %>%
    mutate_if(is.character, 
              str_replace_all, pattern = DC_name, replacement = "DC") %>%
    mutate_if(is.character, 
              str_replace_all, pattern = SC_name, replacement = "SC")
  
  return(output)
}

tidy_by_intensity_delay <- function(data, SC_name, DC_name) {
  output = data %>%
    gather(DC_name, SC_name, key = "intensity", value = "delay") %>%
    mutate_if(is.character, 
              str_replace_all, pattern = DC_name, replacement = "DC") %>%
    mutate_if(is.character, 
              str_replace_all, pattern = SC_name, replacement = "SC")
  
  return(output)
}

combine_variables_cell <- function(median_cell_plant, median_cell_delay,
                                   percentile5_cell_plant, percentile5_cell_delay,
                                   percentile95_cell_plant, percentile95_cell_delay) {
  output <- cbind(median_cell_plant, median_cell_delay$delay, 
                  percentile5_cell_plant$plant, percentile5_cell_delay$delay,
                  percentile95_cell_plant$plant, percentile95_cell_delay$delay)
  colnames(output)[colnames(output)=="plant"] <- "plant_median"
  colnames(output)[colnames(output)=="percentile5_cell_plant$plant"] <- "plant_percentile5"
  colnames(output)[colnames(output)=="percentile95_cell_plant$plant"] <- "plant_percentile95"
  colnames(output)[colnames(output)=="median_cell_delay$delay"] <- "delay_median"
  colnames(output)[colnames(output)=="percentile5_cell_delay$delay"] <- "delay_percentile5"
  colnames(output)[colnames(output)=="percentile95_cell_delay$delay"] <- "delay_percentile95"
  
  output$intensity_num[output$intensity == "DC"] <- 1
  output$intensity_num[output$intensity == "SC"] <- 0
  
  return(output)
}

combine_variables_muni <- function(median_muni_plant, median_muni_delay,
                                   percentile5_muni_plant, percentile5_muni_delay,
                                   percentile95_muni_plant, percentile95_muni_delay) {
  
  output <- cbind(median_muni_plant, median_muni_delay$delay, 
                  percentile5_muni_plant$plant, percentile5_muni_delay$delay,
                  percentile95_muni_plant$plant, percentile95_muni_delay$delay)
  
  colnames(output)[colnames(output)=="plant"] <- "plant_median"
  colnames(output)[colnames(output)=="percentile5_muni_plant$plant"] <- "plant_percentile5"
  colnames(output)[colnames(output)=="percentile95_muni_plant$plant"] <- "plant_percentile95"
  colnames(output)[colnames(output)=="median_muni_delay$delay"] <- "delay_median"
  colnames(output)[colnames(output)=="percentile5_muni_delay$delay"] <- "delay_percentile5"
  colnames(output)[colnames(output)=="percentile95_muni_delay$delay"] <- "delay_percentile95"
  output$intensity_num[output$intensity == "DC"] <- 1
  output$intensity_num[output$intensity == "SC"] <- 0
  
  return(output)
}

combine_variables_CARpoly <- function(median_CARpoly_plant, median_CARpoly_delay,
                                      percentile5_CARpoly_plant, percentile5_CARpoly_delay,
                                      percentile95_CARpoly_plant, percentile95_CARpoly_delay) {
  output <- cbind(median_CARpoly_plant, median_CARpoly_delay$delay, 
                  percentile5_CARpoly_plant$plant, percentile5_CARpoly_delay$delay,
                  percentile95_CARpoly_plant$plant, percentile95_CARpoly_delay$delay)
  
  colnames(output)[colnames(output)=="plant"] <- "plant_median"
  colnames(output)[colnames(output)=="percentile5_CARpoly_plant$plant"] <- "plant_percentile5"
  colnames(output)[colnames(output)=="percentile95_CARpoly_plant$plant"] <- "plant_percentile95"
  colnames(output)[colnames(output)=="median_CARpoly_delay$delay"] <- "delay_median"
  colnames(output)[colnames(output)=="percentile5_CARpoly_delay$delay"] <- "delay_percentile5"
  colnames(output)[colnames(output)=="percentile95_CARpoly_delay$delay"] <- "delay_percentile95"
  output$intensity_num[output$intensity == "DC"] <- 1
  output$intensity_num[output$intensity == "SC"] <- 0
  
  return(output)
}

tidy_combine_cell <- function(median_cell, percentile5_cell, percentile95_cell) {
  median_cell_plant <- median_cell %>% tidy_by_intensity_plant("single_plant", "double_plant") %>%
    select(-c(single_delay, double_delay, single_harvest, double_harvest))
  
  median_cell_delay <- median_cell %>% tidy_by_intensity_delay("single_delay", "double_delay") %>%
    select(-c(single_plant, double_plant, single_harvest, double_harvest))
  
  percentile5_cell_plant <- percentile5_cell %>% tidy_by_intensity_plant("single_plant", "double_plant") %>%
    select(-c(single_delay, double_delay, single_harvest, double_harvest))
  
  percentile5_cell_delay <- percentile5_cell %>% tidy_by_intensity_delay("single_delay", "double_delay") %>%
    select(-c(single_plant, double_plant, single_harvest, double_harvest))
  
  percentile95_cell_plant <- percentile95_cell %>% tidy_by_intensity_plant("single_plant", "double_plant") %>%
    select(-c(single_delay, double_delay, single_harvest, double_harvest))
  
  percentile95_cell_delay <- percentile95_cell %>% tidy_by_intensity_delay("single_delay", "double_delay") %>%
    select(-c(single_plant, double_plant, single_harvest, double_harvest))
  
  # combine together
  cell_tidy <- combine_variables_cell(median_cell_plant, median_cell_delay,
                                      percentile5_cell_plant, percentile5_cell_delay,
                                      percentile95_cell_plant, percentile95_cell_delay)
  
  return(cell_tidy)
}

tidy_combine_muni <- function(median_muni, percentile5_muni, percentile95_muni) {
  
  median_muni_plant <- median_muni %>% tidy_by_intensity_plant("single_plant", "double_plant") %>%
    select(-c(single_delay, double_delay, single_harvest, double_harvest))
  
  median_muni_delay <- median_muni %>% tidy_by_intensity_delay("single_delay", "double_delay") %>%
    select(-c(single_plant, double_plant, single_harvest, double_harvest))
  
  percentile5_muni_plant <- percentile5_muni %>% tidy_by_intensity_plant("single_plant", "double_plant") %>%
    select(-c(single_delay, double_delay, single_harvest, double_harvest))
  
  percentile5_muni_delay <- percentile5_muni %>% tidy_by_intensity_delay("single_delay", "double_delay") %>%
    select(-c(single_plant, double_plant, single_harvest, double_harvest))
  
  percentile95_muni_plant <- percentile95_muni %>% tidy_by_intensity_plant("single_plant", "double_plant") %>%
    select(-c(single_delay, double_delay, single_harvest, double_harvest))
  
  percentile95_muni_delay <- percentile95_muni %>% tidy_by_intensity_delay("single_delay", "double_delay") %>%
    select(-c(single_plant, double_plant, single_harvest, double_harvest)) 
  
  # combine together
  muni_tidy <- combine_variables_muni(median_muni_plant, median_muni_delay,
                                      percentile5_muni_plant, percentile5_muni_delay,
                                      percentile95_muni_plant, percentile95_muni_delay)
  
  return(muni_tidy)
}

tidy_combine_CARpoly <- function(median_CARpoly, percentile5_CARpoly, percentile95_CARpoly) {
  median_CARpoly_plant <- median_CARpoly %>% tidy_by_intensity_plant("single_plant", "double_plant") %>%
    select(-c(single_delay, double_delay, single_harvest, double_harvest))
  
  median_CARpoly_delay <- median_CARpoly %>% tidy_by_intensity_delay("single_delay", "double_delay") %>%
    select(-c(single_plant, double_plant, single_harvest, double_harvest))
  
  percentile5_CARpoly_plant <- percentile5_CARpoly %>% tidy_by_intensity_plant("single_plant", "double_plant") %>%
    select(-c(single_delay, double_delay, single_harvest, double_harvest))
  
  percentile5_CARpoly_delay <- percentile5_CARpoly %>% tidy_by_intensity_delay("single_delay", "double_delay") %>%
    select(-c(single_plant, double_plant, single_harvest, double_harvest))
  
  percentile95_CARpoly_plant <- percentile95_CARpoly %>% tidy_by_intensity_plant("single_plant", "double_plant") %>%
    select(-c(single_delay, double_delay, single_harvest, double_harvest))
  
  percentile95_CARpoly_delay <- percentile95_CARpoly %>% tidy_by_intensity_delay("single_delay", "double_delay") %>%
    select(-c(single_plant, double_plant, single_harvest, double_harvest)) 
  
  # combine together
  CARpoly_tidy <- combine_variables_CARpoly(median_CARpoly_plant, median_CARpoly_delay,
                                            percentile5_CARpoly_plant, percentile5_CARpoly_delay,
                                            percentile95_CARpoly_plant, percentile95_CARpoly_delay)
  return(CARpoly_tidy)
}

categorize_vars_cell_tidy <- function(cell_tidy) {
  
  cell_onset_cutoffs = quantile(cell_tidy$onset, c(0,1/3,2/3,1), na.rm = TRUE)
  cell_onset_cutoffs[1] = cell_onset_cutoffs[1]-1
  cell_lat_cutoffs = quantile(cell_tidy$latitude, c(0,1/3,2/3,1), na.rm = TRUE)
  cell_lat_cutoffs[1] = cell_lat_cutoffs[1]-1
  cell_delay_cutoffs = quantile(cell_tidy$delay_median, c(0,1/3,2/3,1), na.rm = TRUE)
  cell_delay_cutoffs[1] = cell_delay_cutoffs[1]-1
  
  cell_tidy <- cell_tidy %>% mutate(onset_category=cut(onset, breaks = cell_onset_cutoffs, 
                                                       labels=c("early_onset","middle_onset","late_onset"))) %>%
    mutate(lat_category=cut(latitude, breaks = cell_lat_cutoffs, 
                            labels=c("south","central","north"))) %>%
    mutate(delay_category=cut(delay_median, breaks = cell_delay_cutoffs, 
                              labels=c("short_delay","middle_delay","long_delay")))
  
  return(cell_tidy)
}

categorize_vars_cell_untidy <- function(median_cell) {
  cell_onset_cutoffs = quantile(median_cell$onset, c(0,1/3,2/3,1), na.rm = TRUE)
  cell_onset_cutoffs[1] = cell_onset_cutoffs[1]-1
  cell_lat_cutoffs = quantile(median_cell$latitude, c(0,1/3,2/3,1), na.rm = TRUE)
  cell_lat_cutoffs[1] = cell_lat_cutoffs[1]-1
  
  median_cell <- median_cell %>% mutate(onset_category=cut(onset, breaks = cell_onset_cutoffs, 
                                                           labels=c("early_onset","middle_onset","late_onset"))) %>%
    mutate(lat_category=cut(latitude, breaks = cell_lat_cutoffs, 
                            labels=c("south","central","north")))
  
  return(median_cell)
}

categorize_vars_muni_tidy <- function(muni_tidy) {
  
  muni_onset_cutoffs = quantile(muni_tidy$onset, c(0,1/3,2/3,1), na.rm = TRUE)
  muni_onset_cutoffs[1] = muni_onset_cutoffs[1]-1
  muni_lat_cutoffs = quantile(muni_tidy$latitude, c(0,1/3,2/3,1), na.rm = TRUE)
  muni_lat_cutoffs[1] = muni_lat_cutoffs[1]-1
  muni_delay_cutoffs = quantile(muni_tidy$delay_median, c(0,1/3,2/3,1), na.rm = TRUE)
  muni_delay_cutoffs[1] = muni_delay_cutoffs[1]-1
  
  muni_tidy <- muni_tidy %>% mutate(onset_category=cut(onset, breaks = muni_onset_cutoffs, 
                                                       labels=c("early_onset","middle_onset","late_onset"))) %>%
    mutate(lat_category=cut(latitude, breaks = muni_lat_cutoffs, 
                            labels=c("south","central","north"))) %>%
    mutate(delay_category=cut(delay_median, breaks = muni_delay_cutoffs, 
                              labels=c("short_delay","middle_delay","long_delay")))
  
  return(muni_tidy)
}

categorize_vars_muni_untidy <- function(median_muni) {
  muni_onset_cutoffs = quantile(median_muni$onset, c(0,1/3,2/3,1), na.rm = TRUE)
  muni_onset_cutoffs[1] = muni_onset_cutoffs[1]-1
  muni_lat_cutoffs = quantile(median_muni$latitude, c(0,1/3,2/3,1), na.rm = TRUE)
  muni_lat_cutoffs[1] = muni_lat_cutoffs[1]-1
  
  median_muni <- median_muni %>% mutate(onset_category=cut(onset, breaks = muni_onset_cutoffs, 
                                                           labels=c("early_onset","middle_onset","late_onset"))) %>%
    mutate(lat_category=cut(latitude, breaks = muni_lat_cutoffs, 
                            labels=c("south","central","north")))
  
  return(median_muni)
}

categorize_vars_CARpoly_tidy <- function(CARpoly_tidy) {
  CARpoly_onset_cutoffs = quantile(CARpoly_tidy$onset, c(0,1/3,2/3,1), na.rm = TRUE)
  CARpoly_onset_cutoffs[1] = CARpoly_onset_cutoffs[1]-1
  CARpoly_lat_cutoffs = quantile(CARpoly_tidy$latitude, c(0,1/3,2/3,1), na.rm = TRUE)
  CARpoly_lat_cutoffs[1] = CARpoly_lat_cutoffs[1]-1
  CARpoly_delay_cutoffs = quantile(CARpoly_tidy$delay_median, c(0,1/3,2/3,1), na.rm = TRUE)
  CARpoly_delay_cutoffs[1] = CARpoly_delay_cutoffs[1]-1
  CARpoly_area_cutoffs = quantile(CARpoly_tidy$poly_area_km2, c(0,1/3,2/3,1), na.rm = TRUE)
  CARpoly_area_cutoffs[1] = CARpoly_area_cutoffs[1]-1
  
  CARpoly_tidy <- CARpoly_tidy %>% mutate(onset_category=cut(onset, breaks = CARpoly_onset_cutoffs, 
                                                             labels=c("early_onset","middle_onset","late_onset"))) %>%
    mutate(lat_category=cut(latitude, breaks = CARpoly_lat_cutoffs, 
                            labels=c("south","central","north"))) %>%
    mutate(delay_category=cut(delay_median, breaks = CARpoly_delay_cutoffs, 
                              labels=c("short_delay","middle_delay","long_delay"))) %>%
    mutate(area_category=cut(poly_area_km2, breaks = CARpoly_area_cutoffs, 
                             labels=c("small_property","middle_property","large_property")))
  
  return(CARpoly_tidy)
}

categorize_vars_CARpoly_untidy <- function(median_CARpoly) {
  CARpoly_onset_cutoffs = quantile(median_CARpoly$onset, c(0,1/3,2/3,1), na.rm = TRUE)
  CARpoly_onset_cutoffs[1] = CARpoly_onset_cutoffs[1]-1
  CARpoly_lat_cutoffs = quantile(median_CARpoly$latitude, c(0,1/3,2/3,1), na.rm = TRUE)
  CARpoly_lat_cutoffs[1] = CARpoly_lat_cutoffs[1]-1
  CARpoly_area_cutoffs = quantile(median_CARpoly$poly_area_km2, c(0,1/3,2/3,1), na.rm = TRUE)
  CARpoly_area_cutoffs[1] = CARpoly_area_cutoffs[1]-1
  
  median_CARpoly <- median_CARpoly %>% mutate(onset_category=cut(onset, breaks = CARpoly_onset_cutoffs, 
                                                                 labels=c("early_onset","middle_onset","late_onset"))) %>%
    mutate(lat_category=cut(latitude, breaks = CARpoly_lat_cutoffs, 
                            labels=c("south","central","north"))) %>%
    mutate(area_category=cut(poly_area_km2, breaks = CARpoly_area_cutoffs, 
                             labels=c("small_property","middle_property","large_property")))
  
  return(median_CARpoly)
}