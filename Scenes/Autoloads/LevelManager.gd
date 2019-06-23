extends Node

var enemy_mesh = 1
var path_figure = 1

func level(level):
	match level:
		1: 
			enemy_mesh = 1
			path_figure = 1
			get_tree().change_scene("res://Scenes/Levels/GLevel.tscn")
		
		