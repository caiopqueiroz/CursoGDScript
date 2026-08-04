extends CharacterBody2D

# Exemplo completo de criação e uso das variáveis
const VIDA_MAXIMA = 100

var vida = VIDA_MAXIMA
var velocidade: float = 250.0
var nome: String = 'Herói'
var vivo: bool = true

func _ready():
	print(nome)
	print(vida)
	print(velocidade)
	print(vivo)
	
