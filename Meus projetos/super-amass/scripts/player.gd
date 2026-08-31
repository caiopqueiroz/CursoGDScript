extends CharacterBody2D

# Criando uma variável para a velocidade do jogador 
@export var velocidade = 100

# Criando referências a nós
@onready var posicao_espada = $Posicao_espada

# Pré-carregando a cena da espada para o script do player 
var cena_espada = preload('res://cenas/espada.tscn')
# Iniciando uma variável que irá receber a cena no momento adequado
var instancia_espada = null

# Essa função é executada a cada frame - é usada para alterações físicas dentro da cena, como o movimento de um personagem, por exemplo
func _physics_process(delta):
	# É necessário sempre resetar o valor de velocity.x a cada frame para que ela não se acumule e o jogador se mova rápido demais 
	velocity.x = 0
	velocity.y = 0
	
	# Movendo o player para todas as 4 direções 
	if Input.is_action_pressed('ui_left'):
		velocity.x -= velocidade 
	if Input.is_action_pressed('ui_right'):
		velocity.x += velocidade
	if Input.is_action_pressed('ui_up'):
		velocity.y -= velocidade
	if Input.is_action_pressed('ui_down'):
		velocity.y += velocidade
		
	# Usando a função move_and_collide() - que é responsável por de fato mover o jogador
	move_and_collide(velocity * delta)
	
	# Guardando as informações sobre as colisões do player dentro de uma variável 
	var colisao = move_and_collide(velocity * delta)
	
	# Se a tecla P (tecla Ataque) for pressionada - executar a função criada sacar_espada()
	if Input.is_action_just_pressed('Ataque'):
		sacar_espada()
	# Se a tecla for solta - executar a função criada guardar_espada()
	if Input.is_action_just_released('Ataque'):
		guardar_espada()
		
# Criando uma função para fazer o jogador empunhar sua espada pronto para atacar
func sacar_espada():
	# Usando a nó referenciado Posicao_espada para definí-la
	var posicao = posicao_espada
	
	# Instanciando a cena pré-carregada da espada e atribuindo a variável instancia_espada
	instancia_espada = cena_espada.instantiate()
	
	# Aplicando a posição à espada
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

	
