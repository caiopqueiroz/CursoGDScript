extends CharacterBody2D

# Definindo a velocidade do inimigo
var velocidade = 50

func _physics_process(delta):
	# Resetando a velocidade a cada frame para que não se acumule 
	velocity.x = 0
	velocity.y = 0
	
	velocity.x += velocidade
	
	move_and_collide(velocity * delta)
