
import pandas as pd
from sklearn.tree import DecisionTreeClassifier # Importa o Decision Tree Classifier
from sklearn.model_selection import train_test_split # Importa a funcao train_test_split
from sklearn import metrics #Importa da scikit-learn metrics o  modulo para calculo da acuracia

def print_decision_tree(tree, feature_names, offset_unit='    '):    
    left      = tree.tree_.children_left
    right     = tree.tree_.children_right
    threshold = tree.tree_.threshold
    value = tree.tree_.value
    if feature_names is None:
        features  = ['f%d'%i for i in tree.tree_.feature]
    else:
        features  = [feature_names[i] for i in tree.tree_.feature]        

    def recurse(left, right, threshold, features, node, depth=0):
            offset = offset_unit*depth
            if (threshold[node] != -2):
                    print(offset+"if ( " + features[node] + " <= " + str(threshold[node]) + " ) {")
                    if left[node] != -1:
                            recurse (left, right, threshold, features,left[node],depth+1)
                    print(offset+"} else {")
                    if right[node] != -1:
                            recurse (left, right, threshold, features,right[node],depth+1)
                    print(offset+"}")
            else:
                    #print(offset,value[node]) 

                    #To remove values from node
                    temp=str(value[node])
                    mid=len(temp)//2
                    tempx=[]
                    tempy=[]
                    cnt=0
                    for i in temp:
                        if cnt<=mid:
                            tempx.append(i)
                            cnt+=1
                        else:
                            tempy.append(i)
                            cnt+=1
                    val_yes=[]
                    val_no=[]
                    res=[]
                    for j in tempx:
                        if j=="[" or j=="]" or j=="." or j==" ":
                            res.append(j)
                        else:
                            val_no.append(j)
                    for j in tempy:
                        if j=="[" or j=="]" or j=="." or j==" ":
                            res.append(j)
                        else:
                            val_yes.append(j)
                    val_yes = int("".join(map(str, val_yes)))
                    val_no = int("".join(map(str, val_no)))

                    if val_yes>val_no:
                        print(offset,'\033[1m',"YES")
                        print('\033[0m')
                    elif val_no>val_yes:
                        print(offset,'\033[1m',"NO")
                        print('\033[0m')
                    else:
                        print(offset,'\033[1m',"Tie")
                        print('\033[0m')

    recurse(left, right, threshold, features, 0,0)

transito = pd.read_csv("/Users/camilaoliveira/Downloads/Brotas_py3.csv",sep=";")

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
y = transito.mm_chuva # Variavel alvo - Especificacao da variavel dependente
X_treino, X_teste, y_treino, y_teste = train_test_split(X, y, test_size=0.2, random_state=1) # 80% para treinamento e 20% para teste
classificacao = DecisionTreeClassifier()
classificacao = classificacao.fit(X_treino,y_treino)
y_pred = classificacao.predict(X_teste)
print("Acuracia do modelo:",metrics.accuracy_score(y_teste, y_pred)*100,"%")


from sklearn.tree import export_graphviz
from sklearn.externals.six import StringIO  
from IPython.display import Image  
import pydotplus
#import graphviz


dot_data = StringIO()
tree = export_graphviz( classificacao, out_file=dot_data, label='all', filled=True, rounded=True, special_characters=True, feature_names = caracteristicas_cols) 
graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
graph.write_png('ArvoreTransitoDC6.png')
Image(graph.create_png())

print(print_decision_tree(classificacao,caracteristicas_cols))