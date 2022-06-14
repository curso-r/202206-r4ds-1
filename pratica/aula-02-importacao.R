# exemplo 1: leitura da base da dados imdb_nao_estruturada.xlsx ----------

# carregando o pacote readxl
library(readxl)

# lendo a base de dados
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx")

# ler a base pulando as linhas do começo
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx",
                   skip = 4)

# tirar o cabeçalho da base
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx",
                   skip = 4,
                   col_names = FALSE)

# lendo a tabela com o nome das colunas
colunas <- read_excel("dados/imdb_nao_estruturada.xlsx",
                      sheet = "Sheet1")

# funcao que da o nome das colunas da base de dados
names(imdb)

# vetor com os nomes das colunas
colunas$nome

# colocando o nome das colunas
names(imdb) <- colunas$nome

# mostra as primeiras 6 linhas da base de dados
head(imdb)

# mostra as ultimas 6 linhas da base de dados
tail(imdb)

# lendo a base de dados sem a as ultimas linhas
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx",
                   skip = 4,
                   col_names = FALSE,
                   n_max = 3713)

# veja que agora as duas linhas "erradas" foram retiradas
tail(imdb)

# fazendo a leitura "bonitinha" da base de dados, direto
imdb <- read_excel("dados/imdb_nao_estruturada.xlsx",
                   skip = 4,
                   col_names = colunas$nome,
                   n_max = 3713)


# exemplo 2 ---------------------------------------------------------------


# carregando o pacote readxl
library(readxl)

# criando objeto com a url da base de dados que queremos ler
url <- "http://orcamento.sf.prefeitura.sp.gov.br/orcamento/uploads/2022/basedadosexecucao2022_0622.xlsx"

# nome que queremos salvar a base de dados no nosso computador
destfile <- "basedadosexecucao2022_0622.xlsx"

# baixando a base de dados para o seu computador
curl::curl_download(url, destfile)

# fazendo a leitura da base de dados
basedadosexecucao2022_0622 <- read_excel(destfile)

# visualizando a base de dados
View(basedadosexecucao2022_0622)

# install.packages("janitor")

library(janitor)

# a funcao clean_names do pacote janitor
# padroniza os nomes das colunas e deixa "bonitinho"

dados_nomes_arrumados <- clean_names(basedadosexecucao2022_0622)