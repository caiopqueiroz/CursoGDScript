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
@onready var posicoes_vida = $Posicoes_vidas
#@onready var espada = get_node('Player').get_node('Espada')
@onready var texto_pontos = $Texto_pontos
@onready var timer_aumento = $Timer_aumento
@onready var timer_diminuicao = $Timer_diminuicao
@onready var texto_game_over = $Texto_game_over
@onready var player = $Player
@onready var timer_invencivel_player = $Timer_invencivel_player
@onready var posicao_arara = $Posicoes_inimigos/Posicao_arara
@onready var texto_aviso_arara = $Texto_aviso_arara
@onready var timer_aviso_arara = $Timer_aviso_arara

func _ready():
	vida1 = gerar_vida(0)
	vida2 = gerar_vida(1)
	vida3 = gerar_vida(2)
	
	texto_game_over.visible = false

func _process(delta):
	
	pulsar_pontos()
	
	verificar_game_over()
	
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
		
		if total_inimigos < 5:
			
			for inimigo in range(0, numero):
				
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

func gerar_vida(posicao):
	# Definindo uma variável para guardar todas as posições das vidas 
	var lista_posicoes_vida = posicoes_vida.get_children()
	
	# Definindo a posição da lista de acordo com o parâmetro inserido ao chamar a função
	var posicao_vida = lista_posicoes_vida[posicao]

	# Criando a instância da vida
	var instancia_vida = cena_vida.instantiate() 

	# Aplicando a posição
	instancia_vida.global_position = posicao_vida.position

	# Adicionando a vida à tela
	add_child(instancia_vida)
	
	return instancia_vida

func somar_ponto():
	pontos += 1
	
	texto_pontos.text = str(pontos)
	
	timer_aumento.start()

# Timer para disparar o timer que faz os pontos voltarem ao tamanho normal		
func _on_timer_aumento_timeout() -> void:
	
	timer_diminuicao.start()

func pulsar_pontos():
	if not timer_aumento.is_stopped():
		
		if texto_pontos.label_settings.font_size < 600:
			texto_pontos.label_settings.font_size += 8
	if not timer_diminuicao.is_stopped():
		
		if texto_pontos.label_settings.font_size > 300:
			texto_pontos.label_settings.font_size -= 8
	
func resetar_cena():
	get_tree().reload_current_scene()

func verificar_game_over():
	if vida1.total_vidas == 0:
		player.permitir_acoes = false
		permitir_gerar_inimigos = false
		
		texto_game_over.visible = true
		
		if Input.is_action_pressed('Ataque'):
			resetar_cena()

func _on_timer_invencivel_player_timeout() -> void:
	 
	player.invencivel = false

func _on_timer_gerador_arara_timeout() -> void:
	
	var numeros = range(0, 10)
	
	var numero = numeros.pick_random()
	
	if numero == 0:
		
		instancia_arara = gerar_arara()

		texto_aviso_arara.text = '↓ ↓ ↓'
		
		timer_aviso_arara.start()
	
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
