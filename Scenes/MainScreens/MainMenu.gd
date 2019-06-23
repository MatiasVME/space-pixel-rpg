extends Node2D

signal credits_pressed

func _on_Credits_pressed():
	emit_signal("credits_pressed")

func _on_Start_pressed():
	$SpaceshipMenu/Anim.play("Go")
