extends Node

func _ready():
	$MainMenu.connect("credits_pressed", self, "_on_credits_pressed")

func _on_credits_pressed():
	$Camera.global_position = Vector2(300, 200)

func _on_Back_pressed():
	$Camera.global_position = Vector2(100, 200)
	$MainMenu/SpaceshipMenu/Anim.play("Start")

func _on_Start_pressed():
	$Camera.global_position = Vector2(100, -200)
