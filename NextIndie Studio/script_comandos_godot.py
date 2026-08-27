import pandas as pd 

df = pd.read_csv(
    'comandos_godot.csv',
    sep = ';'
)

print(df.head(3))

print(df.iloc[
    1,
    1
])

# Usando a função str.contains('var') para buscar pela palavra var contida na coluna sintaxe 
print(df[
    df['sintaxe'].str.contains('var')
])

print(df[
    df['exemplo de uso'].str.contains('timer', case = False)
])