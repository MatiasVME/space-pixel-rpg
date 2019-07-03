extends Node2D

func _ready():
	if not get_parent() is Viewport:
		$Back.visible = true
	else:
		$End.start()
		
	if DataManager.global_config["LastLevelPassed"] > 10:
		$PlayStore.visible = true
		$PlayStore/Anim.play("Show")

func _on_End_timeout():
	$Anim.play("End")

func _on_Anim_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Main.tscn")

func _on_PlayStore_pressed():
	OS.shell_open("https://play.google.com/store/apps/details?id=space.pixel.rpg.furygames")
