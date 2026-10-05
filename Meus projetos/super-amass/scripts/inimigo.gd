extends CharacterBody2D

# Variáveis
@export var velocidade = 50
var colisao

# Referenciando nós
@onready var player = $"../Player"
@onready var inimigo = $"."
@onready var vida = get_parent().get_node('Vida') 
@onready var game = get_parent()

func _ready():
	
	pass

func _physics_process(delta):
	colisao = mover_inimigo(delta)
	
	perder_vida()
	
func mover_inimigo(delta):
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
	
	var colisao = move_and_collide(velocity * delta)
	
	return colisao
	
func perder_vida():
	if colisao != null:
		if colisao.get_collider().name == 'Player':
			
			if game.vida1.total_vidas == 3:
				game.vida1.total_vidas = 2
				
				game.vida1.visible = false
				
				player.invencivel = true
				game.timer_invencivel_player.start()
			
			if player.invencivel == false:
				if game.vida1.total_vidas == 2:
					game.vida1.total_vidas = 1
					
					game.vida2.visible = false
					
					player.invencivel = true
					game.timer_invencivel_player.start()
					
			if player.invencivel == false:
				if game.vida1.total_vidas == 1:
					game.vida1.total_vidas = 0
					
					game.vida3.visible = false
