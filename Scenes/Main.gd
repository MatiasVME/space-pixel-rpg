extends Node

func _ready():
	pass

func _on_TestTimer_timeout():
	get_tree().change_scene("res://Scenes/Levels/LevelTemplate.tscn")