# clean up Cofco data to get sum of indicators over each year and muni
# indicators: FOB_USD and SOY_EQUIVALENT_TONNES

cofco_raw <- read.csv('~/Documents/R-code/Avery Work/Cofco_Raw.csv')

# empty vector to fill in with indicators
# will this be saved in Jupyter?

FOB_2014 <- numeric(0)
TONS_2014 <- numeric(0)
Muni_2014 <- numeric(0)

FOB_2015 <- numeric(0)
TONS_2015 <- numeric(0)
Muni_2015 <- numeric(0)

FOB_2016 <- numeric(0)
TONS_2016 <- numeric(0)
Muni_2016 <- numeric(0)

FOB_2017 <- numeric(0)
TONS_2017 <- numeric(0)
Muni_2017 <- numeric(0)

# get each year's unique municipalities
cofco_2014 <- cofco_raw[cofco_raw$YEAR == 2014,]
munis_2014 <- unique(cofco_2014$MUNICIPALITY)

cofco_2015 <- cofco_raw[cofco_raw$YEAR == 2015,]
munis_2015 <- unique(cofco_2015$MUNICIPALITY)

cofco_2016 <- cofco_raw[cofco_raw$YEAR == 2016,]
munis_2016 <- unique(cofco_2016$MUNICIPALITY)

cofco_2017 <- cofco_raw[cofco_raw$YEAR == 2017,]
munis_2017 <- unique(cofco_2017$MUNICIPALITY)

# sum indicators for each muni-year
for (muni in munis_2014) {
  # this gets the muni for only the year of interest
  indeces <- which(cofco_2014$MUNICIPALITY %in% muni) #muni == cofco_raw$MUNICIPALITY #match(muni, cofco_raw$MUNICIPALITY)

  # calculate indeces for muni-year
  summed_FOB <- sum(cofco_raw$FOB_USD[indeces])
  summed_TONS <- sum(cofco_raw$SOY_EQUIVALENT_TONNES[indeces])

  # save result for later export
  FOB_2014 <- c(FOB_2014, summed_FOB)
  TONS_2014 <- c(TONS_2014, summed_TONS)
  Muni_2014 <- c(Muni_2014, muni)
}

for (muni in munis_2015) {
  # this gets the muni for only the year of interest
  indeces <- which(cofco_2015$MUNICIPALITY %in% muni) #muni == cofco_raw$MUNICIPALITY #match(muni, cofco_raw$MUNICIPALITY)
  
  # calculate indeces for muni-year
  summed_FOB <- sum(cofco_raw$FOB_USD[indeces])
  summed_TONS <- sum(cofco_raw$SOY_EQUIVALENT_TONNES[indeces])
  
  # save result for later export
  FOB_2015 <- c(FOB_2015, summed_FOB)
  TONS_2015 <- c(TONS_2015, summed_TONS)
  Muni_2015 <- c(Muni_2015, muni)
}

for (muni in munis_2016) {
  # this gets the muni for only the year of interest
  indeces <- which(cofco_2016$MUNICIPALITY %in% muni) #muni == cofco_raw$MUNICIPALITY #match(muni, cofco_raw$MUNICIPALITY)
  
  # calculate indeces for muni-year
  summed_FOB <- sum(cofco_raw$FOB_USD[indeces])
  summed_TONS <- sum(cofco_raw$SOY_EQUIVALENT_TONNES[indeces])
  
  # save result for later export
  FOB_2016 <- c(FOB_2016, summed_FOB)
  TONS_2016 <- c(TONS_2016, summed_TONS)
  Muni_2016 <- c(Muni_2016, muni)
}

for (muni in munis_2017) {
  # this gets the muni for only the year of interest
  indeces <- which(cofco_2017$MUNICIPALITY %in% muni) #muni == cofco_raw$MUNICIPALITY #match(muni, cofco_raw$MUNICIPALITY)
  
  # calculate indeces for muni-year
  summed_FOB <- sum(cofco_raw$FOB_USD[indeces])
  summed_TONS <- sum(cofco_raw$SOY_EQUIVALENT_TONNES[indeces])
  
  # save result for later export
  FOB_2017 <- c(FOB_2017, summed_FOB)
  TONS_2017 <- c(TONS_2017, summed_TONS)
  Muni_2017 <- c(Muni_2017, muni)
}

# create year vectors
Year_2014 <- rep(2014, length(munis_2014))
Year_2015 <- rep(2015, length(munis_2015))
Year_2016 <- rep(2016, length(munis_2016))
Year_2017 <- rep(2017, length(munis_2017))

# combine vectors into data frames
export_2014 <- data.frame(Year = Year_2014, Muni = munis_2014, FOB = FOB_2014, TONS = TONS_2014)
export_2015 <- data.frame(Year = Year_2015, Muni = munis_2015, FOB = FOB_2015, TONS = TONS_2015)
export_2016 <- data.frame(Year = Year_2016, Muni = munis_2016, FOB = FOB_2016, TONS = TONS_2016)
export_2017 <- data.frame(Year = Year_2017, Muni = munis_2017, FOB = FOB_2017, TONS = TONS_2017)
export_full = rbind(export_2014, export_2015, export_2016, export_2017)

write.csv(export_full, file = "~/Documents/R-code/Avery Work/Cofco_Cleaned.csv")