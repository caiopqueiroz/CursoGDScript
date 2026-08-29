extends CharacterBody2D

# objetivo: fazer o player se movimentar para todas as 4 direções
# objetivo: conseguir exibir 'teste' quando o player colidir com o inimigo  
# objetivo: fazer a espada aparecer para o player quando o jogador pressionar a tecla P

# Criando uma variável para a velocidade do jogador 
@export var velocidade = 100

# Pré-carregando a cena da espada para o script do player 
var cena_espada = preload('res://cenas/espada.tscn')

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
	
	# Se a colisão não for nula - ou seja, quando o player tocar em algo:
	if colisao != null:
		# Definindo que, enquanto o player estiver tocando o inimigo, se ele apertar a tecla de ataque, o inimigo será morto 
		# if Input.is_action_pressed('Ataque'):
		#    print('Inimigo morto!')
		pass
		
	if Input.is_action_pressed('Ataque'):
		pass
