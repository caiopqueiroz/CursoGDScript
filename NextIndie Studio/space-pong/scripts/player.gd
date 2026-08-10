extends CharacterBody2D

# Criando uma variável para a velocidade o jogador
# O método @export faz com que a variáavel possa ser editada pelo inspetor, e não somente através do script
@export var velocidade = 100

var bola

# Função básica que é executada uma única vez, no momento em que o script entra na cena
func _ready():
	# Dando à variável bola acesso às variáveis presentes no script do nó irmão: 'Bola', para isso, usando a função get_parent() que está se referindo ao pai comum de Player e Bola, e get_node('Bola') que faz referência justamente ao nó que contém a variável que precisamos
	bola = get_parent().get_node('Bola')

# Função básica, executada a cada frame, que promove alterações em objetos físicos no jogo
func _physics_process(delta):
	
	# Resetando o valor de velocity.x a cada frame para que seu valor não se acumule e assim o player mantenha sempre a mesma velocidade = 100
	velocity.x = 0 
	
	# Verificando se o player já lançou a bola
	if bola.inicio == true:
		
		# Verificando se a tecla seta para esquerda foi pressionada no teclado usando Input.is_action_pressed()
		if Input.is_action_pressed('ui_left'):
			# Reduzindo o valor da velocidade (100) de velocity.x
			velocity.x -= velocidade
		
		# Verificando a tecla seta para a direita
		if Input.is_action_pressed('ui_right'):
			# Acrescentando a velocidade do player à velocity.x
			velocity.x += velocidade
	
	# Movendo de fato o jogador, considerando as colisões, usando a função move_and_collide()
	# delta se refere a quantidade de tempo passada desde o último quadro, isso garante que a velocidade das ações seja executada de forma constante, independentemente do aparelho em que o jogo for executado	
	move_and_collide(velocity * delta)
