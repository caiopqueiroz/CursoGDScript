extends CharacterBody2D

# Criando uma variável para identificar se a bola já foi atirada 
var inicio = false

# Criando uma variável de velocidade para a bola
var velocidade_inicial = -500

# Criando uma velocidade incremental - será usada para aumentar a velocidade da bola sempre que colidir com uma parede
@export var velocidade_incremental = 1.5

# Criando uma variável array para o ângulo da bola - será usada para aplicar uma velocidade horizontal à bola, evitando que ela mantenha um movimento sempre previsível
var angulo = [250, -250]

# Função executada a cada frame para verificar eventos físicos no jogo
func _physics_process(delta):
	# Verificando se a barra de espaço foi pressionada
	if Input.is_action_pressed('Start') and inicio == false:
		# Disparando a função para iniciar o jogo
		inicio_jogo()
	
	if inicio:	
		# Movendo a bola 
		# A variável colisao vai receber informações quando a bola colidir com algum objeto graças à função move_and_collide()
		var colisao = move_and_collide(velocity * delta)
		if colisao != null:
			# A velocidade da bola vai adquirir novos valores, ou seja, um novo direcionamento pela função bounce(), que recebe dados através de colisao.get_normal() e recalcula a rota da bola, fazendo com que ela ricocheteie
			# Além disso, a cada colisão, sua velocidade aumentará pela multiplicação com a variável velocidade_incremental
			velocity = velocity.bounce(colisao.get_normal()) * velocidade_incremental
			print(velocity)

# Criando uma função para arremessar a bola 
func inicio_jogo():
	# Liberando o movimento do player 
	inicio = true
	
	# Dando velocidade à bola
	velocity.y = velocidade_inicial
	
	# Dando velocidade horizontal à bola usando a função pick_random(), que vai escolher aleatoriamente entre o valor positivo e o negativo da lista 'angulo', tornando o movimento da bola imprevisível
	velocity.x = angulo.pick_random()
	
