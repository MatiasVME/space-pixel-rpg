extends Node2D

var player

var move_left := false
var move_right := false

var dir # input direction
#var current_direction = 0

var acceleration = 2
var current_speed = 0
var speed = 2.5

func _ready():
	player = PlayerManager.create_player()
	$"001/Follow".add_child(player)
	
func _process(delta):
#	$"001/Follow".offset += delta * 30 
#	player.look_at($Center.position)
#	player.rotation_degrees += 90
	
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
	print(dir)
	
	current_speed = lerp(current_speed, dir * speed, acceleration * delta)
	$"001/Follow".offset += current_speed
	player.look_at($Center.position)
	player.rotation_degrees += 90
	print(current_speed)
	
func _on_Controls_move_left(pressed):
	move_left = pressed

func _on_Controls_move_right(pressed):
	move_right = pressed
