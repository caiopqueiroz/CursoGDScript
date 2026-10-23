extends CharacterBody2D

@onready var arara = $"."
@onready var player = $"../Player"

var velocidade_horizontal = 5
var velocidade_vertical = 5
var cena_pedra = preload("res://cenas/pedra.tscn")

func _ready():
	
	pass

func _physics_process(delta):
	
	mover_arara(delta)
	
func mover_arara(delta):
	
	velocity.x = 0
	velocity.y = 0
	
	if arara.global_position.x < 1300:
		
		position.x += velocidade_horizontal
	else:
		
		arara.queue_free()
	
	if arara.global_position.x < player.global_position.x:
	
		if arara.global_position.y < (player.global_position.y - 300):
		
			position.y += velocidade_vertical
	else:
			
		position.y -= velocidade_vertical
		
	move_and_collide(velocity * delta)
