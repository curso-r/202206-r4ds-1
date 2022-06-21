# Objetivo: ler a base IMDB e gerar uma tabela 
# com apenas as colunas filme e ano, ordenada por ano

# carregando as bibliotecas que vamos usar
library(readr)
library(dplyr)

# lendo os dados
imdb <- read_rds("dados/imdb.rds")

# crescente
imdb_ano_crescente <- imdb %>% 
  select(titulo, ano) %>% 
  arrange(ano)

# tambem funciona!
imdb_ano_crescente <- select(imdb, titulo, ano) %>% 
  arrange(ano)


# decrescente
imdb_ano_decrescente <- imdb %>% 
  select(titulo, ano) %>% 
  arrange(desc(ano))

# -------------------------------------------------------------------------

# Objetivo: descobrir qual o filme mais caro, 
# mais lucrativo e com melhor nota dos anos 2000
# anos de 2000 a 2009


## Filme mais caro ##

# devolve todos os filmes ordenados por orcamento (decrescente)
imdb %>% 
  filter(ano %in% 2000:2009) %>% 
  arrange(desc(orcamento)) %>% 
  select(titulo, orcamento)

# devolve só o filme mais caro
imdb %>% 
  filter(ano %in% 2000:2009) %>% 
  filter(orcamento == max(orcamento, na.rm = TRUE)) %>% 
  select(titulo, orcamento)

# nao funciona:
imdb %>% 
  filter(ano %in% 1950:1960,
         orcamento == max(orcamento, na.rm = TRUE)) %>% 
  select(titulo, orcamento)

# nao funciona pois o codigo de cima faz intersecção entre 
# as duas bases a seguir:
imdb %>% 
  filter(ano %in% 1950:1960)

imdb %>% 
  filter(orcamento == max(orcamento, na.rm = TRUE))

# usando o |, as linhas das duas bases são unidas!
imdb %>% 
  filter(ano %in% 1950:1960 |
           orcamento == max(orcamento, na.rm = TRUE)) %>% 
  View()

# na.rm remove os NA's para fazer operações!
c(0, 1, 2, NA) %>% max(na.rm = TRUE)
?max

# Melhor nota ##

# só a melhor nota
imdb %>% 
  filter(ano %in% 2000:2009) %>% 
  filter(nota_imdb == max(nota_imdb, na.rm = TRUE)) %>% 
  select(titulo, nota_imdb)

# ordena a base inteira por ordem decrescente de nota
imdb %>% 
  filter(ano %in% 2000:2009) %>% 
  arrange(desc(nota_imdb)) %>% 
  select(titulo, nota_imdb)

## Filme mais lucrativo ##
imdb %>% 
  filter(ano %in% 2000:2009) %>% 
  mutate(lucro = receita - orcamento) %>% 
  filter(lucro == max(lucro, na.rm = TRUE)) %>% 
  select(titulo, orcamento, receita, lucro)

# 10 filmes mais lucrativos
imdb_lucro_maior <- imdb %>% 
  filter(ano %in% 2000:2009) %>% 
  mutate(lucro = receita - orcamento) %>% 
  arrange(desc(lucro)) %>% 
  select(titulo, lucro) %>% 
  slice(1:10)


# -------------------------------------------------------------------------

# mostrar relocate e rename

# quero mudar a coluna "producao" para "estudio"

imdb_renomeado <- imdb %>% 
  rename(estudio = producao)

# quero criar uma coluna nova "lucro"
# e quero que ela fique depois da coluna "receita"
imdb_lucro <- imdb %>% 
  mutate(lucro = receita - orcamento) %>% 
  relocate(lucro, .after = receita)

imdb_lucrou <- imdb %>% 
  mutate(lucro = receita - orcamento,
         lucrou = lucro > 0,
        .after = receita)

