extends Node2D

# Usando o método $ para referenciar nós filhos - nesse caso, atribuindo às variáveis bola e texto_pongs os nós Bola e Pongs, respectivamente
# O método @onready garante que todas as variáveis só sejam de fato declaradas uma vez que possam, ou seja, quando o jogo iniciar e os nós já tiverem sido iniciados, evitando assim erros no funcionamento do jogo
@onready var bola = $Bola
@onready var texto_pongs = $Pongs
@onready var texto_tutorial = $Tutorial
@onready var posicoes = $Posicoes
@onready var background = $Background

# Criando uma variável que irá armazenar a última posição que gerou um asteroide, para assim controlar o gerador de modo que nunca se formem dois asteroides em sequência na mesma posição
var ultima_posicao 

# Definindo uma variável como um pré-carregamento da cena asteroide, assim a cena pode ser carregada de forma dinâmica à cena principal game
var cena_asteroide = preload("res://cenas/asteroide.tscn")

# Declarando dicionários para armazenar sprites e recursos de cores que sofreram alterações com o decorrer do jogo - background, pongs e asteroides
var recursos_asteroide = {}
var recursos_background = {}
var recursos_cores_texto = {}

# Definindo uma variável que irá guardar a nova cor do asteroide sempre que ela for trocada 
var nova_cor_asteroide 

func _ready():
	# Chamando a função criada para pré-carregar os recursos/sprites que precisamos para trocar as cores do jogo dinamicamente
	precarregar_recursos()

func _process(delta):
	# Referenciando o texto do nó Pongs usando texto_pongs.text e fazendo com que ele receba continuamente, a cada frame, o valor da variável pongs, que existe no nó Bola, referenciado pela variável bola que criamos
	# Isso só será feito uma vez que o jogo já estiver sido iniciado, ou seja, o jogador já tiver pressionado a barra de espaço
	if bola.inicio == true:
		texto_pongs.text = str(bola.pongs)
		
		# Chamando a função checar_pongs() com a variável pongs - assim ela saberá em tempo real quantos pontos o jogador tem para que seja possível alterar a cor da tela de acordo 
		checar_pongs(bola.pongs)
	
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
			# Criando uma condição para que, se a variável nova_cor_asteroide já tiver uma atribuição, os próximos asteroides a serem instanciadas tenham a cor correta
			if nova_cor_asteroide != null:
				# Para isso, usando get_node('Sprite2D').texture
				instancia_asteroide.get_node('Sprite2D').texture = nova_cor_asteroide
			# Depois de concluídas todas essas etapas, utilizando finalmente a função add_child() para inserir a cena do asteroide na cena principal do jogo, ou seja, fazer com que apareça em tela
			add_child(instancia_asteroide)
			# Atribuindo a posicao_spawn (atual) para a variável ultima_posicao, assim ela nunca poderá ser escolhida como a próxima
			ultima_posicao = posicao_spawn
		# Se a nova posição escolhida aleatoriamente for igual à última, a função será executada novamente até que uma outra seja escolhida
		else:
			gerar_asteroide()
	
# Criando uma função para pré-carregar os recursos/sprites que precisamos para trocar as cores do jogo dinamicamente	
func precarregar_recursos():
	recursos_asteroide = {
		'asteroide1': preload("res://sprites/Asteroide1.png"),
		'asteroide2': preload("res://sprites/Asteroide2.png"),
		'asteroide3': preload("res://sprites/Asteroide3.png"),
		'asteroide4': preload("res://sprites/Asteroide4.png"),
		'asteroide5': preload("res://sprites/Asteroide5.png"),
		'asteroide6': preload("res://sprites/Asteroide6.png")
	}
	
	recursos_background = {
		'background1': preload('res://sprites/Fundo1.png'),
		'background2': preload('res://sprites/Fundo2.png'),
		'background3': preload('res://sprites/Fundo3.png'),
		'background4': preload('res://sprites/Fundo4.png'),
		'background5': preload('res://sprites/Fundo5.png'),
		'background6': preload('res://sprites/Fundo6.png')
	}
	
	# No dicionário das cores, armazenando valores hexadecimais de cores diretamente
	recursos_cores_texto = {
		'cor1': '7101eb',
		"cor2": "4196ff",
		"cor3": "4ea771",
		"cor4": "fe9c35",
		"cor5": "ff5d5d",
		"cor6": "762d79"
	}

# Criando uma função para checar quantos pongs o jogador fez para disparar a mudança de cor da tela - essa função deverá receber como parâmetro a variável pongs  
func checar_pongs(pongs):
	# A instrução match é como switch, nesse caso, recebe a variável pongs e irá executar um comando de acordo com o valor dela 
	match pongs:
		# Sempre que o jogador alcançar algum desses valores de pongs, a função criada atualizar_cores() será chamada recebendo como parâmetro a cor correspondente - que são chaves do dicionário criado
		0:
			atualizar_cores(
				'cor1', 'background1'
			)
		10:
			atualizar_cores(
				'cor2', 'background2'
			)
			atualizar_asteroides('asteroide2')
		20:
			atualizar_cores(
				'cor3', 'background3'
			)
			atualizar_asteroides('asteroide3')
		30:
			atualizar_cores(
				'cor4', 'background4'
			)
			atualizar_asteroides('asteroide4')
		40:
			atualizar_cores(
				'cor5', 'background5'
			)
			atualizar_asteroides('asteroide5')
		50:
			atualizar_cores(
				'cor6', 'background6'
			)
			atualizar_asteroides('asteroide6')
	
# Criando uma função para alterar as cores do jogo seguindo o comando da outra função criada checar_pongs() - ela vai receber como parâmetros as chaves dos dicionários criados com os arquivos necessários
func atualizar_cores(
	chave_cor_texto,
	chave_cor_background
):
	# Alterando a cor do texto usando a referência texto_pongs criada para acessar esse nó anteriormente - em seguida, utilizando o caminho das suas configurações para alterar a propriedade desejada: a cor
	texto_pongs.label_settings.font_color = recursos_cores_texto[chave_cor_texto]
	# Fazendo o mesmo para o cor do background com a função set_texture(), que permite trocar a imagem usada como fundo
	background.set_texture(recursos_background[chave_cor_background])
	
# Criando uma função em particular para atualizar a cor dos asteroides, isso porque eles não são objetos instanciados diretamente na cena, então o processo para que troquem de sprite precisa ser diferente
func atualizar_asteroides(chave_cor_asteroide):
	# Definindo uma variável que irá receber o grupo que contém todos os nós da cena asteroide através das funções get_tree().get_nodes_in_group() - assim, sempre que um novo asteroide for instanciado à cena, é possível ter acesso a ele para trocar sua cor 
	var asteroides = get_tree().get_nodes_in_group('asteroides')
	
	# Criando um laço de repetição for que irá percorrer todo o grupo de asteroides 
	for asteroide in asteroides:
		# Usando a função get_node('Sprite2D').texture para refenciar a propriedade texture do nó que possui o sprite - assim, fazendo com que receba o elemento do dicionário correspondente para cada caso usando a chave do dicionário
		asteroide.get_node('Sprite2D').texture = recursos_asteroide[chave_cor_asteroide]
	
	# Usando a variável nova_cor_asteroide para guardar a informação da cor atual que devem ser os novos asteroides gerados, assim é possível usar essa variável diretamente na geração deles
	nova_cor_asteroide = recursos_asteroide[chave_cor_asteroide]
