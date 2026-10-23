extends Area2D

var aceleracao = 400

@onready var pedra = $"."
@onready var game = get_parent()
@onready var player = get_parent().get_node('Player')

func _physics_process(delta):
	
	if pedra.position.y < 1000:
		
		position.y += aceleracao * delta
		
		# Usando a função clampf para travar a posição da Area2D e não deixar que a velocidade cresça infinitamente
		position.y = clampf(position.y, -position.y, position.y)
		
func _on_body_entered(body):
	
	perder_vida()

func perder_vida():
	
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
