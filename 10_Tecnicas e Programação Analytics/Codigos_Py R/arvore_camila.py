
import pandas as pd
from sklearn.tree import DecisionTreeClassifier # Importa o Decision Tree Classifier
from sklearn.model_selection import train_test_split # Importa a funcao train_test_split
from sklearn import metrics #Importa da scikit-learn metrics o  modulo para calculo da acuracia
transito = pd.read_csv("/Users/camilaoliveira/Downloads/Brotas_py2.csv",sep=";")

transito.loc[transito['bairro']=='Brotas', "bairro"] = 0 # Cabula
transito.loc[transito['bairro']=='Caminho das Árvores', "bairro"] = 1 # Brotas
transito.loc[transito['bairro']=='Cosme de Farias', "bairro"] = 2 # Brotas

transito.loc[transito['transito']=='Noite', "transito"] = 0 # Cabula
transito.loc[transito['transito']=='Horário Nobre', "transito"] = 1 # Brotas
transito.loc[transito['transito']=='Madrugada', "transito"] = 2 # Brotas
transito.loc[transito['transito']=='Tarde', "transito"] = 3 # Cabula
transito.loc[transito['transito']=='Rush_mat', "transito"] = 4 # Brotas
transito.loc[transito['transito']=='Manhã', "transito"] = 5 # Brotas
transito.loc[transito['transito']=='Almoço', "transito"] = 6 # Cabula
transito.loc[transito['transito']=='Rush_ves', "transito"] = 7 # Brotas

transito.loc[transito['estacao']=='Verão', "estacao"] = 0 # Cabula
transito.loc[transito['estacao']=='Outono', "estacao"] = 1 # Brotas
transito.loc[transito['estacao']=='Inverno', "estacao"] = 2 # Brotas
transito.loc[transito['estacao']=='Primavera', "estacao"] = 3 # Cabula


caracteristicas_cols = ['bairro','transito','mm_chuva','estacao'] # Especificacao das variaveis independentes
X = transito[caracteristicas_cols] # caracteristicas
y = transito.transito # Variavel alvo - Especificacao da variavel dependente
X_treino, X_teste, y_treino, y_teste = train_test_split(X, y, test_size=0.2, random_state=1) # 80% para treinamento e 20% para teste
classificacao = DecisionTreeClassifier()
classificacao = classificacao.fit(X_treino,y_treino)
y_pred = classificacao.predict(X_teste)
print("Acuracia do modelo:",metrics.accuracy_score(y_teste, y_pred),"%")


from sklearn.tree import export_graphviz
from sklearn.externals.six import StringIO  
from IPython.display import Image  
import pydotplus
#import graphviz


dot_data = StringIO()
export_graphviz( classificacao, out_file=dot_data,  filled=True, rounded=True, special_characters=True, feature_names = caracteristicas_cols, class_names=caracteristicas_cols) 
graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
graph.write_png('ArvoreTransitoDC5.png')
Image(graph.create_png())
