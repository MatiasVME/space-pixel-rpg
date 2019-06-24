extends Node2D

signal credits_pressed

func _ready():
	SoundManager.play(SoundManager.Sound.SPACESHIP_FLY_MENU2)

func _on_Credits_pressed():
	emit_signal("credits_pressed")

func _on_Start_pressed():
	$SpaceshipMenu/Anim.play("Go")
	SoundManager.play(SoundManager.Sound.SPACESHIP_FLY_MENU1)
