extends Node2D

@onready var jogar = get_node("../Jogar")
@onready var menu = get_parent()

func _ready():
	
	pass

func _process(delta):
	
	if Input.is_action_just_pressed('ui_down'):
		
		position.y += 100
		
		position.y = clampf(position.y, -position.y, position.y)
	
	if Input.is_action_just_pressed('ui_up'):
		
		position.y -= 100
		
		position.y = clampf(position.y, -position.y, position.y)
		
	if jogar.position.y == (position.y - 59):
		
		jogar.label_settings.font_color = Color(0.177, 0.486, 0.791, 1.0)
		
		if Input.is_action_just_pressed('Enter'):
			
			get_tree().change_scene_to_file("res://cenas/game.tscn")
	else:
		
		jogar.label_settings.font_color = Color(1.0, 1.0, 1.0, 1.0)
