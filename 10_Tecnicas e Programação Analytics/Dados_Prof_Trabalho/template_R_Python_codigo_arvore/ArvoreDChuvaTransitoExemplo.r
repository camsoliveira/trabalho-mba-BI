####
# Exemplo de Arvore de Decisao em R
# com base em regressao linear
# Utilizando uma base de teste de transito em dias de chuva
# Arquivo utilizado: chuva_transito.csv
#

# Este script constrói uma análise de dados a partir de um dataset contendo informações 
# sobre a velocidade do trânsito em dois bairros de Salvador com base no volume de chuva 
# apurada nos horários de pico.


# importa as bibliotecas
library(readr)  # lib especializada em data frames
library(rpart)  # lib especializada em arvores de regressao e particionamento de ramos 
library(rpart.plot) # lib especializada em plotar arvores de regressao e particionamento de ramos

# ----------------------------------------
# CRIACAO DO DATA FRAME
# ----------------------------------------
# Le o arquivo "preparado" para a analise
# ler o arquivo com as informacoes sobre chuva e o transito
chuvaTransito = read.csv("chuva_transito.csv",header=TRUE, sep=";")

# ----------------------------------------
# CONSTRUINDO O MODELO
# ----------------------------------------
# Devemos pensar na arvore como uma funcao matematica y ~ x
# Ou seja, Y em funcao de X
# X corresponde as caractaristicas (variaveis independentes)
# Y corresponde ao alvo (variaveis dependentes)
# calcula a regressao linear para a construcao da arvore
arv_transito = rpart(velocidade ~ mm_chuva + bairro, data=chuvaTransito, method="poisson")

# -------------------------------------------------
# VISUALIZANDO O RESULTADO DO MODELO GRAFICAMENTE
# -------------------------------------------------
# Visualização do grafico
# realiza a plotagem da arvore de decisao
prp(arv_transito)
