extends KinematicBody2D

class_name GEnemy

export (int) var hp := 1
export (int) var drop_xp := 2
export (int) var drop_score := 2
export (int) var attack := 4

var is_mark_to_dead := false
# Al principio no pueden disparar
var can_fire := false
var is_frozen := true

var is_boss := false

onready var player_data = DataManager.players[0]

signal dead
signal mark_to_death # Antes de morir
signal damage # Recibe daño

func dead():
	player_data.add_xp(drop_xp)
	Main.store_score += drop_score
	emit_signal("dead")
	queue_free()