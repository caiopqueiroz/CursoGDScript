extends Area2D

# Referenciando o nó game através da função get_parent() usada 2 vezes 
@onready var game = get_parent().get_parent()

# Usando a função criada por um sinal para retirar o nó espada, ou seja, fazê-la sumir quando tocar o inimigo
func _on_body_entered(body):
	queue_free()
	# Do mesmo modo, fazendo o inimigo, que se torna o argumento do parâmetro body, ser deletado também
	body.queue_free()
	
	# Diminuindo a quantidade de inimigos na variável sempre que um é destruído
	game.total_inimigos -= 1
