extends CharacterBody2D

# Criando uma variável para identificar se a bola já foi atirada 
var inicio = false

# Criando uma variável de velocidade para a bola
var velocidade_inicial = -500

# Criando uma velocidade incremental - será usada para aumentar a velocidade da bola sempre que colidir com uma parede
@export var velocidade_incremental = 1.5

# Criando uma variável array para o ângulo da bola - será usada para aplicar uma velocidade horizontal à bola, evitando que ela mantenha um movimento sempre previsível
var angulo = [250, -250]

# Criando a variável pongs - que vai contar quantas vezes a bola atinge o topo da tela 
var pongs = 0

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
			# Usando a função get_collider().name para verificar se a bola está colidindo com a parede superior
			if colisao.get_collider().name == 'Parede_superior': 
				# A velocidade da bola vai adquirir novos valores, ou seja, um novo direcionamento pela função bounce(), que recebe dados através de colisao.get_normal() e recalcula a rota da bola, fazendo com que ela ricocheteie
				# Além disso, a cada colisão, sua velocidade aumentará pela multiplicação com a variável velocidade_incremental
				# Verificando o valor completo da velocidade, velocity.length() alcançou 1500, caso tenha alcançado, ela não irá mais aumentar
				if velocity.length() < 1500:
					velocity = velocity.bounce(colisao.get_normal()) * velocidade_incremental
				else:
					velocity = velocity.bounce(colisao.get_normal())
				
				pongs += 1 
			# Se a bola colidir com qualquer outra parede, sua velocidade não irá aumentar
			else:
				velocity = velocity.bounce(colisao.get_normal())

# Criando uma função para arremessar a bola 
func inicio_jogo():
	# Liberando o movimento do player 
	inicio = true
	
	# Dando velocidade à bola
	velocity.y = velocidade_inicial
	
	# Dando velocidade horizontal à bola usando a função pick_random(), que vai escolher aleatoriamente entre o valor positivo e o negativo da lista 'angulo', tornando o movimento da bola imprevisível
	velocity.x = angulo.pick_random()
	
