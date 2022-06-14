library(tidyverse)

# Caminhos até o arquivo --------------------------------------------------

# Caminhos absolutos - não é uma boa prática
"/home/william/Documents/Curso-R/main-r4ds-1/dados/imdb.csv"
"~/Desktop/material_r4ds-1/dados/imdb.csv"

# Caminhos relativos
"dados/imdb.csv"

"dados/imdb.csv"

# (cara(o) professora(o), favor lembrar de falar da dica 
# de navegação entre as aspas)

# Tibbles -----------------------------------------------------------------

airquality
class(airquality)

as_tibble(airquality)

class(as_tibble(airquality))

imdb <- read.csv("dados/imdb.csv")
imdb

as_tibble(imdb)

# Lendo arquivos de texto -------------------------------------------------

# CSV, separado por vírgula
imdb_csv <- read_csv("dados/imdb.csv")

# CSV, separado por ponto-e-vírgula
imdb_csv2 <- read_csv2(file = "dados/imdb2.csv")

# Com import dataset!
library(readr)
imdb2 <- read_delim(
  "dados/imdb2.csv",
  delim = ";",
  escape_double = FALSE,
  locale = locale(decimal_mark = ",",
                  grouping_mark = "."),
  trim_ws = TRUE
)
View(imdb2)


# TXT, separado por tabulação (tecla TAB)
imdb_txt <- read_delim(file = "dados/imdb.txt", delim = "\t")



# A função read_delim funciona para qualquer tipo de separador
imdb_delim <- read_delim("dados/imdb.csv", delim = ",")
imdb_delim2 <- read_delim("dados/imdb2.csv", delim = ";")

# direto da internet
imdb_csv_url <- read_csv("https://raw.githubusercontent.com/curso-r/main-r4ds-1/master/dados/imdb.csv")


# Interface point and click do RStudio também é útil!

# Lendo arquivos do Excel -------------------------------------------------


library(readxl)

imdb_excel <- read_excel("dados/imdb.xlsx")

excel_sheets("dados/imdb.xlsx")

imdb_excel <- read_excel("dados/imdb.xlsx", sheet = "Sheet1")

# Salvando dados ----------------------------------------------------------

# As funções iniciam com 'write'

imdb <- imdb_excel

# CSV
write_csv(imdb, file = "imdb.csv")

# write_csv(mtcars, "mtcars.csv")
# library(readr)
# mtcars <- read_csv("mtcars.csv")
# View(mtcars)

# Excel
library(writexl)
write_xlsx(imdb, path = "imdb.xlsx")

# O formato rds -----------------------------------------------------------

# .rds são arquivos binários do R
# Você pode salvar qualquer objeto do R em formato .rds

imdb_rds <- read_rds("dados/imdb.rds")
write_rds(imdb_rds, file = "imdb_rds.rds")

library(readr)
write_rds(pi, "pi.rds")

# write_rds(pi, "pi2") # isso exporta um arquivo sem extensão! cuidado.
