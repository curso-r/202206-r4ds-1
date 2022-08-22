library(ggthemr)
library(gridtext)
library(ggtext)
library(plotly)
library(tidyverse)

BD <- read_csv(file = "projeto/NEOTROPICAL_XENARTHRANS_QUALITATIVE.csv")
glimpse(BD)

# Para retirar os sp. (espécies imprecisas)
BD_sp <- BD |> 
  filter(!str_detect(SPECIES, "sp.")) |> 
  mutate(SUBORDER = case_when(FAMILY %in% c("Bradypodidae", "Megalonychidae", "Megatheriidae", "Mylodontidae") ~ "Folivora",
                              FAMILY %in% c("Cyclopedidae", "Myrmecophagidae") ~ "Vermilingua"))

  
# Para selecionar apenas as colunas que deseja trabalhar
BD_resumo <- BD_sp |> 
  select(DATA_TYPE, SPECIES, GENUS, FAMILY, ORDER, IUCN_STATUS, SITE, STATE, COUNTRY, Annual_rainfall, Annual_temperature) 

# Para criar uma coluna com ID dos registros
BD_resumo |> 
  rowid_to_column() |> 
  head(10)

# Regisro por país ----
# número de contribuições por país - ordem decrescente (do > para <)
BD_resumo |> 
  count(COUNTRY) |> 
  arrange(desc(n)) |> 
  mutate(freq = round(n / sum(n)*100, digits = 1)) |> 
  print(n = 5)

#######################################
# Registros de sp por país ----
tabela_pais_sp <- BD_resumo |> 
  distinct(SPECIES, COUNTRY) |> 
  count(COUNTRY, sort = TRUE, name = "RICHNESS")
#arrange(desc(n))

# Data frame organizado por país e número de espécies por país ------
BD_resumo |> 
  distinct(SPECIES, COUNTRY) |>
  arrange(SPECIES) |> 
  group_by(COUNTRY) |>  
  mutate(newcol = paste(SPECIES, collapse = ', ')) |> 
  distinct(COUNTRY, newcol) |> 
  rename(SP = newcol) |> 
  left_join(tabela_pais_sp) |> 
  arrange(desc(RICHNESS)) |> 
  relocate(RICHNESS, .before = SP)

#####################################

# Registros de sp e país ----
tabela_pais_sp <- BD_resumo |> 
  distinct(SPECIES, COUNTRY) |> 
  count(SPECIES, sort = TRUE, name = "N_COUNTRIES")
#arrange(desc(n))

BD_resumo |> 
  distinct(SPECIES, COUNTRY) |>
  arrange(COUNTRY) |> 
  group_by(SPECIES) |>  
  mutate(newcol = paste(COUNTRY, collapse = ', ')) |> 
  distinct(SPECIES, newcol) |> 
  rename(COUNTRY = newcol) |> 
  left_join(tabela_pais_sp) |> 
  arrange(N_COUNTRIES) |> 
  relocate(N_COUNTRIES, .before = COUNTRY)

###################

# Registro BR ----
# filtrar as linhas com registros no BR, selecionar colunas específicas e ordenar a sp. por ordem alfabetica
#BD_resumo |> 
# filter(COUNTRY == "BRAZIL") |> 
#select(SPECIES, ORDER, SITE, STATE) |> 
#arrange(SPECIES) |> 
#View()


#### Espécies ameaçadas ----

BD_ameaca <- BD_sp |> 
  filter(IUCN_STATUS %in% c("VU", "CR", "EN")) |>
  mutate(ORDER = case_when(ORDER == "Cingulata" & SPECIES == "Myrmecophaga tridactyla" ~ "Pilosa",
                           TRUE ~ ORDER)) |> 
  count(SPECIES, FAMILY, ORDER, IUCN_STATUS) |> 
  arrange(SPECIES, ORDER)

# Gráfico das espécies ameaçadas
BD_ameaca |> 
  mutate(
    SPECIES = forcats::fct_reorder(SPECIES, n)
  ) |> 
  ggplot(aes(x = SPECIES, y = n)) +
  geom_col(
    aes(fill = IUCN_STATUS),
    width = 0.7,
    alpha = 0.9
  ) +
  geom_label(
    aes(label = scales::comma(n)), #para colocar separador de milhar nos rótulos
    size = 3 # para diminuir o tamanho dos rótulos
  ) + 
  scale_fill_discrete(
    "IUCN status",
    labels = c("Critically", "Vulnerable")
  ) +
  scale_y_continuous(
    limits = c(1, 10000),
    expand = expansion(mult = c(0, 0)),
    trans = "log10", # para colocar o dado na base log10
    # labels = scales::label_comma() #mesma função da linha abaixo, porém o gráfico não renderizou
    labels = scales::label_number(big.mark = ",") # para colocar o separador de milhar
  ) +
  labs(
    y = "Occurrence (log_10_)",
    x = "Specie",
    title = "Endangered species",
    caption = "Fonte: github.com/LEEClab"
  ) +
  ggthemr::ggthemr("pale")$theme +
  theme(
    axis.title.y = element_markdown(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.text.x = element_text(face = "italic"),
    panel.grid.major.x = element_blank() 
  )

ggsave("graficos_output/endangered_species.png",
       dpi = "retina", # resolucao
       width = 9.5, #largura
       height = 5 #altura
)


# Gráficos temperatura Brasil - com todas os dados
Grafico_todos <- BD_resumo |> 
  filter(COUNTRY == "BRAZIL") |>
  ggplot() +
  geom_point(aes(x = Annual_rainfall, y = Annual_temperature)) +
  scale_x_continuous(
    labels = scales::label_number(big.mark = ",")
  ) +
  ggthemr::ggthemr ("pale")$theme +
  theme(
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold")
  ) +
  labs(
    y = "Temperature",
    x = "Rainfall",
    title = "Mean annual temperature x Accumulated rainfall",
    subtitle = "All groups of Xenarthras",
    caption = "Fonte: github.com/LEEClab"
  )
ggplotly(Grafico_todos)

ggsave("graficos_output/scatter_xenarthra.png",
       dpi = "retina", # resolucao
       width = 9.5, #largura
       height = 4.5 #altura
)

# y <- BD_resumo |> 
#   filter(COUNTRY == "BRAZIL") |>
#   arrange(Annual_rainfall)

#### Gráfico com dados de Folivora
BD_sp |> 
  filter(COUNTRY == "BRAZIL",
         SUBORDER == "Folivora",
         Annual_rainfall > 0,
         Olsoneconame != "Patagonian steppe") |> 
  arrange(Annual_rainfall) |> 
  ggplot() +
  geom_point(aes(
    x = Annual_rainfall, 
    y = Annual_temperature, 
    color = FAMILY),
    alpha = 0.6) +
  facet_grid(. ~ SPECIES) +
  scale_x_continuous(
    labels = scales::label_number(big.mark = ",")
  ) +
  ggthemr::ggthemr("pale")$theme +
  labs(
    y = "Temperature (°C)",
    x = "Rainfall (mm)",
    title = "Mean annual temperature x Accumulated rainfall",
    subtitle = "Suborder Folivora",
    color = "Family",
    caption = "Fonte: github.com/LEEClab"
  ) +
  theme_light() +
  theme(
    legend.position = "bottom",
    axis.title.y = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    panel.grid = element_line(linetype = 2),
    strip.text = element_text(face = "italic"),
    # strip.background = element_rect(fill = "gray90")
  )

ggsave("graficos_output/scatter_folivora.png",
       dpi = "retina", # resolucao
       width = 9.5, #largura
       height = 4.5 #altura
)

#### Gráfico com dados de Vermilingua
BD_sp |> 
  filter(COUNTRY == "BRAZIL",
         SUBORDER == "Vermilingua",
         Annual_rainfall > 0,
         Olsoneconame != "Patagonian steppe") |> 
  arrange(Annual_rainfall) |> 
  ggplot() +
  geom_point(aes(
    x = Annual_rainfall, 
    y = Annual_temperature, 
    color = FAMILY),
    alpha = 0.4) +
  facet_grid(. ~ SPECIES) +
  scale_x_continuous(
    labels = scales::label_number(big.mark = ",")
  ) +
  ggthemr::ggthemr("pale")$theme +
  labs(
    y = "Temperature (°C)",
    x = "Rainfall (mm)",
    title = "Mean annual temperature x Accumulated rainfall",
    subtitle = "Suborder Vermilingua",
    color = "Family",
    caption = "Fonte: github.com/LEEClab"
  ) +
  theme_light() +
  theme(
    legend.position = "bottom",
    axis.title.y = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    panel.grid = element_line(linetype = 2),
    strip.text = element_text(face = "italic"),
  )

ggsave("graficos_output/scatter_vermilingua.png",
       dpi = "retina", # resolucao
       width = 9.5, #largura
       height = 4.5 #altura
)


#### Gráfico com dados de Cingulata
BD_sp |> 
  filter(COUNTRY == "BRAZIL",
         ORDER == "Cingulata",
         Annual_rainfall > 0,
         Olsoneconame != "Patagonian steppe",
         FAMILY != "Myrmecophagidae") |> 
  arrange(ORDER, FAMILY, SPECIES) |> 
  mutate(SPECIES = as_factor(SPECIES)) |> 
  ggplot() +
  geom_point(aes(
    x = Annual_rainfall, 
    y = Annual_temperature, 
    color = FAMILY),
    alpha = 0.4) +
  facet_wrap(. ~ SPECIES,
             labeller = label_wrap_gen(width = 10)) +
  scale_x_continuous(
    labels = scales::label_number(big.mark = ",")
  ) +
  ggthemr::ggthemr("pale")$theme +
  labs(
    y = "Temperature (°C)",
    x = "Rainfall (mm)",
    title = "Mean annual temperature x Accumulated rainfall",
    subtitle = "Order Cingulata",
    color = "Family",
    caption = "Fonte: github.com/LEEClab"
  ) +
  theme_light() +
  theme(
    legend.position = "bottom",
    axis.title.y = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    panel.grid = element_line(linetype = 2),
    strip.text = element_text(face = "italic"),
  )

ggsave("graficos_output/scatter_cingulata.png",
       dpi = "retina", # resolucao
       width = 9.5, #largura
       height = 8 #altura
)
