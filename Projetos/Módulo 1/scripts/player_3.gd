extends CharacterBody2D

const VIDA_MAXIMA = 100

var vida = VIDA_MAXIMA
var moedas = 0
var velocidade: float = 200.0
var nome: String = 'Jogador'
var vivo: bool = true

func _ready():
	print(vida, moedas, velocidade, nome, vivo)

# Exercícios:
var pontuacao: int = 500
const TEMPO_MAXIMO = 60
var nome_jogador: String = 'O Herói'
var nivel: int = 1
var energia: float = 10.0
var status_vivo = true 
