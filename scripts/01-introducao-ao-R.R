# Rodando códigos (o R como calculadora) ----------------------------------

# ATALHO para rodar o código: CTRL + ENTER

# adição
1 + 1

# subtração
4 - 2

# multiplicação
2 * 3

# divisão
5 / 3

# potência
4 ^ 2

# Objetos -----------------------------------------------------------------

# As bases de dados serão o nosso objeto de trabalho 
mtcars

# O objeto mtcars já vem com a instalação do R
# Ele está sempre disponível

# Outros exemplos 
pi
letters
LETTERS

# Na prática, vamos precisar trazer nossas bases
# para dentro do R. Como faremos isso?

# Funções -----------------------------------------------------------------

# Funções são nomes que guardam um código de R. Esse código é
# avaliado quando rodamos uma função.

nrow(mtcars) # número de linhas  - row sempre é linha
ncol(mtcars) # número de colunas  - col sempre é coluna

# Podemos usar a função help para ver
# a documentação de um objeto ou função
help(mtcars)
help(nrow)

# Uma função muito útil para data frames é a View
View(mtcars)

# Uma função pode ter mais de um argumento
# Argumentos são sempre separados por vírgulas

sum(1, 2)
sum(2, 3, 4)

# Existem funções para ler bases de dados

read.csv("dados/imdb.csv")

# comma separated value - arquivo de texto, valores separados por vírgula

# Como "salvar" a base dentro do R?

# Criando objetos ---------------------------------------------------------

# No dia-a-dia, a gente vai precisar criar os 
# nossos próprios objetos

# <- se chama atribuição


# Salvando o valor 1 no objeto "obj"
obj <- 1
obj

# Também dizemos 'guardando as saídas'
soma <- 2 + 2
soma

# ATALHO para a <- : ALT - (alt menos)

# Em geral, começaremos a nossa análise com:
nossa_base <- funcao_que_carrega_uma_base("caminho/ate/arquivo")

# "dados/por_ano/imdb_1929.rds"

# O erro "could not find function" significa que 
# você pediu para o R avaliar uma função que
# não existe. O mesmo vale para objetos:

nossa_base

# Dicas:
# - sempre leia as mensagens de erro
# - verifique no Environment se um objeto existe

# No nosso caso:
imdb <- read.csv("dados/imdb.csv")


# imdb_recentes <- # filtrando filmes recentes

# salvar saída versus apenas executar
33 / 11
resultado <- 33 / 11

# atualizar um objeto
resultado <- resultado * 5


# A nossa base imdb só será alterada quando salvarmos
# uma operação em cima do objeto imdb

na.exclude(imdb)
imdb_sem_na <- na.exclude(imdb)

# Os nomes devem começar com uma letra.
# Podem conter letras, números, _ e .

# Permitido

x <- 1
x1 <- 2
objeto <- 3
meu_objeto <- 4
meu.objeto <- 5

# Não permitido

# 1x <- 1 
# _objeto <- 2
# meu-objeto <- 3

# Estilo de nomes

eu_uso_snake_case
outrasPessoasUsamCamelCase # shiny
algumas.pessoas.usam.pontos.mas.nao.deviam
E_algumasPoucas.Pessoas_RENUNCIAMconvenções

# evitem usar acentos nos nomes dos objetos, arquivos, pastas
# use o estilo que vc gostar, mas seja consistente!




# checkpoint --------------------------------------------------------------


# 0. apague tudo do environment com a vassoura!

# 1. Escrevam (não copiem e colem) o código que lê a base e 
# a salva num objeto imdb. Rodem o código e observem 
# na aba environment se o objeto imdb apareceu.


imdb <-  read.csv("dados/imdb.csv")

# Classes -----------------------------------------------------------------

# as colunas das tabelas são como vetores!
imdb$titulo


imdb

# Cada coluna da base representa uma variável
# Cada variável pode ser de um tipo (classe) diferente

# Podemos somar dois números
1 + 2

# Não podemos somar duas letras (texto)
"a" + "b"

##############################
# Use aspas para criar texto #
##############################

a <- 10

# O objeto a, sem aspas
a

# A letra (texto) a, com aspas
"a"

# Numéricos (numeric)

a <- 10
class(a)

# Integer - número inteiro 

# Caracteres (character, strings)

obj <- "a"
obj2 <- "masculino"

class(obj)
class(obj2)

# lógicos (logical, booleanos)

verdadeiro <- TRUE
falso <- FALSE

class(verdadeiro)
class(falso)

# Data frames

class(mtcars)
class(imdb)


# Como acessar as colunas de uma base?
imdb$data_lancamento

# Como vemos a classe de uma coluna?

class(imdb$data_lancamento)

# Vetores -----------------------------------------------------------------

letters

imdb$nota_imdb


# Vetores são conjuntos de valores: use a função c()

vetor1 <- c(1, 4, 3, 10)
vetor2 <- c("a", "b", "z")

vetor1
vetor2

# Uma maneira fácil de criar um vetor com uma sequência de números
# é utilizar o operador `:`

# Vetor de 1 a 10
1:10

# Vetor de 10 a 1
10:1

# Vetor de -3 a 3
-3:3

# As colunas de data.frames são vetores
mtcars$mpg
imdb$titulo

class(mtcars$mpg)
class(imdb$titulo)

# O operador $ pode ser utilizado para selecionar
# uma coluna da base

# ----

# Um vetor só pode guardar um tipo de objeto e ele terá sempre
# a mesma classe dos objetos que guarda

vetor1 <- c(1, 5, 3, -10)
vetor2 <- c("a", "b", "c")

class(vetor1)
class(vetor2)

# Se tentarmos misturar duas classes, o R vai apresentar o
# comportamento conhecido como coerção

vetor <- c(1, 2, "a")

vetor
class(vetor)

# character > numeric > integer > logical

TRUE + TRUE # TRUE É ENTENDIDO COMO 1
FALSE # FALSE É ENTENDIDO COMO 0

# coerções forçadas por você
as.numeric(c(TRUE, FALSE, FALSE))

as.character(c(TRUE, FALSE, FALSE))

# Por consquência, cada coluna de uma base 
# guarda valores de apenas uma classe.

# Naturalmente, podemos fazer operações matemáticas com vetores

vetor <- c(0, 5, 20, -3)

vetor + 1
vetor - 1
vetor / 2
vetor * 10

# Você também pode fazer operações que envolvem mais de um vetor:

vetor1 <- c(1, 2, 3)
vetor2 <- c(10, 20, 30)

vetor1  + vetor2


# EXEMPLO - com múltiplos

vetor3 <- c(1, 2, 3, 4, 5, 6)
vetor4 <- c(10, 20, 30)

vetor3 + vetor4


# Exemplo quando o comprimento dos vetores não é múltiplo
vetor5 <- c(1, 2, 3, 4, 5, 6, 7)
vetor6 <- c(10, 20, 30)

vetor5 + vetor6

# Warning message:
#   In vetor5 + vetor6 :
#   longer object length is not a multiple of shorter object length


# Pacotes -----------------------------------------------------------------

# Para instalar pacotes

# install.packages("tidyverse")
library(tidyverse)

install.packages("dplyr")


install.packages("remotes")
remotes::install_github("tidyverse/dplyr")

# ── Attaching packages ──────────────────────────────────────── tidyverse 1.3.1 ──
# ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
# ✔ tibble  3.1.7     ✔ dplyr   1.0.9
# ✔ tidyr   1.2.0     ✔ stringr 1.4.0
# ✔ readr   2.1.2     ✔ forcats 0.5.1
# ── Conflicts ─────────────────────────────────────────── tidyverse_conflicts() ──
# ✖ dplyr::filter() masks stats::filter()
# ✖ dplyr::lag()    masks stats::lag()
# >


library(dplyr)

# Também é possível acessar as funções usando ::
dplyr::filter_at()
dplyr::transmute()


# Mostrar o glimpse!

library(dplyr)
imdb <- read.csv("dados/imdb.csv")

glimpse(imdb)


dplyr::glimpse(imdb)

glimpse(mtcars)

# > glimpse(imdb)
# Rows: 28,490
# Columns: 20
# $ id_filme             <chr> "tt0023352", "tt0037946", "tt0216204", "tt0171889", "tt0…
# $ titulo               <chr> "Prestige", "Nob Hill", "The Shade", "Viewer Discretion …
# $ ano                  <int> 1931, 1945, 1999, 1998, 1987, 1945, 1949, 1956, 2014, 20…
# $ data_lancamento      <chr> "1932-01-22", "1945-11-15", "2000-03-01", "2012-05-01", …
# $ generos              <chr> "Adventure, Drama", "Drama, Musical", "Drama", "Comedy, …
# $ duracao              <int> 71, 95, 83, 105, 133, 91, 81, 98, 50, 85, 267, 116, 98, …
# $ pais                 <chr> "USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA", …
# $ idioma               <chr> "English", "English", "English", "English", "English, Sp…
# $ orcamento            <int> NA, NA, 400000, NA, 20000000, NA, NA, 1505000, 500, 1000…
# $ receita              <dbl> NA, NA, NA, NA, 67331309, NA, NA, NA, NA, NA, NA, 149270…
# $ receita_eua          <int> NA, NA, NA, NA, 51249404, NA, NA, NA, NA, NA, NA, 905709…
# $ nota_imdb            <dbl> 5.7, 6.3, 7.1, 3.4, 7.2, 7.1, 6.3, 7.0, 5.7, 3.1, 7.0, 6…
# $ num_avaliacoes       <int> 240, 246, 102, 111, 26257, 1639, 310, 162, 115, 197, 201…
# $ direcao              <chr> "Tay Garnett", "Henry Hathaway", "Raphaël Nadjari", "Edd…
# $ roteiro              <chr> "Harry Hervey, Tay Garnett", "Wanda Tuchock, Norman Reil…
# $ producao             <chr> "RKO Pathé Pictures", "Twentieth Century Fox", "Filmaker…
# $ elenco               <chr> "Ann Harding, Adolphe Menjou, Melvyn Douglas, Ian Maclar…
# $ descricao            <chr> "A woman travels to a French penal colony in Indo China …
# $ num_criticas_publico <int> 12, 11, 1, 5, 142, 35, 8, 9, 4, 12, 4, 502, 6, 35, 17, N…
# $ num_criticas_critica <int> 2, 2, 1, 3, 62, 10, 5, NA, 5, 7, 7, 161, 1, 18, 8, 5, 15…