library(tidyverse)
library(janitor)
starwars |>
  rename_with(~ stringr::str_replace(.x, "_color", "_cor"))


substuir_texto <- function(texto){
  str_replace(texto, "_color", "_cor")
}

substuir_texto(names(starwars))

substuir_texto_2 <- function(.x){
  str_replace(.x, "_color", "_cor")
}

substuir_texto_2(names(starwars))


starwars |>
  rename_with(substuir_texto_2)

# clean names ---
#
# clean_names()
#
#
# make_clean_names("lero lero aaa blabla 1384q29492 %ˆ$%ˆ$%ˆ")
#
#
#
# str_remove_all("Fórum Conan o Bárbaro'; há 9 dias; PH, uma pergunta...
#                qual música te salva do Vecna?! (Eh bom a gente saber, neh...
#                vai que precisa!) 😁", )
#
# library(stringr)
# base |>
#   mutate(
#     coluna_sem_emoji = str_remove_all(comentarios, pattern = '[:emoji:]')
#
