#######################################################
#  Exemplo de modelo preditivo com Arvore de Decisao
#  Autor: Luis Porciuncula
#  Objetivo: este programa serve como modelo para elaboracao do trabalho da disciplina
#  MBA/UCSal
#

# Carrega as Bibliotecas
import pandas as pd
from sklearn.tree import DecisionTreeClassifier # Importa o Decision Tree Classifier
from sklearn.model_selection import train_test_split # Importa a funcao train_test_split
from sklearn import metrics #Importa da scikit-learn metrics o  modulo para calculo da acuracia

# ----------------------------------------
# CRIACAO DO DATA FRAME
# ----------------------------------------
# Le o arquivo "preparado" para a analise
transito = pd.read_csv("C:/Users/luisp/Desktop/chuva_transito.csv",sep=";")
nome_colunas = ['mm_chuva','bairro','velocidade']  # Define um nome amigavel para as colunas
transito.columns = nome_colunas    # Atribui o novo nome as colunas do Data Frame

# ----------------------------------------
# PREPARACAO DOS DADOS PARA ANALISE
# ----------------------------------------
# Inicio do Data Wrangling
# Diferente de R, a ScikitLearning ainda precisa discretizar os dados do tipo string
# Discretizando os bairros
transito.loc[transito['bairro']=='cabula', "bairro"] = 0 # Cabula
transito.loc[transito['bairro']=='brotas', "bairro"] = 1 # Brotas
# Fazendo um facilitador da analise: criei uma categoria para faixas de velocidade
# criando um novo campo: fluxo_bairro que pode ser:
# 0 = fluxo normal, 1 = transito lento e 2 = congestionamento
transito.loc[(transito['velocidade']>=40), "fluxo_bairro"] = 0 # Fluxo com velocidade "Normal"
transito.loc[(transito['velocidade']>26) & (transito['velocidade']<40), "fluxo_bairro"] = 1 # Fluxo com trafego "Lento"
transito.loc[(transito['velocidade']>=0) & (transito['velocidade']<=26), "fluxo_bairro"] = 2 #  Fluxo "Congestionado"

# ----------------------------------------
# CONSTRUINDO O MODELO
# ----------------------------------------
# Devemos pensar na arvore como uma funcao matematica y ~ x
# Ou seja, Y em funcao de X
# X corresponde as caractaristicas (variaveis independentes)
# Y corresponde ao alvo (variaveis dependentes)

# Divide o dataset em caracteristicas e alvo
caracteristicas_cols = ['bairro','velocidade','mm_chuva'] # Especificacao das variaveis independentes
X = transito[caracteristicas_cols] # caracteristicas
y = transito.fluxo_bairro # Variavel alvo - Especificacao da variavel dependente

# A ScikitLearn exige que o dataset seja dividido em dados de treinamento e teste

# Divide o dataset em conjunto de treinamento e conjunto de teste com as caracteristicas e o alvo
# A funcao train_test_split retorna 4 dataseets com amostras: dados de treino das caracteristicas
# e dos alvos, dados de teste das caracteristicas e dos alvos
X_treino, X_teste, y_treino, y_teste = train_test_split(X, y, test_size=0.2, random_state=1) # 80% para treinamento e 20% para teste

# Cria um objeto classificador em arvore de decisao
classificacao = DecisionTreeClassifier()

# ----------------------------------------
# TREINANDO O MODELO
# ----------------------------------------
# Treina o classificador da arvore de decisao: o metodo fit realiza do treinamento
# do modelo com os datasets de amostra das caracteristicas e dos alvos
classificacao = classificacao.fit(X_treino,y_treino)

# ----------------------------------------
# TESTANDO O MODELO
# ----------------------------------------
# Prediz a resposta testando o dataset
# Verifica se o modelo criado consegue classificar o dataset de teste com base nas caracteristicas
# para "adivinhar" o resultado
y_pred = classificacao.predict(X_teste)

# Verifica a acuracia do modelo: com que frequencia o classificador esta correto?
print("Acuracia do modelo:",metrics.accuracy_score(y_teste, y_pred),"%")

# -------------------------------------------------
# VISUALIZANDO O RESULTADO DO MODELO GRAFICAMENTE
# -------------------------------------------------
# Visualização do grafico
# Coloquei isto aqui apenas para fins didaticos
# a importacao das bibliotecas deveriam estar no topo do arquivo
#
# ScikitLearn depende de outras bibliotecas para gerar a visualizacao da arvore
# com a graphviz: faca o download do executavel dela e instale em sua maquina
from sklearn.tree import export_graphviz
from sklearn.externals.six import StringIO  
from IPython.display import Image  
import pydotplus

# Prepara o ambiente para exportar os dados para um arquivo PNG
dot_data = StringIO()
# A funcao export_graphviz gera os dados da arvore no formato DOT para depois ser gerado o arquivi PNG
# informamos para ela o classificador da arvore: classificacao
export_graphviz( classificacao, # classificador da arvore
                 out_file=dot_data,  # um ponteiro para o sistema de arquivos do sistema operacional
                 filled=True, rounded=True, # caracteristicas do desenho da arvore
                 special_characters=True,
                 feature_names = caracteristicas_cols, # descricao das variaveis independentes
                 class_names=['normal','lento','congest']) # descricao dos possiveis valores das variaves dependentes
# constroi o grafico da arvores
graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
# cria o PNG no disco
graph.write_png('ArvoreTransitoDC.png')
# gera o conteudo do png
Image(graph.create_png())

export_graphviz( classificacao,  out_file=dot_data,   filled=True, rounded=True,  special_characters=True, feature_names = caracteristicas_cols) 
