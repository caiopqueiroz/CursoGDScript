extends CharacterBody2D

# Variáveis
@export var velocidade = 50
var colisao
var direcao
var leopardo = load("res://sprites/novos_sprites/leopardo/Leopardo.png")
var leopardo_direita = load("res://sprites/novos_sprites/leopardo/Leopardo direita.png")
var sprites_leopardo_direita = [
	load("res://sprites/novos_sprites/leopardo/Leopardo andando direita.png"),
	load("res://sprites/novos_sprites/leopardo/Leopardo direita.png"),
	load("res://sprites/novos_sprites/leopardo/Leopardo andando direita 2.png") 
]
var sprites_leopardo_esquerda = [
	load("res://sprites/novos_sprites/leopardo/Leopardo andando.png"),
	load("res://sprites/novos_sprites/leopardo/Leopardo.png"),
	load("res://sprites/novos_sprites/leopardo/Leopardo andando 2.png")
]
var trocar_sprite = false
var numero_sprite = 0

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
	
	animacao_inimigo()
	
func mover_inimigo(delta):
	# Resetando a velocidade a cada frame para que não se acumule 
	velocity.x = 0
	velocity.y = 0
	
	# Fazendo com que o inimigo siga o player utilizando o parâmetro global_position para avaliar a posição de cada um durante cada frame
	if (inimigo.global_position.x < player.global_position.x):
		
		velocity.x += velocidade
		
		direcao = 'direita'
		#if direcao == 'direita':
		#	$Sprite2D.texture = leopardo_direita
	if (inimigo.global_position.x > player.global_position.x):
		
		velocity.x -= velocidade
		
		direcao = 'esquerda'
		#if direcao == 'esquerda':
		#	$Sprite2D.texture = leopardo
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

func animacao_inimigo():
	
	if direcao == 'direita':
		
		if trocar_sprite:
			
			$Sprite2D.texture = sprites_leopardo_direita[numero_sprite]
			
			trocar_sprite = false
	if direcao == 'esquerda':
		
		if trocar_sprite:
			
			$Sprite2D.texture = sprites_leopardo_esquerda[numero_sprite]
			
			trocar_sprite = false

func _on_timer_trocar_sprite_timeout() -> void:
	
	trocar_sprite = true
	
	if numero_sprite == 0:
		numero_sprite = 1
	elif numero_sprite == 1:
		numero_sprite = 2
	else: 
		numero_sprite = 0
	
	#print('trocou o sprite')
