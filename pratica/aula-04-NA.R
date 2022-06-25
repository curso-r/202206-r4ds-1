# Valores especiais

NA # Not available - dado faltate/indisponível

NULL # Ausência de objeto no R.

# comparacoes com NA geram NA
idade_bia <- 29

idade_tereza <- NA

idade_bia > idade_tereza

idade_tereza == NA



# contas com NA no meio geram NA!!
mean(imdb$nota_imdb)

mean(imdb$orcamento)

# podemos ignorar os NAs
mean(imdb$orcamento, na.rm = TRUE)


# temos uma função específica para testar se algo é NA!
is.na(idade_bia)
is.na(idade_tereza)

is.null(NULL)

# E COMO tirar NAs das nossas bases??

library(tidyverse)

imdb %>% 
  filter(!is.na(orcamento), !is.na(receita)) %>% View()



# tirar os NAs de todas as colunas com tidyr!
drop_na(imdb) %>% View()


imdb %>% 
  drop_na(orcamento, receita) %>% View()


