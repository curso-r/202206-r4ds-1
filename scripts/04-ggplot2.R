
# Carregar pacotes --------------------------------------------------------

library(tidyverse)

options(scipen = 999)

# Ler base IMDB -----------------------------------------------------------

imdb <- read_rds("dados/imdb.rds")

imdb <- imdb %>%
  mutate(lucro = receita - orcamento)


# Gráfico de pontos (dispersão) -------------------------------------------

# Apenas o canvas
imdb %>% 
  ggplot()

# Salvando em um objeto
p <- imdb %>% 
  ggplot()


# Gráfico de dispersão da receita contra o orçamento
imdb %>% 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita))

# Inserindo a reta x = y
imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita)) +
  geom_abline(intercept = 0, slope = 1, color = "red")


imdb %>%
  ggplot() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  geom_point(aes(x = orcamento, y = receita)) 


# y = a + bx
# intercet = a - é onde a reta cruza o eixo Y
# slope = b

# Observe como cada elemento é uma camada do gráfico.
# Agora colocamos a camada da linha antes da camada
# dos pontos.
imdb %>%
  ggplot() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  geom_point(aes(x = orcamento, y = receita))

# Atribuindo a variável lucro aos pontos
imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucro))

# Categorizando o lucro antes
imdb %>%
  mutate(
    lucrou = ifelse(lucro <= 0, "Não", "Sim")
  ) %>% 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucrou), alpha = 0.5)

# Salvando um gráfico em um arquivo
imdb %>%
  mutate(
    lucrou = ifelse(lucro <= 0, "Não", "Sim")
  ) %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucrou))

# se você não especificar essas parâmetros,  ele salva por default do jeito 
# que ta na sua tela do R
ggsave("graficos_output/meu_grafico.png")

# podemos especificar o tamanho
ggsave("graficos_output/meu_grafico.png", 
       dpi = 300, # resolucao
       width = 7, #largura
       height = 5 #altura
       ) 


# Filosofia ---------------------------------------------------------------

# Um gráfico estatístico é uma representação visual dos dados 
# por meio de atributos estéticos (posição, cor, forma, 
# tamanho, ...) de formas geométricas (pontos, linhas,
# barras, ...). Leland Wilkinson, The Grammar of Graphics

# Layered grammar of graphics: cada elemento do 
# gráfico pode ser representado por uma camada e 
# um gráfico seria a sobreposição dessas camadas.
# Hadley Wickham, A layered grammar of graphics 

# Gráfico de linhas -------------------------------------------------------

# Nota média dos filmes ao longo dos anos

# x = ano 
# y = nota média 
# precisamos de uma base com 1 linha por ano, e não
# 1 linha por filme!


imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media))

# podemos colocar linhas e pontos!
imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) +
  geom_point(aes(x = ano, y = nota_media))


# segunda forma possível
imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot(aes(x = ano, y = nota_media)) +
  geom_line() +
  geom_point()

# terceira forma possivel
imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot() +
  aes(x = ano, y = nota_media) +
  geom_line() +
  geom_point()


# apenas filmes a partir de 1912?
imdb %>% 
  filter(ano >= 1912) %>% 
  drop_na(ano) %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot() +
  aes(x = ano, y = nota_media) +
  geom_line() +
  geom_point()


# Dúvida do Luiz -------------------

imdb %>% 
  ggplot() +
  geom_point(aes(x = ano, y = nota_imdb))

# precisamos calcular a media!

imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot(aes(x = ano, y = nota_media)) +
  geom_point() +
  geom_line()

# Duvida da Daniela

imdb %>% 
  mutate(date_lancamento = as.Date(data_lancamento),
         mes_ano = lubridate::floor_date(date_lancamento, "month")) %>%
  group_by(mes_ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm= TRUE)) %>%
  ggplot() +
  geom_line(aes(x = mes_ano, y = nota_media))


# Dúvida Tales
# Uma dúvida de data também. Como transformar uma variável char "2022-06" em Date?

base_exemplo <- tibble(data_texto = c("2022-06", "2022-04", "2022-05"))


base_exemplo %>% 
  mutate(data_date = readr::parse_date(data_texto, format = "%Y-%m"))


base_exemplo2 <- tibble(data_texto = c("30/06/2022",
                                       "15/02/1993",
                                       "12/04/2012"))


base_exemplo2 %>% 
  mutate(data_date = readr::parse_date(data_texto, format = "%d/%m/%Y"))


# Número de filmes por ano ------

# imbd - x = ano, y = soma de filmes por ano

imdb %>% 
  filter(!is.na(ano), ano != 2020) %>% 
  group_by(ano) %>% 
  summarise(num_filmes = n()) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = num_filmes)) 


imdb %>% 
  drop_na(ano) %>% 
  count(ano)

# Nota média do Robert De Niro por ano
imdb %>%
  filter(str_detect(elenco, "Robert De Niro")) %>%
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media))

# Colocando pontos no gráfico
imdb %>% 
  filter(str_detect(elenco, "Robert De Niro")) %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) +
  geom_point(aes(x = ano, y = nota_media))

# Reescrevendo de uma forma mais agradável
grafico_deniro <- imdb %>% 
  filter(str_detect(elenco, "Robert De Niro")) %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  mutate(nota_media = round(nota_media, 1)) %>% 
  ggplot(aes(x = ano, y = nota_media)) +
  geom_line() +
  geom_point()


library(plotly)
ggplotly(grafico_deniro)

# dúvida da Mariângela
imdb %>% 
  filter(str_detect(elenco, "Robert De Niro"), nota_imdb < 4) %>% 
  select(titulo, ano, nota_imdb)

# Colocando as notas no gráfico
imdb %>% 
  filter(str_detect(elenco, "Robert De Niro")) %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  mutate(nota_media = round(nota_media, 1)) %>% 
  ggplot(aes(x = ano, y = nota_media)) +
  geom_line() +
  geom_label(aes(label = nota_media))


# Gráfico de barras -------------------------------------------------------

# Número de filmes das pessoas que dirigiram filmes na base
imdb %>% 
  count(direcao) %>%
  slice_max(order_by = n, n = 10) %>% 
  ggplot() +
  geom_col(aes(x = direcao, y = n))

# Tirando NA e pintando as barras
imdb %>% 
  count(direcao) %>%
  filter(!is.na(direcao)) %>% 
  slice_max(order_by = n, n = 10) %>% 
  ggplot() +
  geom_col(
    aes(x = direcao, y = n, fill = direcao),
    show.legend = FALSE
  )

# Invertendo as coordenadas
imdb %>% 
  count(direcao) %>%
  filter(!is.na(direcao)) %>% 
  slice_max(order_by = n, n = 10) %>% 
  ggplot() +
  geom_col(
    aes(x = n, y = direcao, fill = direcao),
    show.legend = FALSE
  ) 
  

# Ordenando as barras
imdb %>% 
  count(direcao) %>%
  filter(!is.na(direcao)) %>% 
  slice_max(order_by = n, n = 10) %>% 
  mutate(
    direcao = forcats::fct_reorder(direcao, n)
  ) %>% 
  ggplot() +
  geom_col(
    aes(x = n, y = direcao, fill = direcao),
    show.legend = FALSE
  ) 

# Colocando label nas barras
top_10_direcao <- imdb %>% 
  count(direcao) %>%
  filter(!is.na(direcao)) %>% 
  slice_max(order_by = n, n = 10) 

top_10_direcao %>%
  mutate(
    direcao = forcats::fct_reorder(direcao, n)
  ) %>% 
  ggplot() +
  geom_col(
    aes(x = n, y = direcao, fill = direcao),
    show.legend = FALSE
  ) +
  geom_label(aes(x = n/2, y = direcao, label = n)) 


# Histogramas e boxplots --------------------------------------------------

# Histograma do lucro dos filmes do Steven Spielberg 
imdb %>% 
  filter(direcao == "Steven Spielberg") %>%
  ggplot() +
  geom_histogram(aes(x = lucro))

# Arrumando o tamanho das bases
imdb %>% 
  filter(direcao == "Steven Spielberg") %>%
  ggplot() +
  geom_histogram(
    aes(x = lucro), 
    binwidth = 100000000,
    color = "white"
  )

# Boxplot do lucro dos filmes das pessoas que dirigiram
# mais de 30 filmes
imdb %>% 
  filter(!is.na(direcao)) %>%
  group_by(direcao) %>% 
  filter(n() >= 30) %>% 
  mutate(lucro = receita - orcamento) %>% 
  ggplot() +
  geom_boxplot(aes(x = direcao, y = lucro))

# Ordenando pela mediana

imdb %>% 
  filter(!is.na(direcao)) %>%
  group_by(direcao) %>% 
  filter(n() >= 30) %>% 
  ungroup() %>% 
  mutate(
    lucro = receita - orcamento,
    direcao = forcats::fct_reorder(direcao, lucro, na.rm = TRUE)
  ) %>% 
  ggplot() +
  geom_boxplot(aes(x = direcao, y = lucro))

# Título e labels ---------------------------------------------------------

# Labels
imdb %>%
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita, color = lucro)) +
  labs(
    x = "Orçamento ($)",
    y = "Receita ($)",
    color = "Lucro ($)",
    title = "Gráfico de dispersão",
    subtitle = "Receita vs Orçamento",
    caption = "Fonte: imdb.com"
  )

# Escalas
imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) +
  scale_x_continuous(breaks = seq(1896, 2016, 10)) +
  scale_y_continuous(breaks = seq(0, 10, 2))

# Visão do gráfico
imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) +
  scale_x_continuous(breaks = seq(1896, 2016, 10)) +
  scale_y_continuous(breaks = seq(0, 10, 2)) +
  coord_cartesian(ylim = c(0, 10))

# Cores -------------------------------------------------------------------

# Escolhendo cores pelo nome
imdb %>% 
  count(direcao) %>%
  filter(!is.na(direcao)) %>% 
  slice_max(order_by = n, n = 5) %>% 
  ggplot() +
  geom_col(
    aes(x = n, y = direcao, fill = direcao), 
    show.legend = FALSE
  ) +
  scale_fill_manual(values = c("orange", "royalblue", "purple", "salmon", "darkred"))
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# Escolhendo pelo hexadecimal
imdb %>% 
  count(direcao) %>%
  filter(!is.na(direcao)) %>% 
  slice_max(order_by = n, n = 5) %>% 
  ggplot() +
  geom_col(
    aes(x = n, y = direcao, fill = direcao), 
    show.legend = FALSE
  ) +
  scale_fill_manual(
    values = c("#ff4500", "#268b07", "#ff7400", "#abefaf", "#33baba")
  )

# Mudando textos da legenda
imdb %>% 
  mutate(sucesso_nota = case_when(nota_imdb >= 7 ~ "sucesso_nota_imbd",
                                  TRUE ~ "sem_sucesso_nota_imdb")) %>%
  group_by(ano, sucesso_nota) %>% 
  summarise(num_filmes = n()) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = num_filmes, color = sucesso_nota)) +
  scale_color_discrete(labels = c("Nota menor que 7", "Nota maior ou igual à 7"))

# Definiando cores das formas geométricas
imdb %>% 
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita), color = "#ff7400")

# Tema --------------------------------------------------------------------

# Temas prontos
imdb %>% 
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita)) +
  # theme_bw() 
  # theme_classic() 
  # theme_dark()
  theme_minimal()

# A função theme()
imdb %>% 
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita)) +
  labs(
    title = "Gráfico de dispersão",
    subtitle = "Receita vs Orçamento"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

# Mais conteúdo sobre a função theme() no curso de
# visualizacao de dados
# https://loja.curso-r.com/visualizac-o-de-dados.html
