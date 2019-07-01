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
		9: 
			enemy_mesh = 9
			path_figure = 4
		10: 
			enemy_mesh = 10
			path_figure = 1
		11: 
			enemy_mesh = 11
			path_figure = 1
		12: 
			enemy_mesh = 12
			path_figure = 5
		13: 
			enemy_mesh = 13
			path_figure = 7
		14: 
			enemy_mesh = 14
			path_figure = 6
		
	get_tree().change_scene("res://Scenes/Levels/GLevel.tscn")
	Main.current_level = level