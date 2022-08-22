# análise descritiva dos Xenarthras Neotropicais

library(tidyverse)

# Atribuir objeto ----
# a primeira ação foi atribuir o data frame do Xenarthrans com o nome BD.
# depois foi padronizar as informações da coluna "site" em UpperCase - uma vez que o R entende letras maiúsculas e minúsculas, para filtrar a informação por site depois, é necessário ter toda informação padronizada

BD <- read_csv(file = "projeto/NEOTROPICAL_XENARTHRANS_QUALITATIVE.csv") |> 
  mutate(SITE = (str_to_upper(SITE)))


# Visualizar BD ---- 
#para ver todas as colunas do data frame/para ver o resumo do data frame
glimpse(BD)
names(BD)
summary(BD)


# Regisro por país ----
# número de contribuições por país - ordem decrescente (do > para <)
BD |> 
  count(COUNTRY) |> 
  arrange(desc(n)) |> 
  mutate(freq = round(n / sum(n)*100, digits = 1)) |> 
  print(n = 5)

BD |> 
  nrow()


# Registros de sp por país ----
BD |> 
  distinct(SPECIES, COUNTRY)

# Registro BR ----
# filtrar as linhas com registros no BR, selecionar colunas específicas e ordenar a sp. por ordem alfabetica
BD |> 
  filter(COUNTRY == "BRAZIL") |> 
  select(SPECIES, ORDER, SITE, STATE) |> 
  arrange(SPECIES) |> 
  View()

# Registros parques ----
# filtrar as linhas com registros no BR, selecionar colunas específicas e filtrar apenas registros dentro de parques no BR
BD |> 
  filter(COUNTRY == "BRAZIL") |> 
  filter(str_detect(SITE, "PARQUE")) |> 
  select(SPECIES, ORDER, SITE, STATE) |>
  arrange(STATE, SITE, ORDER, SPECIES) |> 
  View()

# mesma função anterior, porém selecionando também os nomes "parks"
# criei um objeto com vetor "PARQUE" e "PARK" para poder "chamar" ele através do string_detect depois. Assim, o string_detect vai retornar todas os registros que contrnham as palavras "PARQUE" e "PARK"
park <- c("PARQUE", "PARK")
BD |> 
  filter(COUNTRY == "BRAZIL") |> 
  filter(str_detect(SITE,park)) |>  
  select(SPECIES, ORDER, SITE, STATE) |>
  arrange(STATE, SITE, ORDER, SPECIES) |> 
  View()


# n especies e % ---- 
# especies, n de registros e % 
BD |> 
  count(SPECIES) |> 
  arrange(desc(n)) |> 
  mutate(freq = round(n / sum(n)*100, digits = 1)) |> 
  print(n = Inf)


# n especies s/ sp ----
# atribuir um novo objeto sem as identificações imprecisas (sem o sp.)
BD_sp <- BD |> 
  filter(!str_detect(SPECIES, " sp.")) 

BD_sp |> 
  count(SPECIES) |> 
  arrange(desc(n)) |> 
  mutate(freq = round(n / sum(n)*100, digits = 1)) |> 
  print(n = Inf)

# # sumarizando
# BD |> 
#   summarise(
#     qtd = n(),
#     qtd_sp = distinct(SPECIES)
#   )


# Temperatura sp ----
# para verificar as sps. e qual a temperatura media onde foram registradas 
temp <- BD_sp |> 
  group_by(SPECIES) |> 
  summarise(media_temp = mean(Annual_temperature, na.rm = TRUE)) |> 
  arrange(media_temp) |> 
  print(n = Inf)

# Chuva sp ----
# para verificar as sps. e qual a precipitacao media onde foram registradas 
precip <- BD_sp |> 
  group_by(SPECIES) |> 
  summarise(media_precip = mean(Annual_rainfall, na.rm = TRUE)) |> 
  arrange(media_precip) |> 
  print(n = Inf)

pre_cor <- temp |> 
  inner_join(precip) |> 
  select(-1)

cor <- cor(pre_cor)

corrplot::corrplot(cor, method = 'number')

# Ameaçadas ----
# para veriicar quais são as especies ameaçadas
# Obs: Foi encontrao um erro no BD - ordem tamandua 
BD_ameac <- BD |> 
  filter(IUCN_STATUS %in% c("VU", "CR", "EN")) |>
  distinct(SPECIES, FAMILY, ORDER, IUCN_STATUS) |> 
  arrange(SPECIES, ORDER)

# Gráfico de barras -------------------------------------------------------

# Número de registros por família
BD |>  
  count(FAMILY) |> 
  # slice_max(order_by = n, n = 5) |>
  ggplot() +
  geom_col(aes(x = reorder(FAMILY, -n, sum), y = n)) +
  scale_y_continuous(breaks = seq(from = 0, to = 14000, by = 2000), 
                     expand = expansion(mult = c(0,0)),
                     limits =  c(0, 14000)) +
  labs(x = "Família", y = "") +
  theme(axis.title = element_text(face = "bold"))


##### Selecionar colunas e linhas específicas do seu BD

#  PARA PEGAR AS INFORMAÇÕES DA LINHA 1 E COLUNA 1:
  
BD |> 
  count(SPECIES, sort = TRUE)

BD[[1,5]]

BD[[1, 5]]



