library(tidyverse)

# Usa a base starwars do dplyr
starwars |> 
  # cria coluna dos ultimos dois digitos: usando a funcao str_sub
  mutate(ultimos_dig = as.numeric(str_sub(height, -2, -1)),
         # cria a coluna da classe
         classe = case_when(
           # criando as classes aqui
           ultimos_dig %in% 0:50 ~ "zero à 50",
           ultimos_dig %in% 51:99 ~ "51 à 99",
           # o que nao ficou em classes anteriores fica com esse valor colocado
           # em "outra classe"
           TRUE ~ "outra classe"
         )) |> 
  View()
