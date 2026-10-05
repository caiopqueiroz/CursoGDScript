extends Area2D

# Referenciando nós
@onready var game = get_parent().get_parent()

func _on_body_entered(corpo):
	eliminar_inimigo(corpo)
	
	# Diminuindo a quantidade de inimigos na variável sempre que um é destruído
	game.total_inimigos -= 1
	
func eliminar_inimigo(corpo):
	corpo.queue_free()
	
	game.somar_ponto()

	
