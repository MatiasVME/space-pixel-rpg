extends KinematicBody2D

class_name GBullet

var dir
var origin_pos
var damage = 1

onready var center = Vector2(Main.RES_X/2, Main.RES_Y/2)

func _on_Notifier_screen_exited():
	queue_free()

func _on_Timer_timeout():
	queue_free()
