# Exemplo 1: Star Wars --------------------------------------------------------
# Objetivo: analisar a relação "peso vs altura" dos personagens
# Star Wars
# contar a historia do will pra contextualizar de onde surgiu essa curiosidade!

library(tidyverse)
library(dados)
library(gghighlight)

# base de dados do starwars
starwars <- dados_starwars

# gráfico massa x altura personagens star wars

# jeito 1
starwars |> 
  ggplot() +
  geom_point(aes(x = altura, y = massa))

# jeito 2
starwars |> 
  ggplot(aes(x = altura, y = massa)) +
  geom_point()

# jeito 3
starwars |> 
  ggplot() +
  aes(x = altura, y = massa) +
  geom_point()

# filtrando o ponto destoante
starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  geom_point(aes(x = altura, y = massa))

# colorindo os pontos pela variavel genero
starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  geom_point(aes(x = altura, 
                 y = massa, 
                 color = genero))

# dando destaque ao ponto destoante
starwars |> 
  ggplot() +
  geom_point(aes(x = altura, y = massa)) +
  gghighlight(massa > 1000, label_key = nome)

# install.packages("esquisse")
library(esquisse)

# fazer graficos point and click e copiar o codigo!
esquisser(starwars)

# copiei o codigo do grafico que fiz no esquisse
starwars %>%
  filter(massa >= 15L & massa <= 1087L | is.na(massa)) %>%
  ggplot() +
  aes(x = altura, y = massa, colour = genero) +
  geom_point(shape = "circle", size = 2.4) +
  scale_color_viridis_d(option = "viridis", direction = 1) +
  labs(title = "Massa x Altura ") +
  theme_minimal()


# Exemplo 2: Mananciais -------------------------------
# Objetivo: Visualizar o nível dos reservatórios ao 
# longo do ano de 2022.
# "https://github.com/beatrizmilz/mananciais/raw/master/inst/extdata/mananciais.csv",

# fiz a leitura da base pelo Import Dataset e copiei o codigo
library(readr)
mananciais <- read_delim("https://github.com/beatrizmilz/mananciais/raw/master/inst/extdata/mananciais.csv", 
                         delim = ";", 
                         escape_double = FALSE, 
                         col_types = cols(data = col_date(format = "%Y-%m-%d")), 
                         locale = locale(decimal_mark = ",", grouping_mark = "."), 
                         trim_ws = TRUE)
View(mananciais)

# vendo a evolução do nível de cada reservatório no ano de 2022
# (uma linha por cada sistema)
mananciais |> 
  mutate(ano = lubridate::year(data)) |> 
  filter(ano == 2022) |>
  ggplot() +
  geom_line(aes(x = data, 
                y = volume_porcentagem, 
                color = sistema),
            size = 2)

# fazendo um grafico para cada sistema da evolucao do nivel de agua
# ao longo de todo o periodo, colorindo por sistema
mananciais |> 
  ggplot() +
  geom_line(aes(x = data, 
                y = volume_porcentagem,
                color = sistema),
            size = 1,
            show.legend = FALSE) +
  facet_wrap(~sistema)

# sugestão do Luiz:
# calcular o volume medio de cada sistema para cada ano
mananciais |> 
  mutate(ano = lubridate::year(data)) |> 
  group_by(ano, sistema) |> 
  summarise(volume_medio = mean(volume_porcentagem, na.rm = TRUE)) |> 
  ggplot() +
  geom_line(aes(x = ano, 
                y = volume_medio, 
                color = sistema),
            size = 2) 