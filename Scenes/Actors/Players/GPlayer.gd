extends Node2D

class_name GPlayer

var player_bullet = preload("res://Scenes/Bullets/PlayerBullet.tscn")

func _ready():
	pass

func _on_Timer_timeout():
	var bullet = player_bullet.instance()
	bullet.position = $Sprite/SpawnBullet.global_position
	get_parent().get_parent().add_child(bullet)
	
	
