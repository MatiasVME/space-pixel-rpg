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

var start = false

# Sirve para que reducir una sola vez la vida de las
# cajas cuando mueren todos los enemigos.
var ot_reduces_boxes_hp = true 

func _ready():
	# Primero generamos al path y al player para que los
	# enemigos puedan detectar al player.
	path_figure = load("res://Scenes/Levels/PathFigures/" + str(LevelManager.path_figure) + ".tscn").instance()
	add_child(path_figure)
	
	player = PlayerManager.create_player()
	path_figure.get_node("Follow").add_child(player)
	
	player.player_data.connect("dead", self, "_on_player_dead")
	player.player_data.connect("remove_hp", self, "_on_remove_hp")
	player.player_data.connect("level_up", self, "_on_level_up")
	
	enemy_mesh = load("res://Scenes/Levels/Enemies/" + str(LevelManager.enemy_mesh) + ".tscn").instance()
	add_child(enemy_mesh)
	
	for enemy in enemy_mesh.get_children():
		enemy.connect("dead", self, "_on_enemy_dead", [enemy])
		enemy.connect("mark_to_death", self, "_on_enemy_mark_to_death")
		
		# Verifica si existe un boss para conectar la barra
		# si es que existe
		if enemy.is_boss:
			$HUD/BossBar.show()
			$HUD/BossBar.set_boss(enemy)
	
	Main.reset_store()
	Main.result = Main.Result.NONE
	
	MusicManager.random_music()
	
	# Tutorial, solo aparece en android
	if Main.current_level == 1 and OS.get_name() == "Android":
		add_child(load("res://Scenes/Levels/Tutorial.tscn").instance())
		
	
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
	
	# Empezar cuando se preciona una tecla
	if not start and dir != 0:
		start = true
		player.is_frozen = false
		
		$Tap/Tap/Anim.play("Hide")
		
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			enemy.is_frozen = false
	
	current_speed = lerp(current_speed, dir * speed, acceleration * delta)
	path_figure.get_node("Follow").offset += current_speed
	player.look_at($Center.position)
	player.rotation_degrees += 90

func win_check():
	# Es 1 por que el último enemigo todavía no muere
	if enemy_mesh.get_child_count() <= 1:
		Main.result = Main.Result.WIN
		$ResultPanel/Anim.play("Win")
		SoundManager.play(SoundManager.Sound.YOU_WIN1)
		win = true
		
func only_boxes_check(enemy_except):
	var all_enemies = get_tree().get_nodes_in_group("Enemy")
	
	for enemy in all_enemies:
		if not enemy.is_in_group("Box") and enemy != enemy_except:
			return false
	return true
	
func _on_Controls_move_left(pressed):
	move_left = pressed

func _on_Controls_move_right(pressed):
	move_right = pressed
	
func _on_enemy_dead(who):
	if win: return
	
	win_check()
	
	if ot_reduces_boxes_hp and only_boxes_check(who):
		ot_reduces_boxes_hp = false
		
		var boxes = get_tree().get_nodes_in_group("Box")
		
		for box in boxes:
			box.frail_mode()
		
func _on_player_dead():
	if win: return
	
	Main.result = Main.Result.LOSE
	$ResultPanel/Anim.play("Lose")
	SoundManager.play(SoundManager.Sound.YOU_LOSE1)

func _on_Anim_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Levels/EndLevel.tscn")

func _on_remove_hp(amount):
	$Effects/AnimDamage.play("Damage")
		
# Antes de morir definitivamente
func _on_enemy_mark_to_death():
	$Effects/AnimEnemyDeath.play("EnemyDeath")
		
func _on_level_up(level):
	player.player_data.max_hp += 2
	player.player_data.add_hp(2)
	player.player_data.attack += 1
