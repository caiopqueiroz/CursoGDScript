import pandas as pd 

df = pd.read_csv(
    'NextIndie Studio/comandos_godot.csv',
    sep = ';'
)

# Criando um exemplo de busca pela função de um comando específico
# print(df.iloc[
#     1,
#     1
# ])

# Usando a função str.contains('var') para buscar pela palavra var contida na coluna sintaxe 
# print(df[
#     df['sintaxe'].str.contains('var')
# ])

# sintaxe
# função
# exemplo de uso
print(df[
    df['sintaxe'].str.contains('pressed', case = False)
])

