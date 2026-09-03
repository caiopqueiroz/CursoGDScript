extends Node2D

# Criando uma variável para pré-carregar a cena do inimigo 
var cena_inimigo = preload("res://cenas/inimigo.tscn")

# Referenciando o nó de posição do inimigo
@onready var posicao_inimigo = $Posicao_inimigo

# Criando uma variável para controlar o total de inimigo na tela
var total_inimigos = 0

func _process(delta):
	
	print(total_inimigos)
	
# Chamando a função gerar_inimigo a cada momento que o timer zerar 
func _on_gerador_inimigo_timeout() -> void:
	if total_inimigos < 5:
		gerar_inimigo()
		
		total_inimigos += 1
	
# Criando uma função para gerar inimigos na cena
func gerar_inimigo():
	# Definindo a posição do inimigo 
	var posicao = posicao_inimigo
	
	# Instanciando a cena inimigo
	var instancia_inimigo = cena_inimigo.instantiate()
	
	# Definindo a posição da instância 
	instancia_inimigo.global_position = posicao.position
	
	# Adicionando a cena inimigo à cena principal
	add_child(instancia_inimigo)
