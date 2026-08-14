extends Node2D

# Usando o método $ para referenciar nós filhos - nesse caso, atribuindo às variáveis bola e texto_pongs os nós Bola e Pongs, respectivamente
# O método @onready garante que ambas as variáveis só sejam de fato declaradas uma vez que possam, ou seja, quando o jogo iniciar e os nós já tiverem sido iniciados, evitando assim erros no funcionamento do jogo
@onready var bola = $Bola
@onready var texto_pongs = $Pongs
@onready var texto_tutorial = $Tutorial
@onready var posicoes = $Posicoes

# Criando uma variável que irá armazenar a última posição que gerou um asteroide, para assim controlar o gerador de modo que nunca se formem dois asteroides em sequência na mesma posição
var ultima_posicao 

# Definindo uma variável como um pré-carregamento da cena asteroide, assim a cena pode ser carregada de forma dinâmica à cena principal game
var cena_asteroide = preload("res://cenas/asteroide.tscn")

func _process(delta):
	# Referenciando o texto do nó Pongs usando texto_pongs.text e fazendo com que ele receba continuamente, a cada frame, o valor da variável pongs, que existe no nó Bola, referenciado pela variável bola que criamos
	# Isso só será feito uma vez que o jogo já estiver sido iniciado, ou seja, o jogador já tiver pressionado a barra de espaço
	if bola.inicio == true:
		texto_pongs.text = str(bola.pongs)
	
	# Verificando se a tecla espaço foi apertada para remover o texto do tutorial
	if Input.is_action_pressed('Start'):
		texto_tutorial.visible = false

# Criando uma função a partir do sinal emitido pelo nó Buraco, esse nó 'avisará' quando um corpo entrar no seu espaço, assim é possível resetar o jogo porque o player deixou a bola escapar 
func _on_buraco_body_entered(body: Node2D) -> void:
	print('Fim de jogo!')
	# Usando a função call_deferred() para adiar a execução da função criada resetar_cena(), assim ela só será executada uma vez que todas as interações físicas se encerrem, evitando erros no jogo
	call_deferred('resetar_cena')

# Criando uma função para resetar todos os nós da cena
func resetar_cena():
	# Pegando toda a árvore de nós da cena com a função get_tree() e resetando todos os nós presentes nela com reload_current_scene()
	get_tree().reload_current_scene()

# Criando uma função a partir do sinal emitido pelo nó Timer: Timer_gerador - sua função será spawnar novos asteroides a cada vez que o timer zerar, a cada 3 segundos
func _on_timer_gerador_timeout() -> void:
	gerar_asteroide()

# Criando uma função para spawnar asteroides
func gerar_asteroide():
	# Só permitir a geração dos asteroides uma vez que o jogo já tenha sido iniciado 
	if bola.inicio == true:
		# Criando uma variável lista_posicoes que está recebendo, pela função get_children() os nós filhos do nó referenciado como posicoes, cada nó filho representa uma possível posição diferente onde pode ser spawnado um asteroide
		var lista_posicoes = posicoes.get_children()
		# Usando a função pick_random() para escolher aleatoriamente uma das posições e guardá-la em uma variável
		var posicao_spawn = lista_posicoes.pick_random()
		# Verificando se a nova posição de spawn é a mesma posição anterior para evitar que 2 asteroides consecutivos sejam gerados no mesmo local 
		if posicao_spawn != ultima_posicao:
			# Instanciando a cena pré-carregada anteriormente no código e atribuindo a uma nova variável pela função instantiate(), somente assim ela pode ser utilizada
			var instancia_asteroide = cena_asteroide.instantiate()
			# Utilizando agora o método global_position para atribuir à cena instanciada a posição guardada na variável posicao_spawn, com o uso de .position
			instancia_asteroide.global_position = posicao_spawn.position
			# Depois de concluídas todas essas etapas, utilizando finalmente a função add_child() para inserir a cena do asteroide na cena principal do jogo, ou seja, fazer com que apareça em tela
			add_child(instancia_asteroide)
			# Atribuindo a posicao_spawn (atual) para a variável ultima_posicao, assim ela nunca poderá ser escolhida como a próxima
			ultima_posicao = posicao_spawn
		# Se a nova posição escolhida aleatoriamente for igual à última, a função será executada novamente até que uma outra seja escolhida
		else:
			gerar_asteroide()
		
		print('Asteroide gerado')
				
