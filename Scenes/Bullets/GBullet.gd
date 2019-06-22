extends KinematicBody2D

class_name GBullet

var dir
var origin_pos
var damage = 1

onready var center = Vector2(100, 200)

func _on_Notifier_screen_exited():
	queue_free()
