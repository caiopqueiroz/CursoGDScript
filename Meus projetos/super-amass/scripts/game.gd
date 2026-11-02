extends Node2D

# Variáveis
var cena_inimigo = preload("res://cenas/inimigo.tscn")
var cena_vida = preload("res://cenas/vida.tscn")
var total_inimigos = 0
var vida1
var vida2
var vida3
var pontos = 0 
var permitir_gerar_inimigos = true
var cena_arara = preload("res://cenas/arara.tscn")
var cena_pedra = preload("res://cenas/pedra.tscn")
var instancia_arara
var pedra_caiu = false
var posicao_antiga 
var posicao 

# Referenciando nós
@onready var posicoes_inimigos = $Posicoes_inimigos
#@onready var espada = get_node('Player').get_node('Espada')
@onready var player = $Player
@onready var timer_invencivel_player = $Timer_invencivel_player
@onready var posicao_arara = $Posicoes_inimigos/Posicao_arara
@onready var texto_aviso_arara = $Texto_aviso_arara
@onready var timer_aviso_arara = $Timer_aviso_arara

func _ready():
	
	player.texto_game_over.visible = false

func _process(delta):
	
	if instancia_arara != null:
	
		if instancia_arara.position.x > player.position.x:
			
			if not pedra_caiu:
				
				print('Pedra')
				
				jogar_pedra()

# Timer para disparar a função de gerar inimigos
func _on_gerador_inimigo_timeout() -> void:
	
	if permitir_gerar_inimigos:
		
		var numeros = range(1, 4)
		
		var numero = numeros.pick_random()
		
		if total_inimigos < 2:
			
			#for inimigo in range(0, numero):
				
			gerar_inimigo()
		
			total_inimigos += 1
	
func gerar_inimigo():
	# Definindo a posição do inimigo
	while posicao == posicao_antiga:
		
		var lista_posicoes = posicoes_inimigos.get_children()
		
		posicao = lista_posicoes.pick_random()
	
	posicao_antiga = posicao
	
	# Instanciando a cena inimigo
	var instancia_inimigo = cena_inimigo.instantiate()
	
	# Definindo a posição da instância 
	instancia_inimigo.global_position = posicao.position
	
	# Adicionando a cena inimigo à cena principal
	add_child(instancia_inimigo)

func somar_ponto():
	pontos += 1
	
	player.texto_pontos.text = str(pontos)
	
func resetar_cena():
	
	get_tree().reload_current_scene()

func _on_timer_gerador_arara_timeout() -> void:
	
	var numeros = range(0, 10)
	
	var numero = numeros.pick_random()
	
	if numero == 0:
		
		#instancia_arara = gerar_arara()

		#texto_aviso_arara.text = '↓ ↓ ↓'
		
		#timer_aviso_arara.start()
		
		pass
	
func gerar_arara():
	
	pedra_caiu = false
	
	var posicao = posicao_arara.position
	
	var instancia_arara = cena_arara.instantiate()
	
	instancia_arara.global_position = posicao
	
	add_child(instancia_arara)
	
	return instancia_arara

func jogar_pedra():
	
	var posicao = instancia_arara.position
	
	posicao[1] += 40
	
	var instancia_pedra = cena_pedra.instantiate()
	
	instancia_pedra.global_position = posicao
	
	add_child(instancia_pedra)
	
	pedra_caiu = true
	
func _on_timer_aviso_arara_timeout() -> void:
	
	texto_aviso_arara.text = ''
