extends Node2D

onready var last_level = DataManager.global_config["LastLevelPassed"] + 1
var current_level = 0

func _ready():
	$Display.text = str(last_level)
	current_level = int(last_level)
	
func _on_Left_pressed():
	if current_level - 1 > 0:
		current_level -= 1
		$Display.text = str(current_level)
		
	SoundManager.play(SoundManager.Sound.BUTTON1)
	
func _on_Right_pressed():
	if current_level + 1 <= last_level:
		current_level += 1
		$Display.text = str(current_level)
		
	SoundManager.play(SoundManager.Sound.BUTTON1)
	
func _on_Start_pressed():
	LevelManager.level(current_level)
	SoundManager.play(SoundManager.Sound.BUTTON1)
	