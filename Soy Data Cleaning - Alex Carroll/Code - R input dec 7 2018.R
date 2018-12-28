install.packages("tabulizer")
library("tabulizer")
install.packages("dplyr")
library("dplyr")

# Location of soy planting files of interest
soyp9 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/081211_IPS.pdf'
soyp10_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/09_11_26_IAPSoja.pdf'
soyp10_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/09_12_03_APSoja.pdf'
soyp11_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/10_11_11_IPSoja.pdf'
soyp11_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/10_12_02_IPSoja.pdf'
soyp12_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2011_11_24_IPSoja.pdf'
soyp12_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2011_12_01_IPSoja.pdf'
soyp13 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Pantio_Safra_12-13_11-29.pdf'
soyp14_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_28__11_13_Tratamento_Semeadura_13-14.pdf'
soyp14_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404__05_12_13_Tratamento_semeadura_13-14.pdf'
soyp15 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404__14_12_11_Tratamento_plantio_14-15.pdf'
soyp16 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404__15_01_14_Relatorio_Semeadura_15-16.pdf'
soyp17 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/16122016130906.pdf'
soyp18 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/15122017180857.pdf'
soyp19 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/23112018162346.pdf'

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
soyh11_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/11_02_18_ICSoja.pdf'
soyh11_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/11_04_14_ICSoja.pdf'
soyh12_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2012_04_05_ICSoja.pdf'
soyh12_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2012_04_12_ICSoja.pdf'
soyh13 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Colheita_Safra_12-13_04-18.pdf'
soyh14 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Colheita_Safra_13-14_17-04.pdf'
soyh15 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Colheita_Safra_14-15_30-04.pdf'
soyh16 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R404_Colheita_Safra_15-16_04-29.pdf'
soyh17 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/28042017140741.pdf'
soyh18 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/04052018194311.pdf'

# Location of maize planting files of interest
map9_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090129_IAPM.pdf'
map9_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090205_IAPM.pdf'
map9_3 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090212_IAPM.pdf'
map9_4 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090219_IAPM.pdf'
map9_5 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090226_IAPM.pdf'
map9_6 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090305_IAPM.pdf'
map9_7 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/90312_IAPM.pdf'
map9_8 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090319_IAPM.pdf'
map10_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/10_03_11_IPMilho.pdf'
map10_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/10_03_18_IPMilho.pdf'
map11 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2011_03_24_IPMilho.pdf'
map12 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/2012_03_15_IPMilho.pdf'
map13 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R403_Plantio_safra_12-13_14-03.pdf'
map14 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R403_Semeadura_Safra_13-14_27-03.pdf'
map15 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R403_Semeadura_Safra_14-15_19-03.pdf'
map16 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R403_Semeadura_Safra_15-16-31-03-2016.pdf'
map17 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/31032017174329.pdf'
map18 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/06042018190535.pdf'

# Location of maize harvest files of interest
mah9 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/090827_ACM.pdf'
mah10_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/100701_ICM.pdf'
mah10_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/100812_ICM.pdf'
mah11 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/18_08_2011_ECMilho.pdf'
mah12 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R403_2012_08_24_ECMilho.pdf'
mah13 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R403_05_09_13_Tratamento_Colheita_12-13.pdf'
mah14 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R203_14_09_04_Tratamento_Colheita_13-14.pdf'
mah15_1 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/Colheita_23_07_2015.pdf'
mah15_2 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/Colheita_03_09_2015.pdf'
mah16 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/R403_Colheita_de_milho_15.16_sem._18.08.2016.pdf'
mah17 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/01092017185825.pdf'
mah18 <- 'http://www.imea.com.br/upload/publicacoes/arquivos/06092018212011.pdf'

# Extract soy planting tables
outsoyp9 <- extract_tables(soyp9)
outsoyp10_1 <- extract_tables(soyp10_1)
outsoyp10_2 <- extract_tables(soyp10_2)
outsoyp11_1 <- extract_tables(soyp11_1)
outsoyp11_2 <- extract_tables(soyp11_2)
outsoyp12_1 <- extract_tables(soyp12_1)
outsoyp12_2 <- extract_tables(soyp12_2)
outsoyp13 <- extract_tables(soyp13)
outsoyp14_1 <- extract_tables(soyp14_1)
outsoyp14_2 <- extract_tables(soyp14_2)
outsoyp15 <- extract_tables(soyp15)
outsoyp16 <- extract_tables(soyp16)
outsoyp17 <- extract_tables(soyp17)
outsoyp18 <- extract_tables(soyp18)
outsoyp19 <- extract_tables(soyp19)

print('asdf')
# Extract soy harvest tables
outsoyh9_1 <- extract_tables(soyh9_1)
outsoyh9_2 <- extract_tables(soyh9_2)
outsoyh9_3 <- extract_tables(soyh9_3)
outsoyh9_4 <- extract_tables(soyh9_4)
outsoyh9_5 <- extract_tables(soyh9_5)
outsoyh9_6 <- extract_tables(soyh9_6)
outsoyh9_7 <- extract_tables(soyh9_7)
outsoyh9_8 <- extract_tables(soyh9_8)
outsoyh9_9 <- extract_tables(soyh9_9)
outsoyh9_10 <- extract_tables(soyh9_10)
outsoyh9_11 <- extract_tables(soyh9_11)
outsoyh9_12 <- extract_tables(soyh9_12)
outsoyh9_13 <- extract_tables(soyh9_13)
outsoyh9_14 <- extract_tables(soyh9_14)
outsoyh10 <- extract_tables(soyh10)
outsoyh11_1 <- extract_tables(soyh11_1)
outsoyh11_2 <- extract_tables(soyh11_2)
outsoyh12_1 <- extract_tables(soyh12_1)
outsoyh12_2 <- extract_tables(soyh12_2)
outsoyh13 <- extract_tables(soyh13)
outsoyh14 <- extract_tables(soyh14)
outsoyh15 <- extract_tables(soyh15)
outsoyh16 <- extract_tables(soyh16)
outsoyh17 <- extract_tables(soyh17)
outsoyh18 <- extract_tables(soyh18)

# Extract maize planting tables
outmap9_1 <- extract_tables(map9_1)
outmap9_2 <- extract_tables(map9_2)
outmap9_3 <- extract_tables(map9_3)
outmap9_4 <- extract_tables(map9_4)
outmap9_5 <- extract_tables(map9_5)
outmap9_6 <- extract_tables(map9_6)
outmap9_7 <- extract_tables(map9_7)
outmap9_8 <- extract_tables(map9_8)
outmap10_1 <- extract_tables(map10_1)
outmap10_2 <- extract_tables(map10_2)
outmap11 <- extract_tables(map11)
outmap12 <- extract_tables(map12)
outmap13 <- extract_tables(map13)
outmap14 <- extract_tables(map14)
outmap15 <- extract_tables(map15)
outmap16 <- extract_tables(map16)
outmap17 <- extract_tables(map17)
outmap18 <- extract_tables(map18)

# Extract maize harvest tables
outmah9 <- extract_tables(mah9)
outmah10_1 <- extract_tables(mah10_1)
outmah10_2 <- extract_tables(mah10_2)
outmah11 <- extract_tables(mah11)
outmah12 <- extract_tables(mah12)
outmah13 <- extract_tables(mah13)
outmah14 <- extract_tables(mah14)
outmah15_1 <- extract_tables(mah15_1)
outmah15_2 <- extract_tables(mah15_2)
outmah16 <- extract_tables(mah16)
outmah17 <- extract_tables(mah17)
outmah18 <- extract_tables(mah18)

# Create individual data matrices for soy planting data
fsoyp9 <- do.call(rbind, outsoyp9)
fsoyp10_1 <- do.call(rbind, outsoyp10_1)
fsoyp10_2 <- do.call(rbind, outsoyp10_2)
fsoyp11_1 <- do.call(rbind, outsoyp11_1)
fsoyp11_2 <- do.call(rbind, outsoyp11_2)
fsoyp12_1 <- do.call(rbind, outsoyp12_1)
fsoyp12_2 <- do.call(rbind, outsoyp12_2)
fsoyp13 <- do.call(rbind, outsoyp13)
fsoyp14_1 <- do.call(rbind, outsoyp14_1)
fsoyp14_2 <- do.call(rbind, outsoyp14_2)
fsoyp15 <- do.call(rbind, outsoyp15)
fsoyp16 <- do.call(rbind, outsoyp16)
fsoyp17 <- do.call(rbind, outsoyp17)
fsoyp18 <- do.call(rbind, outsoyp18)
fsoyp19 <- do.call(rbind, outsoyp19)

# Create individual data matrices for soy harvesting data
fsoyh9_1 <- do.call(rbind, outsoyh9_1)
fsoyh9_2 <- do.call(rbind, outsoyh9_2)
fsoyh9_3 <- do.call(rbind, outsoyh9_3)
fsoyh9_4 <- do.call(rbind, outsoyh9_4)
fsoyh9_5 <- do.call(rbind, outsoyh9_5)
fsoyh9_6 <- do.call(rbind, outsoyh9_6)
fsoyh9_7 <- do.call(rbind, outsoyh9_7)
fsoyh9_8 <- do.call(rbind, outsoyh9_8)
fsoyh9_9 <- do.call(rbind, outsoyh9_9)
fsoyh9_10 <- do.call(rbind, outsoyh9_10)
fsoyh9_11 <- do.call(rbind, outsoyh9_11)
fsoyh9_12 <- do.call(rbind, outsoyh9_12)
fsoyh9_13 <- do.call(rbind, outsoyh9_13)
fsoyh9_14 <- do.call(rbind, outsoyh9_14)
fsoyh10 <- do.call(rbind, outsoyh10)
fsoyh11_1 <- do.call(rbind, outsoyh11_1)
fsoyh11_2 <- do.call(rbind, outsoyh11_2)
fsoyh12_1 <- do.call(rbind, outsoyh12_1)
fsoyh12_2 <- do.call(rbind, outsoyh12_2)
fsoyh13 <- do.call(rbind, outsoyh13)
fsoyh14 <- do.call(rbind, outsoyh14)
fsoyh15 <- do.call(rbind, outsoyh15)
fsoyh16 <- do.call(rbind, outsoyh16)
fsoyh17 <- do.call(rbind, outsoyh17)
fsoyh18 <- do.call(rbind, outsoyh18)

# Create individual data matrices for maize planting data
fmap9_1 <- do.call(rbind, outmap9_1)
fmap9_2 <- do.call(rbind, outmap9_2)
fmap9_3 <- do.call(rbind, outmap9_3)
fmap9_4 <- do.call(rbind, outmap9_4)
fmap9_5 <- do.call(rbind, outmap9_5)
fmap9_6 <- do.call(rbind, outmap9_6)
fmap9_7 <- do.call(rbind, outmap9_7)
fmap9_8 <- do.call(rbind, outmap9_8)
fmap10_1 <- do.call(rbind, outmap10_1)
fmap10_2 <- do.call(rbind, outmap10_2)
fmap11 <- do.call(rbind, outmap11)
fmap12 <- do.call(rbind, outmap12)
fmap13 <- do.call(rbind, outmap13)
fmap14 <- do.call(rbind, outmap14)
fmap15 <- do.call(rbind, outmap15)
fmap16 <- do.call(rbind, outmap16)
fmap17 <- do.call(rbind, outmap17)
fmap18 <- do.call(rbind, outmap18)

# Create individual data matrices for maize harvesting data
fmah9_1 <- do.call(rbind, outmah9)
fmah10_1 <- do.call(rbind, outmah10_1)
fmah10_2 <- do.call(rbind, outmah10_2)
fmah11 <- do.call(rbind, outmah11)
fmah12 <- do.call(rbind, outmah12)
fmah13 <- do.call(rbind, outmah13)
fmah14 <- do.call(rbind, outmah14)
fmah15 <- do.call(rbind, outmah15_1)
fmah15 <- do.call(rbind, outmah15_2)
fmah16 <- do.call(rbind, outmah16)
fmah17 <- do.call(rbind, outmah17)
fmah18 <- do.call(rbind, outmah18)





final <- as.data.frame(final)
View <-(out)
final <- do.call(rbind, out)


# table headers get extracted as rows with bad formatting. Dump them.
final <- as.data.frame(final[2:nrow(final), ])

# Column names
headers <- c('Notice.Date', 'Effective.Date', 'Received.Date', 'Company', 'City', 
             'County', 'No.of.Employees', 'Layoff/Closure')

# Apply custom column names
names(final) <- headers

class(final$Notice.Date)
class(final$No.of.Employees)

# These dplyr steps are not strictly necessary for dumping to csv, but useful if further data 
# manipulation in R is required. 
final <- final %>%
  # Convert date columns to date objects
  mutate_at(vars(Notice.Date, Effective.Date, Received.Date), funs(as.Date(., "%m/%d/%y"))) %>%
mutate_at(vars(starts_with("No.of.Employees")),funs(as.numeric))
  
  # Write final table to disk
  write.csv(final, file='CA_WARN1.csv', row.names=FALSE)

library(tabulizer)
library(dplyr)
jun2011 <- 'C:\\Users\\alexc\\Dropbox\\AlexCarroll\\Tufts\\CohnRA\\MaizeHarvest\\05_08_2011_ECMilho.pdf'
files <- list.files(jun2011)
for(file in files) 
lst <- extract_tables(jun2011, encoding="UTF-8",pages = 1,area = list(c(Regi?es do IMEA)))
lst <- extract_tables(jun2011, encoding="UTF-8") 
output <- extract_tables(jun2011)
finjun11 <- do.call(rbind.fill(x[c("a", "b","c","d")], y[c("a", "b","c")],z[c("a","b")]))
finjun11 <- do.call(rbind, output)
finjun11 <- as.data.frame(finjun11[2:nrow(final),])
headers <- c('Regi?es / Munic?pios', '09/jun', '16/jun', '23/jun', '30/jun', '07/jul', '14/jul',
             '14/jul', '28/jul', '04/ago')
names(final) <- headers
final <- final %>%
mutate_at(vars(Notice.Date, Effective.Date, Received.Date), funs(as.Date(., "%m/%d/%y"))) %>%
mutate_at(vars(starts_with("No.of.Employees")),funs(as.numeric))
write.csv(final, file='CA_WARN1.csv', row.names=FALSE)
