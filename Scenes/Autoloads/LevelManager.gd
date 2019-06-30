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
		4: 
			enemy_mesh = 4
			path_figure = 3
		5: 
			enemy_mesh = 5
			path_figure = 1
		6: 
			enemy_mesh = 6
			path_figure = 2
		7: 
			enemy_mesh = 7
			path_figure = 1
		8: 
			enemy_mesh = 8
			path_figure = 1
		
	get_tree().change_scene("res://Scenes/Levels/GLevel.tscn")
	Main.current_level = level