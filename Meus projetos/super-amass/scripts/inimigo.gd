extends CharacterBody2D

# Variáveis
@export var velocidade = 10
var colisao
var direcao

# Referenciando nós
@onready var player = $"../Player"
@onready var inimigo = $"."
@onready var game = get_parent()
@onready var animacao = get_node('AnimatedSprite2D')

func _ready():
	
	pass

func _physics_process(delta):
	
	mover_inimigo(delta)
	
func mover_inimigo(delta):
	# Resetando a velocidade a cada frame para que não se acumule 
	velocity.x = 0
	velocity.y = 0
	
	# Fazendo com que o inimigo siga o player utilizando o parâmetro global_position para avaliar a posição de cada um durante cada frame
	if inimigo.global_position.x < player.global_position.x + 1:
		
		velocity.x += velocidade
		
		animacao.flip_h = false
	
	if (inimigo.global_position.x > player.global_position.x):
		
		velocity.x -= velocidade
			
		animacao.flip_h = true
	
	if (inimigo.global_position.y < player.global_position.y):
		
		velocity.y += velocidade
	
	if (inimigo.global_position.y > player.global_position.y):
		
		velocity.y -= velocidade 
	
	move_and_collide(velocity * delta)
	
	
