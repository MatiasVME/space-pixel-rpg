extends Node2D

class_name GPlayer

var player_data

var player_bullet = preload("res://Scenes/Bullets/PlayerBullet.tscn")

func _ready():
	player_data = DataManager.players[0]
	
	player_data.connect("dead", self, "_on_dead")

func damage(amount):
	player_data.damage(amount)

func _on_dead():
	$Anim.play("dead")
	$Collision.disabled = true
	$Timer.stop()

func _on_Timer_timeout():
	var bullet = player_bullet.instance()
	bullet.position = $Sprite/SpawnBullet.global_position
	get_parent().get_parent().add_child(bullet)
	
	
