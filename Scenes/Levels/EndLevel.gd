extends Node2D

onready var player_data = DataManager.players[0]

func _ready():
	# Ads
	if OS.get_name() == "Android":
		randomize()
		
		if rand_range(0, 1.8) < 1:
			Firebase.firebase.show_interstitial_ad()
	
	player_data.revive()
	player_data.restore_hp()
	
	if Main.result == Main.Result.WIN:
		win()
	# Se pierde
	else:
		lose()
		
	DataManager.save_all_data()

func _process(delta):
	$Reload.rect_rotation -= delta * 300

func win():
	$ResultTitle.text = "YOU WIN!"
	$Score.text = str(Main.store_score)
	
	if Main.current_level + 1 <= Main.LAST_LEVEL + 1:
		$Next.visible = true
	
	DataManager.global_config["Score"] += Main.store_score
	
	if Main.current_level > DataManager.global_config["LastLevelPassed"] and Main.current_level + 1 != Main.LAST_LEVEL:
		DataManager.global_config["LastLevelPassed"] = Main.current_level

func lose():
	$ResultTitle.text = "YOU LOSE"
	
	Main.store_score /= 2
	$Score.text = str(Main.store_score)
	
	DataManager.global_config["Score"] += Main.store_score
	
func _on_Next_pressed():
	SoundManager.play(SoundManager.Sound.BUTTON1)
	
	if Main.current_level + 1 != Main.LAST_LEVEL + 1:
		LevelManager.level(Main.current_level + 1)
	else:
		get_tree().change_scene("res://Scenes/MainScreens/Credits.tscn")

func _on_Back_pressed():
	SoundManager.play(SoundManager.Sound.BUTTON1)
	get_tree().change_scene("res://Scenes/Main.tscn")
	
func _on_Reload_pressed():
	LevelManager.level(Main.current_level)
	
	SoundManager.play(SoundManager.Sound.BUTTON1)
