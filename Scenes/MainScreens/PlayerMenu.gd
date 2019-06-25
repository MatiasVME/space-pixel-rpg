extends Node2D

func _ready():
	$Score/Score.text = str(DataManager.global_config["Score"])