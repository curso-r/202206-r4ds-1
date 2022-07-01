library(tidyverse)
library(janitor)
# exemplo 1

df_especies <- starwars |> 
  count(species, sort = TRUE)

df_especies[[1,1]]

df_especies[[1, 2]]


# exemplo 2------
sum(df_especies$n)

df_especies |>
  adorn_totals()

# procurar se tem uma forma no tidyverse para adicionar os totais.

# final da aula ----
# destacar pontos
install.packages("gghighlight")

library(tidyverse)
library(dados)

starwars <- dados_starwars


starwars %>% 
  ggplot() +
  geom_point(aes(x = altura, y = massa)) +
  gghighlight::gghighlight(massa > 1000, label_key = nome)

# usar esquisse no browser

options("esquisse.viewer" = "browser")
esquisse::esquisser(starwars)

# mananciais duvida do Luiz -------------

library(readr)
library(magrittr)
library(ggplot2)
library(dplyr)

mananciais <-
  read_delim(
    "https://github.com/beatrizmilz/mananciais/raw/master/inst/extdata/mananciais.csv",
    ";",
    escape_double = FALSE,
    col_types = cols(data = col_date(format = "%Y-%m-%d")),
    locale = locale(decimal_mark = ",", grouping_mark = "."),
    trim_ws = TRUE
  )

pluviometria_mensal <- mananciais %>% 
  mutate(mes_ano = lubridate::floor_date(data, "month"),
         dia = lubridate::day(data)) %>% 
  group_by(mes_ano, sistema) %>% 
  filter(dia == max(dia)) %>% 
  select(mes_ano, sistema, pluviometria_mensal) %>% 
  ungroup() 


pluviometria_mensal %>% 
  ggplot() +
  geom_line(aes(x = mes_ano, y = pluviometria_mensal, color = sistema), show.legend = FALSE)+
  facet_wrap(vars(sistema))


# duvida do Rafael

library(tidyverse)

# Usa a base starwars do dplyr
base_classes <- starwars |> 
  # cria coluna dos ultimos dois digitos: usando a funcao str_sub
  mutate(ultimos_dig = as.numeric(str_sub(height, -2, -1)),
         # cria a coluna da classe
         classe = case_when(
           # criando as classes aqui
           ultimos_dig %in% 0:20 ~ "0-20",
           ultimos_dig %in% 21:40 ~ "21-40",
           ultimos_dig %in% 41:60 ~ "41-60",
           ultimos_dig %in% 61:80 ~ "61-80",
           ultimos_dig %in% 81:99 ~ "81-99",
           # o que nao ficou em classes anteriores fica com esse valor colocado
           # em "outra classe"
           TRUE ~ "outra classe"
         )) 


base_classes %>% 
  count(classe) %>% 
  ggplot() +
  geom_col(aes(y = classe, x = n))

# para definir a ordem das classes
base_classes %>%
  count(classe) %>%
  mutate(classe_fct = factor(
    classe,
    # aqui voce define a ordem!
    levels = c("outra classe",
               "0-20",
               "21-40",
               "41-60",
               "61-80",
               "81-99")
  )) %>%
  ggplot() +
  geom_col(aes(y = classe_fct, x = n))


