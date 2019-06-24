extends KinematicBody2D

class_name GEnemy

export (int) var hp = 1
export (int) var drop_xp = 2
export (int) var drop_score = 2
export (int) var attack = 4

var is_mark_to_dead = false

onready var player_data = DataManager.players[0]

signal dead

func dead():
	player_data.add_xp(drop_xp)
	Main.store_score += drop_score
	emit_signal("dead")
	queue_free()