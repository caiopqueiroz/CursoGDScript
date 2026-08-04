# extends
extends CharacterBody2D

# Variáveis
var velocidade = 200

# _ready()
# Essa é uma função que é executada uma única vez, quando o node se junta à cena 
func _ready():
	print('Jogador criado')
	
# _process(delta)
# A função será executada uma vez a cada frame enquanto o node estiver em cena 
func _process(delta):
	print('Essa mensagem está sendo executada a cada frame')

# Demais funções 
func atacar():
	pass
