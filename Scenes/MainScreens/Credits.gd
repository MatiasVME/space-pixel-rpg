extends Node2D

func _ready():
	if not get_parent() is Viewport:
		$Back.visible = true
	else:
		$End.start()

func _on_End_timeout():
	$Anim.play("End")

func _on_Anim_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Main.tscn")
