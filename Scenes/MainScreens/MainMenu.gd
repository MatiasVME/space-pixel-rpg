extends Node2D

signal credits_pressed

func _ready():
	SoundManager.play(SoundManager.Sound.SPACESHIP_FLY_MENU2)
	
	$Version.text = Main.VERSION
	
func _on_Credits_pressed():
	emit_signal("credits_pressed")

func _on_Start_pressed():
	$SpaceshipMenu/Anim.play("Go")
	SoundManager.play(SoundManager.Sound.SPACESHIP_FLY_MENU1)

func _on_PrivacyPolicy_pressed():
	$Dialog.show()

func _on_Dialog_confirmed():
	OS.shell_open("https://furygames.github.io/privacy_policy_sprpg.html")
	