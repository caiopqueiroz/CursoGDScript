extends CharacterBody2D

# Definindo a velocidade do inimigo
@export var velocidade = 50

# Referenciando o nó do jogador 
@onready var player = $"../Player"
# Referenciando o próprio nó do inimigo dentro dele
@onready var inimigo = $"."

func _ready():
	# print(inimigo.global_position)
	
	pass

func _physics_process(delta):
	# Resetando a velocidade a cada frame para que não se acumule 
	velocity.x = 0
	velocity.y = 0
	
	# Fazendo com que o inimigo siga o player utilizando o parâmetro global_position para avaliar a posição de cada um durante cada frame
	if (inimigo.global_position.x < player.global_position.x):
		velocity.x += velocidade
	if (inimigo.global_position.x > player.global_position.x):
		velocity.x -= velocidade
	if (inimigo.global_position.y < player.global_position.y):
		velocity.y += velocidade
	if (inimigo.global_position.y > player.global_position.y):
		velocity.y -= velocidade 
	
	move_and_collide(velocity * delta)
