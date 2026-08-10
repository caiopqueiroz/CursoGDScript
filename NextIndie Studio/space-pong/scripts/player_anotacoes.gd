extends CharacterBody2D # Informa que esse script pertence à classe CharacterBody2D

# É executado uma vez quando a cena inicia
func _ready():
	# Exemplo: verificar, ao início do jogo, qual a munição que tem o player
	pass 

# Executado uma vez a cada frame enquanto o jogo estiver sendo executado - exemplo: verificar continuamente a pontuação do player
func _process(delta):
	# Exemplo: verificar, a todo momento, quando o botão para atirar é pressionado pelo jogador e assim executar sua ação
	pass

# Sempre executado a cada quadro físico, usado para alterar elementos na física do jogo 
func _physics_process(delta):
	# Exemplo: fazer com que a nave inimiga seja derrubada sempre que atingida (alteração física)
	pass
