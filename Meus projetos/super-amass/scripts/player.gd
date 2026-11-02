extends CharacterBody2D

# Variáveis 
@export var velocidade = 100
var direcao = 'baixo'
var posicao
var instancia_espada = null
var cena_espada = preload('res://cenas/espada.tscn')
var invencivel = false
var permitir_acoes = true
var panda_direita = load("res://sprites/novos_sprites/panda/Panda direita.png")
var panda_esquerda = load("res://sprites/novos_sprites/panda/Panda esquerda.png")
var panda_costas = load("res://sprites/Sprites 8 bits/png/Panda costas.png")
var panda_frente = load("res://sprites/Sprites 8 bits/png/Panda.png")
var panda_ataque_esquerda = load("res://sprites/novos_sprites/panda/Panda ataque esquerda.png")
var panda_ataque_direita = load("res://sprites/novos_sprites/panda/Panda ataque direita.png")
var panda_ataque_frente = load("res://sprites/novos_sprites/panda/Panda ataque frente.png")
var panda_ataque_costas = load("res://sprites/novos_sprites/panda/Panda ataque costas.png")
var posicao_ataque = false
const VELOCIDADE = 50
const ATRITO = 0.25
var espada 
var total_vidas = 3
var contador = 0

# Referências a nós
@onready var posicoes_espada = $Posicoes_espada
@onready var timer_excluir = $Timer_excluir
@onready var vidas = [$Vida1, $Vida2, $Vida3]
@onready var timer_invencivel = $Timer_invencivel
@onready var game = get_parent()
@onready var texto_pontos = $Texto_pontos
@onready var texto_game_over = $Texto_game_over

func _ready():
	
	pass

func _physics_process(delta):
	
	if permitir_acoes:
		
		mover(delta)
		
		ataque()
		
	morte()
		
# Criando uma função para fazer o jogador empunhar sua espada pronto para atacar
func sacar_espada():
	# Usando a nó referenciado Posicao_espada para definí-la
	var lista_posicoes = posicoes_espada.get_children()
	
	# Instanciando a cena pré-carregada da espada e atribuindo a variável instancia_espada
	instancia_espada = cena_espada.instantiate()
	
	# Definindo a posição da espada de acordo com a variável direção
	if direcao == 'direita':
		posicao = lista_posicoes[1]
	if direcao == 'esquerda':
		posicao = lista_posicoes[0]
	if direcao == 'cima':
		posicao = lista_posicoes[2]
		
		# Ajustando a rotação da espada
		instancia_espada.rotation = 89.5
		
		instancia_espada.z_index = -1
	if direcao == 'baixo':
		posicao = lista_posicoes[3]
	
		instancia_espada.rotation = -89.5
	
	# Aplicando a posição à espada de acordo com a direção do player
	instancia_espada.global_position = posicao.position
	
	# Por fim, usando a função add_child() para fazer com que a espada de fato apareça na tela 
	add_child(instancia_espada)
	
	espada = instancia_espada

# Criando uma função para guardar a espada do jogador	
func guardar_espada():
	# Se a cena da espada estiver instanciada na variável instancia_espada - ou seja, se ela não for nula
	if instancia_espada != null:
		# Utilizando queue_free() para removê-la e tornando nula novamente - desse modo, ela só permanecerá ativa enquanto o jogador pressionar a tecla, caso constrário, será deletada imediatamente
		instancia_espada.queue_free()
		instancia_espada = null
 
func _on_timer_excluir_timeout() -> void:
	
	posicao_ataque = false
		
	guardar_espada()
	
func mover(delta):
	
	var direcao_v := Input.get_axis('ui_up', 'ui_down')
	
	var direcao_h := Input.get_axis('ui_left', 'ui_right')
	
	if direcao_v:
		
		velocity.y = direcao_v * VELOCIDADE
	else:
		
		velocity.y = move_toward(velocity.y, 0, ((VELOCIDADE / ATRITO) * delta))
		
	if direcao_h:
		
		velocity.x = direcao_h * VELOCIDADE
	else:
		
		velocity.x = move_toward(velocity.x, 0, ((VELOCIDADE / ATRITO) * delta))
		
	move_and_collide(velocity * delta)
	
	if direcao_v > 0:
		
		direcao = 'baixo'
		
		$Sprite2D.texture = panda_frente
	elif direcao_v < 0:
		
		direcao = 'cima'
		
		$Sprite2D.texture = panda_costas
	
	if direcao_h > 0:
		
		direcao = 'direita'
		
		$Sprite2D.texture = panda_frente
	elif direcao_h < 0:
		
		direcao = 'esquerda'
		
		$Sprite2D.texture = panda_frente

func ataque():
	
	if Input.is_action_just_pressed('Ataque') and posicao_ataque == false:
		
		timer_excluir.start()

		posicao_ataque = true
		
		sacar_espada()
		
func dano():
	
	if total_vidas > 0:
		
		vidas[contador].visible = false
		
		contador += 1
		
		total_vidas -= 1

func morte():
	
	if total_vidas <= 0:
	
		permitir_acoes = false 
		
		texto_game_over.visible = true
		
		if Input.is_action_pressed('Ataque'):
			
			game.resetar_cena()

func _on_colisao_fisica_body_entered(corpo):
	
	if corpo == self:
		
		return
		
	if corpo is CharacterBody2D:
		
		dano()
		
