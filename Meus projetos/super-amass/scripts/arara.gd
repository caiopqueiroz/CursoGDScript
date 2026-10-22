extends CharacterBody2D

@onready var arara = $"."
@onready var player = $"../Player"

var velocidade_horizontal = 1
var velocidade_vertical = 1
var cena_pedra = preload("res://cenas/pedra.tscn")

func _ready():
	
	print(arara.global_position)
	
	jogar_pedra()

func _physics_process(delta):
	
	mover_arara(delta)
	
	#if arara.global_position.x == player.global_position.x:
		
	#	jogar_pedra()
	
func mover_arara(delta):
	
	velocity.x = 0
	velocity.y = 0
	
	#if arara.global_position.x < player.global_position.x:
		
	#position.x += velocidade_horizontal
	
	if arara.global_position.y < (player.global_position.y - 150):
		
		position.y += velocidade_vertical
		
	move_and_collide(velocity * delta)

func jogar_pedra():
	
	# IDEIA: Criar a função jogar_pedra dentro da cena game 
	
	var posicao = arara
	
	var instancia_pedra = cena_pedra.instantiate()
	
	posicao.position.y += 100

	instancia_pedra.global_position = posicao.position
	
	#instancia_pedra.position.x += 20
	#instancia_pedra.position.y += 20
	
	add_child(instancia_pedra)
