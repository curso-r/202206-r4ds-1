# install.packages("ggimage")
# install.packages("knitr")
?ggbackground
?geom_image



atletas_forbes |>
  select(nome, nacionalidade, arrecadacao, arrec_ano, ano) |> 
  filter(nacionalidade == "USA", ano  <= 2021) |>
  group_by(ano) |>
  summarise(mean(arrec_ano)) |>
  ggplot() +
  aes(x = ano, y = `mean(arrec_ano)`) +
  geom_line(size = 1.5, color = "#389468")+
  geom_point(size=2.5, color = "#389468")


?labs

library(Rcmdr)


at_2 <- atletas_forbes

forbes |> 
  filter(esporte == "Futebol") |> view()
  select(Atleta = nome,   
         `Arrecadação (M)` = arrec_ano, 
         Ano = ano) |> 
  slice_max(order_by = `Arrecadação (M)`, n=5) |> 
  kable()

  forbes |> 
    filter(esporte=="Futebol Americano") |> 
    select(Atleta = nome,   
           `Arrecadação (M)` = arrec_ano, 
           Ano = ano) |> 
    group_by(Atleta) |> 
    summarise(sum(`Arrecadação (M)`)) |> view()
  
  
  
 #corrigindo o nome do atleta Aaron Rodgers  
 forbes <- forbes |>
    filter(esporte == "Futebol Americano") |>
       mutate(nome = dplyr::case_when(
       stringr::str_detect(nome, "Aaron Rogers") ~ "Aaron Rodgers",
       TRUE ~ nome)) 
 
 
 |> 
    group_by(Atleta) |> 
    summarise(sum(`Arrecadação (M)`)) |> view()
    select(Atleta, arrecadação = sum(`Arrecadação (M)`)) |> 
    view()

# trocando os nomes das colunas
  
nfl<- nfl |> select( Atleta = Atleta, "Arrecadação total" = "sum(`Arrecadação (M)`)") |> 
kable(nfl)




    slice_max(order_by = sum(`Arrecadação (M)`), n=5) |> view()
  
  
  
   ggplot() +
   aes(x = Atleta, y = sum(`Arrecadação (M)`),
       fill = Atleta) +
   scale_y_continuous(breaks = seq(0, 2000, 100)) +
   labs(x = " Jogadores ",
        y = "Arrecadação ($)",
        subtitle = "Arrecadação somada dos 3 principais jogadores de futebol americano da Forbes") +
   labs(title = "Maiores arrecadações no futebol americano", hjust = 1) +
   scale_fill_viridis_d() +
   ggthemes::theme_few() 


 