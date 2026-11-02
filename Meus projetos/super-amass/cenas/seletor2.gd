extends Node2D

@onready var jogar = get_node("../Jogar")
@onready var timer_diminuicao = get_node("../Timer_diminuicao")
@onready var timer_direita = get_node("../Timer_direita")
@onready var bestiario = get_node("../Bestiario")
@onready var emblemas = get_node("../Emblemas")

func _process(delta):
	
	if Input.is_action_just_pressed('ui_left'):
		
		timer_diminuicao.start()
		
		timer_direita.start()
		
	if not timer_diminuicao.is_stopped():
		
		if jogar.label_settings.font_size > 60:
		
			jogar.label_settings.font_size -= 2
			
	if not timer_direita.is_stopped():
		
		if bestiario.position.x < 450:
			
			bestiario.position.x += 10
		
		if jogar.position.x < 750:
			
			jogar.position.x += 10
			
		if emblemas.position.x < 1050:
			
			emblemas.position.x += 10
		
