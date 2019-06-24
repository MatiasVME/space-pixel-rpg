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

var win = false

func _ready():
	enemy_mesh = load("res://Scenes/Levels/Enemies/" + str(LevelManager.enemy_mesh) + ".tscn").instance()
	add_child(enemy_mesh)
	
	for enemy in enemy_mesh.get_children():
		enemy.connect("dead", self, "_on_enemy_dead")
		enemy.connect("mark_to_death", self, "_on_enemy_mark_to_death")
	
	path_figure = load("res://Scenes/Levels/PathFigures/" + str(LevelManager.path_figure) + ".tscn").instance()
	add_child(path_figure)
	
	player = PlayerManager.create_player()
	path_figure.get_node("Follow").add_child(player)
	
	player.player_data.connect("dead", self, "_on_player_dead")
	player.player_data.connect("remove_hp", self, "_on_remove_hp")
	player.player_data.connect("level_up", self, "_on_level_up")
	
	Main.reset_store()
	Main.result = Main.Result.NONE
	
	MusicManager.random_music()
	
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

func win_check():
	# Es 1 por que el último enemigo todavía no muere
	if enemy_mesh.get_child_count() <= 1:
		Main.result = Main.Result.WIN
		$ResultPanel/Anim.play("Win")
		SoundManager.play(SoundManager.Sound.WIN1)
		win = true

func _on_Controls_move_left(pressed):
	move_left = pressed

func _on_Controls_move_right(pressed):
	move_right = pressed
	
func _on_enemy_dead():
	if not win:
		win_check()
		
func _on_player_dead():
	Main.result = Main.Result.LOSE
	$ResultPanel/Anim.play("Lose")
	SoundManager.play(SoundManager.Sound.LOSE1)

func _on_Anim_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Levels/EndLevel.tscn")

func _on_remove_hp(amount):
	if not $Effects/Anim.is_playing():
		$Effects/Anim.play("Damage")
		
# Antes de morir definitivamente
func _on_enemy_mark_to_death():
	if not $Effects/Anim.is_playing():
		$Effects/Anim.play("EnemyDeath")
		
func _on_level_up(level):
	player.player_data.max_hp += 2
	player.player_data.add_hp(2)
	player.player_data.attack += 1

func _on_Timer_timeout():
#
#	if not win:
#		win_check()
	pass