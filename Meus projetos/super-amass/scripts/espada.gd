extends Area2D

# Usando a função criada por um sinal para retirar o nó espada, ou seja, fazê-la sumir quando tocar o inimigo
func _on_body_entered(body):
	queue_free()
	# Do mesmo modo, fazendo o inimigo, que se torna o argumento do parâmetro body, ser deletado também
	body.queue_free()
