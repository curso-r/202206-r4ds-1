library(tidyverse)
imdb <- read_rds("dados/imdb.rds")

# código com erro
imdb |> 
  filter(data_lancamento, starts_with("2020")) |> 
  view()

# arrumando um problema: data_lancamento deve estar dentro da função
imdb |> 
  filter(starts_with(data_lancamento, "2020")) |> 
  view()

# starts_with precisa ser usada no select
imdb %>% 
  select(starts_with("num"))

# a função correta é str_starts
imdb |> 
  filter(str_starts(data_lancamento, "2020")) |> 
  view()

# como converter para data?
imdb %>% 
  mutate(date_lancamento = parse_date(data_lancamento)) %>%
  glimpse()


# e se a data fosse no brasil?
parse_date("27/06/2022", format = "%d/%m/%Y")


# filter -> linhas
# select -> colunas


# ---- 
# PROVA REAL
imdb %>% 
  count(direcao, sort = TRUE)
#
imdb %>% 
  group_by(direcao) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))

# como fazer isso sem perder a base original?
imdb %>% 
  group_by(direcao) %>% 
  mutate(num_filmes_direcao = n()) %>% 
  ungroup()
  
