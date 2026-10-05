extends CharacterBody2D

# Variáveis 
@export var velocidade = 100
var direcao = 'esquerda'
var posicao
var instancia_espada = null
var cena_espada = preload('res://cenas/espada.tscn')
var invencivel = false
var permitir_acoes = true

# Referências a nós
@onready var posicoes_espada = $Posicoes_espada

func _physics_process(delta):
	if permitir_acoes:
		mover_player(delta)
		
		if Input.is_action_just_pressed('Ataque'):
			sacar_espada()

		if Input.is_action_just_released('Ataque'):
			guardar_espada()
		
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
	if direcao == 'baixo':
		posicao = lista_posicoes[3]
	
		instancia_espada.rotation = -89.5
	# Aplicando a posição à espada de acordo com a direção do player
	instancia_espada.global_position = posicao.position

	# Por fim, usando a função add_child() para fazer com que a espada de fato apareça na tela 
	add_child(instancia_espada)

# Criando uma função para guardar a espada do jogador	
func guardar_espada():
	# Se a cena da espada estiver instanciada na variável instancia_espada - ou seja, se ela não for nula
	if instancia_espada != null:
		# Utilizando queue_free() para removê-la e tornando nula novamente - desse modo, ela só permanecerá ativa enquanto o jogador pressionar a tecla, caso constrário, será deletada imediatamente
		instancia_espada.queue_free()
		instancia_espada = null
 
func mover_player(delta):
	# É necessário sempre resetar o valor de velocity.x a cada frame para que ela não se acumule e o jogador se mova rápido demais 
	velocity.x = 0
	velocity.y = 0
	
	# Movendo o player para todas as 4 direções 
	if Input.is_action_pressed('ui_left'):
		velocity.x -= velocidade
		
		direcao = 'esquerda'
	if Input.is_action_pressed('ui_right'):
		velocity.x += velocidade
		
		direcao = 'direita'
	if Input.is_action_pressed('ui_up'):
		velocity.y -= velocidade
		
		direcao = 'cima'
	if Input.is_action_pressed('ui_down'):
		velocity.y += velocidade
		
		direcao = 'baixo'
		
	# Usando a função move_and_collide() - que é responsável por de fato mover o jogador
	move_and_collide(velocity * delta)
	pass
	
