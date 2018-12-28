library('parallel')
library('rJava')
library("tabulizer")
library("dplyr")
library("tibble")
library('data.table')
library('stringr')

# Location of soy planting files of interest
soyp9 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/081211_IPS.pdf'
soyp10_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/09_11_26_IAPSoja.pdf'
soyp10_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/09_12_03_APSoja.pdf'
# soyp11_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/10_11_11_IPSoja.pdf'
# soyp11_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/10_12_02_IPSoja.pdf'
# soyp12_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2011_11_24_IPSoja.pdf'
# soyp12_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2011_12_01_IPSoja.pdf'
# soyp13 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Pantio_Safra_12-13_11-29.pdf'
# soyp14_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_28__11_13_Tratamento_Semeadura_13-14.pdf'
# soyp14_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404__05_12_13_Tratamento_semeadura_13-14.pdf'
# soyp15 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404__14_12_11_Tratamento_plantio_14-15.pdf'
# soyp16 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404__15_01_14_Relatorio_Semeadura_15-16.pdf'
# soyp17 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/16122016130906.pdf'
# soyp18 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/15122017180857.pdf'
# soyp19 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/23112018162346.pdf'

# Location of soy harvest files of interest
soyh9_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090108_IACS.pdf'
soyh9_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090115_IACS.pdf'
soyh9_3 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090122_IACS.pdf' 
soyh9_4 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090129_IACS.pdf'
soyh9_5 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090205_IACS.pdf'
soyh9_6 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090212_IACS.pdf'
soyh9_7 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090219_IACS.pdf'
soyh9_8 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090226_IACS.pdf'
soyh9_9 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090305_IACS.pdf'
soyh9_10 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090312_IACS.pdf'
soyh9_11 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090319_IACS.pdf'
soyh9_12 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090326_IACS.pdf'
soyh9_13 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090401_IACS.pdf'
soyh9_14 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090409_IACS.pdf'
soyh10 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2010_04_15_ICS.pdf'
# soyh11_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/11_02_18_ICSoja.pdf'
# soyh11_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/11_04_14_ICSoja.pdf'
# soyh12_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2012_04_05_ICSoja.pdf'
# soyh12_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2012_04_12_ICSoja.pdf'
# soyh13 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Colheita_Safra_12-13_04-18.pdf'
# soyh14 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Colheita_Safra_13-14_17-04.pdf'
# soyh15 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Colheita_Safra_14-15_30-04.pdf'
# soyh16 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Colheita_Safra_15-16_04-29.pdf'
# soyh17 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/28042017140741.pdf'
# soyh18 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/04052018194311.pdf'


# Extract soy planting tables
outsoyp9 <- extract_tables(soyp9)
outsoyp10_1 <- extract_tables(soyp10_1)
outsoyp10_2 <- extract_tables(soyp10_2)
# outsoyp11_1 <- extract_tables(soyp11_1)
# outsoyp11_2 <- extract_tables(soyp11_2)
# outsoyp12_1 <- extract_tables(soyp12_1)
# outsoyp12_2 <- extract_tables(soyp12_2)
# outsoyp13 <- extract_tables(soyp13)
# outsoyp14_1 <- extract_tables(soyp14_1)
# outsoyp14_2 <- extract_tables(soyp14_2)
# outsoyp15 <- extract_tables(soyp15)
# outsoyp16 <- extract_tables(soyp16)
# outsoyp17 <- extract_tables(soyp17)
# outsoyp18 <- extract_tables(soyp18)
# outsoyp19 <- extract_tables(soyp19)

print('extracted soy planting')

# Extract soy harvest tables
# outsoyh9_1 <- extract_tables(soyh9_1)
# outsoyh9_2 <- extract_tables(soyh9_2)
# outsoyh9_3 <- extract_tables(soyh9_3)
# outsoyh9_4 <- extract_tables(soyh9_4)
# outsoyh9_5 <- extract_tables(soyh9_5)
# outsoyh9_6 <- extract_tables(soyh9_6)
# outsoyh9_7 <- extract_tables(soyh9_7)
# outsoyh9_8 <- extract_tables(soyh9_8)
# outsoyh9_9 <- extract_tables(soyh9_9)
# outsoyh9_10 <- extract_tables(soyh9_10)
# outsoyh9_11 <- extract_tables(soyh9_11)
# outsoyh9_12 <- extract_tables(soyh9_12)
# outsoyh9_13 <- extract_tables(soyh9_13)
# outsoyh9_14 <- extract_tables(soyh9_14)
# outsoyh10 <- extract_tables(soyh10)
# outsoyh11_1 <- extract_tables(soyh11_1)
# outsoyh11_2 <- extract_tables(soyh11_2)
# outsoyh12_1 <- extract_tables(soyh12_1)
# outsoyh12_2 <- extract_tables(soyh12_2)
# outsoyh13 <- extract_tables(soyh13)
# outsoyh14 <- extract_tables(soyh14)
# outsoyh15 <- extract_tables(soyh15)
# outsoyh16 <- extract_tables(soyh16)
# outsoyh17 <- extract_tables(soyh17)
# outsoyh18 <- extract_tables(soyh18)

print('extracted soy harvest')

# Create individual data matrices for soy planting data
fsoyp9 <- do.call(rbind, outsoyp9)
fsoyp10_1 <- do.call(rbind, outsoyp10_1)
fsoyp10_2 <- do.call(rbind, outsoyp10_2)
# fsoyp11_1_1 <- do.call(rbind, outsoyp11_1[1])
# fsoyp11_1_2 <- do.call(rbind, outsoyp11_1[2])
# fsoyp11_2 <- do.call(rbind, outsoyp11_2)
# fsoyp12_1_1 <- do.call(rbind, outsoyp12_1[1])
# fsoyp12_2_2 <- do.call(rbind, outsoyp12_2[2])
# fsoyp13_1 <- do.call(rbind, outsoyp13[1])
# fsoyp13_2 <- do.call(rbind, outsoyp13[2])
# fsoyp14_1_1 <- do.call(rbind, outsoyp14_1[1])
# fsoyp14_1_2 <- do.call(rbind, outsoyp14_1[2])
# fsoyp14_2_1 <- do.call(rbind, outsoyp14_2[1])
# fsoyp14_2_2 <- do.call(rbind, outsoyp14_2[2])
# fsoyp15 <- do.call(rbind, outsoyp15)
# fsoyp16 <- do.call(rbind, outsoyp16)
# fsoyp17 <- do.call(rbind, outsoyp17)
# fsoyp18 <- do.call(rbind, outsoyp18)
# fsoyp19 <- do.call(rbind, outsoyp19)

print('fsoyp9 right after do.call')
print(head(fsoyp9))


#Data frames for soy planting data

#2009 soy planting
fsoyp9 <- as.data.frame(fsoyp9[3:nrow(fsoyp9), ], stringsAsFactors = FALSE)

print('fsoyp9 after as.data.frame')
print(head(fsoyp9))

hefsoyp9 <- c('Regions', 'Area_ha', '2008-12-04', 'three')
names(fsoyp9) <- hefsoyp9

print('before cleaning')
print(fsoyp9$Regions)

#2009 soy planting correcting spelling errors in Regions column

# START OF CHANGE --------------------------------------------------
region_names <- str_replace_all(iconv(fsoyp9$Regions, to = 'ASCII//TRANSLIT'), "[~^']", '') %>%
                str_replace_all("[ -]", '_') %>%
                str_replace_all('A\\.', 'Alto') %>%
                str_replace_all('Outras', 'Others') %>%
                str_replace_all('Outros', 'Others')
overall_regions <- c('Noroeste', 'Norte', 'Nordeste', 'Medio_Norte', 'Oeste', 'Centro_Sul', 'Sudeste') 

#loop through all the regions, if the region is 'Other', change the name. 
#ASSUMES ORDER OF REGIONS IS SAME FOR ALL FILES!
regionIndex <- 1
for (regionNameIndex in 1:length(region_names)) {
  regionName <- region_names[regionNameIndex]
  if (regionName == 'Others') {
    newRegionName <- paste0('Others_', overall_regions[regionIndex])
    region_names[regionNameIndex] <- newRegionName
    regionIndex <- regionIndex + 1
  }
}

fsoyp9$Regions <- region_names
print(fsoyp9$Regions)

# END OF CHANGE ---------------------------------------------------


fsoyp9[3, "Regions"] <- "Others_Noroeste"
fsoyp9[5, "Regions"] <- "Itauba"
fsoyp9[6, "Regions"] <- "Others_Norte"
fsoyp9[9, "Regions"] <- "Querencia"
fsoyp9[10, "Regions"] <- "Gaucha_do_Norte"
fsoyp9[12, "Regions"] <- "Others_Nordeste"
fsoyp9[13, "Regions"] <- "Medio_Norte"
fsoyp9[21, "Regions"] <- "Nova_Ubirata"
fsoyp9[23, "Regions"] <- "Sao_Jose_do_Rio_Claro"
fsoyp9[24, "Regions"] <- "Others_Medio_Norte"
fsoyp9[28, "Regions"] <- "Campos_de_Julio"
fsoyp9[29, "Regions"] <- "Others_Oeste"
fsoyp9[32, "Regions"] <- "Tangara_da_Serra"
fsoyp9[34, "Regions"] <- "Chapada_dos_Guimaraes"
fsoyp9[35, "Regions"] <- "Others_Centro_Sul"
fsoyp9[39, "Regions"] <- "Alto_Garcas_e_Alto_Taquari"
fsoyp9[42, "Regions"] <- "Others_Sudeste"

#Remove periods from thousands positions and convert Area_ha to numeric
fsoyp9$Area_ha <- gsub("\\.", "", fsoyp9$Area_ha)
fsoyp9 <- fsoyp9 %>%
  mutate(Area_ha = as.numeric(Area_ha))
#Change commas to periods in percentage columns
fsoyp9$`2008-12-04` <- gsub(",", "\\.", fsoyp9$`2008-12-04`)
fsoyp9$three <- gsub(",", "\\.", fsoyp9$three)
#remove percent signs
fsoyp9$`2008-12-04` <- gsub("%", "", fsoyp9$`2008-12-04`)
fsoyp9$three <- gsub("%", "", fsoyp9$three)
#convert date columns to numeric
fsoyp9$`2008-12-04` <- as.numeric(fsoyp9$`2008-12-04`)
fsoyp9$three <- as.numeric(fsoyp9$three)
#divide percentages by 100
fsoyp9$`2008-12-04` <- fsoyp9$`2008-12-04`/100
fsoyp9$three <- fsoyp9$three/100
#change column 3 name back to what it's supposed to be
colnames(fsoyp9)[3] <- "2008-12-11"
#Write final table to disk
write.csv(fsoyp9, file='soy_plant_2009_muni.csv', row.names=FALSE)

#2010 soy planting - setting as data frame - 1st file
fsoyp10_1 <- as.data.frame(fsoyp10_1[2:nrow(fsoyp10_1), ], stringsAsFactors = FALSE)
hefsoyp10_1 <- c('Regions', 'Area_ha', '2009-09-24', '2009-10-01', '2009-10-08',
                 '2009-10-15', '2009-10-22', '2009-10-29', '2009-11-05', '2009-11-12', '2009-11-19',
                 '2009-11-26')
names(fsoyp10_1) <- hefsoyp10_1

#2010 soy planting - erasing unnecessary rows, renmaing rows with errors, and removing
#columns that will be duplicated after merge with 2nd file - 1st file
fsoyp10_1_muni <- fsoyp10_1[-c(44, 45, 46, 47, 48, 49, 50, 51, 52, 53), ]
fsoyp10_1_muni[3, "Regions"] <- "Others_Noroeste"
fsoyp10_1_muni[5, "Regions"] <- "Itauba"
fsoyp10_1_muni[6, "Regions"] <- "Others_Norte"
fsoyp10_1_muni[9, "Regions"] <- "Querencia"
fsoyp10_1_muni[10, "Regions"] <- "Gaucha_do_Norte"
fsoyp10_1_muni[12, "Regions"] <- "Others_Nordeste"
fsoyp10_1_muni[13, "Regions"] <- "Medio_Norte"
fsoyp10_1_muni[21, "Regions"] <- "Nova_Ubirata"
fsoyp10_1_muni[23, "Regions"] <- "Sao_Jose_do_Rio_Claro"
fsoyp10_1_muni[24, "Regions"] <- "Others_Medio_Norte"
fsoyp10_1_muni[28, "Regions"] <- "Campos_de_Julio"
fsoyp10_1_muni[29, "Regions"] <- "Others_Oeste"
fsoyp10_1_muni[32, "Regions"] <- "Tangara_da_Serra"
fsoyp10_1_muni[34, "Regions"] <- "Chapada_dos_Guimaraes"
fsoyp10_1_muni[35, "Regions"] <- "Others_Centro_Sul"
fsoyp10_1_muni[39, "Regions"] <- "Alto_Garcas_e_Alto_Taquari"
fsoyp10_1_muni[42, "Regions"] <- "Others_Sudeste"
fsoyp10_1_muni$Area_ha <- NULL

#2010 soy planting - setting as data frame - 2nd file
fsoyp10_2 <- as.data.frame(fsoyp10_2[2:nrow(fsoyp10_2), ], stringsAsFactors = FALSE)
hefsoyp10_2 <- c('Regions', 'Area_ha', '2009-10-08', '2009-10-15', '2009-10-22', '2009-10-29',
                 '2009-11-05', '2009-11-12', '2009-11-19', '2009-11-26', '2009-12-03')
names(fsoyp10_2) <- hefsoyp10_2

#2010 soy planting - erasing unnecessary rows and renaming rows with errors, and removing 
#columns that will be duplicated after merge with 1st file - 2nd file
fsoyp10_2_muni <- fsoyp10_2[-c(44, 45, 46, 47, 48, 49, 50, 51, 52, 53), ]
fsoyp10_2_muni[3, "Regions"] <- "Others_Noroeste"
fsoyp10_2_muni[5, "Regions"] <- "Itauba"
fsoyp10_2_muni[6, "Regions"] <- "Others_Norte"
fsoyp10_2_muni[9, "Regions"] <- "Querencia"
fsoyp10_2_muni[10, "Regions"] <- "Gaucha_do_Norte"
fsoyp10_2_muni[12, "Regions"] <- "Others_Nordeste"
fsoyp10_2_muni[13, "Regions"] <- "Medio_Norte"
fsoyp10_2_muni[21, "Regions"] <- "Nova_Ubirata"
fsoyp10_2_muni[23, "Regions"] <- "Sao_Jose_do_Rio_Claro"
fsoyp10_2_muni[24, "Regions"] <- "Others_Medio_Norte"
fsoyp10_2_muni[28, "Regions"] <- "Campos_de_Julio"
fsoyp10_2_muni[29, "Regions"] <- "Others_Oeste"
fsoyp10_2_muni[32, "Regions"] <- "Tangara_da_Serra"
fsoyp10_2_muni[34, "Regions"] <- "Chapada_dos_Guimaraes"
fsoyp10_2_muni[35, "Regions"] <- "Others_Centro_Sul"
fsoyp10_2_muni[39, "Regions"] <- "Alto_Garcas_e_Alto_Taquari"
fsoyp10_2_muni[42, "Regions"] <- "Others_Sudeste"
fsoyp10_2_muni$'2009-10-08' <- NULL
fsoyp10_2_muni$'2009-10-15' <- NULL
fsoyp10_2_muni$'2009-10-22' <- NULL
fsoyp10_2_muni$'2009-10-29' <- NULL
fsoyp10_2_muni$'2009-11-05' <- NULL
fsoyp10_2_muni$'2009-11-12' <- NULL
fsoyp10_2_muni$'2009-11-19' <- NULL
fsoyp10_2_muni$'2009-11-26' <- NULL

#2010 soy planting - merging 1st and second files
fsoyp10_muni <- merge(fsoyp10_1_muni, fsoyp10_2_muni, by="Regions", sort = FALSE)
#2010 soy planting - moving Area_ha column to the second position in line
fsoyp10_muni_1 <- fsoyp10_muni[c(1,12,2:11,13)]
#Remove periods and spaces from decimal/thousands positions and convert Area_ha to numeric
fsoyp10_muni_1$Area_ha <- gsub("\\.", "", fsoyp10_muni_1$Area_ha)
fsoyp10_muni_1$Area_ha <- gsub(" ", "", fsoyp10_muni_1$Area_ha)
fsoyp10_muni_1 <- fsoyp10_muni_1 %>%
  mutate(Area_ha = as.numeric(Area_ha))
#Change commas to periods in percentage columns
fsoyp10_muni_1$`2009-09-24` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-09-24`)
fsoyp10_muni_1$`2009-10-01` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-10-01`)
fsoyp10_muni_1$`2009-10-08` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-10-08`)
fsoyp10_muni_1$`2009-10-15` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-10-15`)
fsoyp10_muni_1$`2009-10-22` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-10-22`)
fsoyp10_muni_1$`2009-10-29` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-10-29`)
fsoyp10_muni_1$`2009-11-05` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-11-05`)
fsoyp10_muni_1$`2009-11-12` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-11-12`)
fsoyp10_muni_1$`2009-11-19` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-11-19`)
fsoyp10_muni_1$`2009-11-26` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-11-26`)
fsoyp10_muni_1$`2009-12-03` <- gsub(",", "\\.", fsoyp10_muni_1$`2009-12-03`)

#Removing percentage symbols
fsoyp10_muni_1$`2009-09-24` <- gsub("%", "", fsoyp10_muni_1$`2009-09-24`)
fsoyp10_muni_1$`2009-10-01` <- gsub("%", "", fsoyp10_muni_1$`2009-10-01`)
fsoyp10_muni_1$`2009-10-08` <- gsub("%", "", fsoyp10_muni_1$`2009-10-08`)
fsoyp10_muni_1$`2009-10-15` <- gsub("%", "", fsoyp10_muni_1$`2009-10-15`)
fsoyp10_muni_1$`2009-10-22` <- gsub("%", "", fsoyp10_muni_1$`2009-10-22`)
fsoyp10_muni_1$`2009-10-29` <- gsub("%", "", fsoyp10_muni_1$`2009-10-29`)
fsoyp10_muni_1$`2009-11-05` <- gsub("%", "", fsoyp10_muni_1$`2009-11-05`)
fsoyp10_muni_1$`2009-11-12` <- gsub("%", "", fsoyp10_muni_1$`2009-11-12`)
fsoyp10_muni_1$`2009-11-19` <- gsub("%", "", fsoyp10_muni_1$`2009-11-19`)
fsoyp10_muni_1$`2009-11-26` <- gsub("%", "", fsoyp10_muni_1$`2009-11-26`)
fsoyp10_muni_1$`2009-12-03` <- gsub("%", "", fsoyp10_muni_1$`2009-12-03`)

#changing to numeric
sapply(fsoyp10_muni_1, mode)
fsoyp10_muni_1$`2009-09-24` <- as.numeric(fsoyp10_muni_1$`2009-09-24`)
fsoyp10_muni_1$`2009-10-01` <- as.numeric(fsoyp10_muni_1$`2009-10-01`)
fsoyp10_muni_1$`2009-10-08` <- as.numeric(fsoyp10_muni_1$`2009-10-08`)
fsoyp10_muni_1$`2009-10-15` <- as.numeric(fsoyp10_muni_1$`2009-10-15`)
fsoyp10_muni_1$`2009-10-22` <- as.numeric(fsoyp10_muni_1$`2009-10-22`)
fsoyp10_muni_1$`2009-10-29` <- as.numeric(fsoyp10_muni_1$`2009-10-29`)
fsoyp10_muni_1$`2009-11-05` <- as.numeric(fsoyp10_muni_1$`2009-11-05`)
fsoyp10_muni_1$`2009-11-12` <- as.numeric(fsoyp10_muni_1$`2009-11-12`)
fsoyp10_muni_1$`2009-11-19` <- as.numeric(fsoyp10_muni_1$`2009-11-19`)
fsoyp10_muni_1$`2009-11-26` <- as.numeric(fsoyp10_muni_1$`2009-11-26`)
fsoyp10_muni_1$`2009-12-03` <- as.numeric(fsoyp10_muni_1$`2009-12-03`)

#dividing percentage values by 100 to convert them to decimal form
fsoyp10_muni_1$`2009-09-24` <- fsoyp10_muni_1$`2009-09-24`/100
fsoyp10_muni_1$`2009-10-01` <- fsoyp10_muni_1$`2009-10-01`/100
fsoyp10_muni_1$`2009-10-08` <- fsoyp10_muni_1$`2009-10-08`/100
fsoyp10_muni_1$`2009-10-15` <- fsoyp10_muni_1$`2009-10-15`/100
fsoyp10_muni_1$`2009-10-22` <- fsoyp10_muni_1$`2009-10-22`/100
fsoyp10_muni_1$`2009-10-29` <- fsoyp10_muni_1$`2009-10-29`/100
fsoyp10_muni_1$`2009-11-05` <- fsoyp10_muni_1$`2009-11-05`/100
fsoyp10_muni_1$`2009-11-12` <- fsoyp10_muni_1$`2009-11-12`/100
fsoyp10_muni_1$`2009-11-19` <- fsoyp10_muni_1$`2009-11-19`/100
fsoyp10_muni_1$`2009-11-26` <- fsoyp10_muni_1$`2009-11-26`/100
fsoyp10_muni_1$`2009-12-03` <- fsoyp10_muni_1$`2009-12-03`/100

#Write final table to disk
write.csv(fsoyp10_muni_1, file='soy_plant_2010_muni.csv', row.names=FALSE)

#2010 soy planting - isolating regional summary table by removing unnecessary columns from 2nd file
fsoyp10_2_re <- fsoyp10_2[-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26
                             ,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,51,53), ]
fsoyp10_2_re[11] <- NULL
fsoyp10_2_re[10] <- NULL
fsoyp10_2_re[5] <- NULL
hefsoyp10_2_re <- c('Noroeste', 'Norte', 'Nordeste', 'Medio_Norte', 'Oeste',
                    'Centro_Sul', 'Sudeste', 'Mato_Grosso')
names(fsoyp10_2_re) <- hefsoyp10_2_re
#2010 soy planting regional summary table - shifting data over and re-entering erroneous values
fsoyp10_2_re[1, "Noroeste"] <- "241.200"
fsoyp10_2_re[2, "Noroeste"] <- "100,0%"
fsoyp10_2_re[3, "Noroeste"] <- "100,0%"
fsoyp10_2_re[4, "Noroeste"] <- "0,0%"
#Transpose 2010 soy planting regions table (rows to columns, columns to rows)
fsoyp10_2_re_1 <- t(fsoyp10_2_re)
#Turn this transposed table into a data frame and remove headers in first row
fsoyp10_2_re_1 <- as.data.frame(fsoyp10_2_re_1[1:nrow(fsoyp10_2_re_1), ], sort= FALSE)
#Create new header names and insert them
hefsoyp10_2_re_1 <- c('Area_ha', 'first', 'second', 'change_in_plant_per')
names(fsoyp10_2_re_1) <- hefsoyp10_2_re_1
#Change row names to a separate column and name it "IMEA_Regions" 
setDT(fsoyp10_2_re_1, keep.rownames=TRUE)
colnames(fsoyp10_2_re_1)[1] <- "IMEA_Regions"
#change Area_ha column to numeric and remove periods from thousandths position
fsoyp10_2_re_1 <- fsoyp10_2_re_1 %>%
  mutate(Area_ha = as.numeric(gsub("\\.", "", Area_ha)))
#remove commas from decimal position in other three columns
fsoyp10_2_re_1$first <- gsub(",", "\\.", fsoyp10_2_re_1$first)
fsoyp10_2_re_1$second <- gsub(",", "\\.", fsoyp10_2_re_1$second)
fsoyp10_2_re_1$change_in_plant_per <- gsub(",", "\\.", fsoyp10_2_re_1$change_in_plant_per)
#remove percent signs from other three columns
fsoyp10_2_re_1$first <- gsub("%", "", fsoyp10_2_re_1$first)
fsoyp10_2_re_1$second <- gsub("%", "", fsoyp10_2_re_1$second)
fsoyp10_2_re_1$change_in_plant_per <- gsub("%", "", fsoyp10_2_re_1$change_in_plant_per)
#change other columns to numeric
fsoyp10_2_re_1 <- fsoyp10_2_re_1 %>%
  mutate(change_in_plant_per = as.numeric(change_in_plant_per)) 
fsoyp10_2_re_1 <- fsoyp10_2_re_1 %>%
  mutate(second = as.numeric(second)) 
fsoyp10_2_re_1 <- fsoyp10_2_re_1 %>%
  mutate(first = as.numeric(first))
#check the type of data in each column
sapply(fsoyp10_2_re_1, mode)
#rename the date columns
colnames(fsoyp10_2_re_1)[3] <- "2009-12-03"
colnames(fsoyp10_2_re_1)[4] <- "2008-12-04"
#divide percentage columns by 100 to obtain decimal form
fsoyp10_2_re_1$'2009-12-03' <- fsoyp10_2_re_1$'2009-12-03'/100
fsoyp10_2_re_1$'2008-12-04' <- fsoyp10_2_re_1$'2008-12-04'/100
fsoyp10_2_re_1$'change_in_plant_per' <- fsoyp10_2_re_1$'change_in_plant_per'/100
#Write final table to disk
write.csv(fsoyp10_2_re_1, file='soy_plant_2010_region.csv', row.names=FALSE)

# Create individual data matrices for soy harvesting data
# fsoyh9_1 <- do.call(rbind, outsoyh9_1)
# fsoyh9_2 <- do.call(rbind, outsoyh9_2)
# fsoyh9_3 <- do.call(rbind, outsoyh9_3)
# fsoyh9_4 <- do.call(rbind, outsoyh9_4)
# fsoyh9_5 <- do.call(rbind, outsoyh9_5)
# fsoyh9_6 <- do.call(rbind, outsoyh9_6)
# fsoyh9_7 <- do.call(rbind, outsoyh9_7)
# fsoyh9_8 <- do.call(rbind, outsoyh9_8)
# fsoyh9_9 <- do.call(rbind, outsoyh9_9)
# fsoyh9_10 <- do.call(rbind, outsoyh9_10)
# fsoyh9_11 <- do.call(rbind, outsoyh9_11)
# fsoyh9_12 <- do.call(rbind, outsoyh9_12)
# fsoyh9_13 <- do.call(rbind, outsoyh9_13)
# fsoyh9_14 <- do.call(rbind, outsoyh9_14)
# fsoyh10_1 <- do.call(rbind, outsoyh10[1])
# fsoyh10_2 <- do.call(rbind, outsoyh10[2])
# fsoyh11_1_1 <- do.call(rbind, outsoyh11_1[1])
# fsoyh11_1_2 <- do.call(rbind, outsoyh11_1[2])
# fsoyh11_2_1 <- do.call(rbind, outsoyh11_2[1])
# fsoyh11_2_2 <- do.call(rbind, outsoyh11_2[2])
# fsoyh12_1_1 <- do.call(rbind, outsoyh12_1[1])
# fsoyh12_1_2 <- do.call(rbind, outsoyh12_1[2])
# fsoyh12_2_1 <- do.call(rbind, outsoyh12_2[1])
# fsoyh12_2_2 <- do.call(rbind, outsoyh12_2[2])
# fsoyh13 <- do.call(rbind, outsoyh13)
# fsoyh14_1 <- do.call(rbind, outsoyh14[1])
# fsoyh14_2 <- do.call(rbind, outsoyh14[2])
# fsoyh15_1 <- do.call(rbind, outsoyh15[1])
# fsoyh15_2 <- do.call(rbind, outsoyh15[2])
# fsoyh16 <- do.call(rbind, outsoyh16)
# fsoyh17 <- do.call(rbind, outsoyh17)
# fsoyh18 <- do.call(rbind, outsoyh18)






