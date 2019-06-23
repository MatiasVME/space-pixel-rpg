extends Node2D

var player

var move_left := false
var move_right := false

var dir # input direction

var acceleration = 2
var current_speed = 0
var speed = 2.5

var enemy_mesh
var path_figure

func _ready():
	enemy_mesh = load("res://Scenes/Levels/Enemies/" + str(LevelManager.enemy_mesh) + ".tscn").instance()
	add_child(enemy_mesh)
	
	path_figure = load("res://Scenes/Levels/PathFigures/" + str(LevelManager.path_figure) + ".tscn").instance()
	add_child(path_figure)
	
	player = PlayerManager.create_player()
	path_figure.get_node("Follow").add_child(player)
	
func _process(delta):
	# Entrada teclado
	#
	
	if not OS.get_name() == "Android":
		if Input.is_action_pressed("ui_left"): 
			move_left = true
		else:
			move_left = false
			
		if Input.is_action_pressed("ui_right"):
			move_right = true
		else:
			move_right = false
	
	dir = - int(move_left) + int(move_right)
	
	current_speed = lerp(current_speed, dir * speed, acceleration * delta)
	path_figure.get_node("Follow").offset += current_speed
	player.look_at($Center.position)
	player.rotation_degrees += 90
	
func _on_Controls_move_left(pressed):
	move_left = pressed

func _on_Controls_move_right(pressed):
	move_right = pressed
