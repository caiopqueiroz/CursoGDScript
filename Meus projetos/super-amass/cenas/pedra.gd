extends Area2D

var aceleracao = 400

@onready var pedra = $"."

func _physics_process(delta):
	
	if pedra.position.y < 1000:
		
		position.y += aceleracao * delta
		
		# Usando a função clampf para travar a posição da Area2D e não deixar que a velocidade cresça infinitamente
		position.y = clampf(position.y, -position.y, position.y)
		
	
