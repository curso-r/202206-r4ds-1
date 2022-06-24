# Objetivo: descobrir qual o peso médio dos 
# personagens do Star Wars

# instalando pacote dados
install.packages("dados")

library(dados)
library(dplyr)

starwars <- dados_starwars

# media do peso de todos os personegens
starwars |> 
  summarise(peso_medio = mean(massa))

# faltou o na.rm = TRUE, se não ele devolve NA
starwars |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# peso medio por genero
starwars |> 
  group_by(genero) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# filtar personagens que nao sei o genero
starwars |> 
  filter(!is.na(genero)) |> 
  group_by(genero) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# vamos dar um nome para a categoria NA -> "não informado"
starwars |> 
  mutate(genero = ifelse(is.na(genero), "não informado", genero)) |> 
  group_by(genero) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))
  
# ver o peso medio por especie
starwars |> 
  group_by(especie) |> 
  summarise(peso_medio = mean(massa, na.rm = TRUE))

# ver quantos personagens tem em cada especie
starwars |> 
  group_by(especie) |> 
  summarise(quantidade_personagens = n()) |> 
  arrange(desc(quantidade_personagens))

# usando a funcao count
help(count)
  
starwars |> 
  count(especie, name = "quantidade_personagens",
        sort = TRUE)

# contar quantas especies tem em cada planeta
starwars |> 
  group_by(planeta_natal) |> 
  summarise(quantidade_especies = n_distinct(especie)) |> 
  arrange(desc(quantidade_especies))

# pegar as 5 especies que tem mais personagens
starwars |> 
  count(especie, name = "quantidade_personagens") |> 
  slice_max(quantidade_personagens, 
            n = 5,
            with_ties = FALSE)

# sortear 5 linhas quaisquer da base de dados:
starwars |> 
  slice_sample(n = 5)

# cada vez que rodar vai dar um resultado diferente
starwars |> 
  slice_sample(n = 5)

# a funcao set.seed nos ajuda a tornar resultados reprodutiveis
# quando fixamos uma "semente", funções de sorteio 
# sempre vão retornar os mesmos resultados, veja:

set.seed(4)

starwars |> 
  slice_sample(n = 5)

set.seed(4)

starwars |> 
  slice_sample(n = 5)

# obs: tem que usar o set.seed exatamente antes
# de rodar o comando que faz o sorteio.

  
