extends Node2D

# Usando o método $ para referenciar nós filhos - nesse caso, atribuindo às variáveis bola e texto_pongs os nós Bola e Pongs, respectivamente
# O método @onready garante que ambas as variáveis só sejam de fato declaradas uma vez que possam, ou seja, quando o jogo iniciar e os nós já tiverem sido iniciados, evitando assim erros no funcionamento do jogo
@onready var bola = $Bola
@onready var texto_pongs = $Pongs
@onready var texto_tutorial = $Tutorial

func _process(delta):
	# Referenciando o texto do nó Pongs usando texto_pongs.text e fazendo com que ele receba continuamente, a cada frame, o valor da variável pongs, que existe no nó Bola, referenciado pela variável bola que criamos
	# Isso só será feito uma vez que o jogo já estiver sido iniciado, ou seja, o jogador já tiver pressionado a barra de espaço
	if bola.inicio == true:
		texto_pongs.text = str(bola.pongs)
	
	# Verificando se a tecla espaço foi apertada para remover o texto do tutorial
	if Input.is_action_pressed('Start'):
		texto_tutorial.text = ''
