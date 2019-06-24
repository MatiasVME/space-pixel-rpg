extends Node

func _ready():
	$MainMenu.connect("credits_pressed", self, "_on_credits_pressed")
	MusicManager.random_music()

func _on_credits_pressed():
	$Camera.global_position = Vector2(300, 200)
	SoundManager.play(SoundManager.Sound.BUTTON1)

func _on_Back_pressed():
	$Camera.global_position = Vector2(100, 200)
	$MainMenu/SpaceshipMenu/Anim.play("Start")
	SoundManager.play(SoundManager.Sound.SPACESHIP_FLY_MENU2)

func _on_Start_pressed():
	$Camera.global_position = Vector2(100, -200)
	SoundManager.play(SoundManager.Sound.SPACESHIP_FLY_MENU1)

func _on_Config_pressed():
	$Camera.global_position = Vector2(-100, 200)
	SoundManager.play(SoundManager.Sound.BUTTON1)
