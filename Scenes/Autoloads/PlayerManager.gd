extends Node

enum Players {
	GOODSHIP
}

var p_goodship = preload("res://Scenes/Actors/Players/GoodShip/GoodShip.tscn")

func create_player():
	# test
	return p_goodship.instance()
	