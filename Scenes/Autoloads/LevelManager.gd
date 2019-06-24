extends Node

var enemy_mesh = 1
var path_figure = 1

func level(level):
	match level:
		1: 
			enemy_mesh = 1
			path_figure = 1
		2: 
			enemy_mesh = 2
			path_figure = 2
		3: 
			enemy_mesh = 3
			path_figure = 2
	
	get_tree().change_scene("res://Scenes/Levels/GLevel.tscn")
	Main.current_level = level