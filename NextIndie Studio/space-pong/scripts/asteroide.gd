extends Area2D


# Criando a velocidade do asteroide 
@export var velocidade = 140

# Criando uma velocidade de rotação
@export var velocidade_rotacao = 1.3

# Criando uma variável para controlar o nó Timer_excluir que irá deletar o asteroide quando deixar a tela
@onready var timer_excluir = $Timer_excluir

# Criando uma variável para encontrar o lado em que o asteroide foi gerado
var lado_inicial

func _ready():
	# Com o método global_position.x, estamos verificando se o asteroide será gerado à esquerda ou à direita da tela (que tem largura de 540 pixels)
	if global_position.x > 540: 
		lado_inicial = 'direita'
	else:
		lado_inicial = 'esquerda'
	
# Usando a função process(delta) para movimentar o asteroide uma vez que já conseguimos identifcar em qual lado da tela ele foi gerado	
func _process(delta):
	if lado_inicial == 'direita':
		# Assim, a cada quadro, será decrementado da posição do asteroide o valor de sua velocidade, por isso usamos velocidade * delta, dessa forma ele irá em direção à esquerda
		global_position.x -= velocidade * delta
		# Ajustando também a rotação do asteroide, fazendo ele girar 
		rotation -= velocidade_rotacao * delta
	elif lado_inicial == 'esquerda':
		global_position.x += velocidade * delta
		rotation += velocidade_rotacao * delta
		
# Criando, através de um sinal, uma função que será executada imediatamente após o asteroide deixar a visualização, ou seja, sair da tela - o objetivo é excluir para que não fique ocupando processamento	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Usando a função start() para iniciar o timer que contará o tempo necessário para o asteroide deixar completamente a tela após o sinal ser disparado
	timer_excluir.start()

# Criando, através de um sinal, a função que irá disparar imediatamente após o fim do timer, ela irá excluir o asteroide
func _on_timer_excluir_timeout() -> void:
	# Usando a função queue_free() para deletar o nó da cena
	queue_free()

# Criando uma função, através de um sinal, que irá disparar quando um objeto colidir com o asteroide, nesse caso, o parâmetro body na função vai receber esse objeto, que será a bola
func _on_body_entered(body):
	# Acessando a variável pongs da bola através de body
	body.pongs += 1
	# Deletando o asteroide quando ele entrar em contato com a bola usando a função queue_free()
	queue_free()
