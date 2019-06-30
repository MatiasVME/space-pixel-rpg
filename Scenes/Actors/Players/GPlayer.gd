extends Node2D

class_name GPlayer

var player_data
var is_frozen := true

var player_bullet = preload("res://Scenes/Bullets/PlayerBullet.tscn")

func _ready():
	player_data = DataManager.players[0]
	
	player_data.connect("dead", self, "_on_dead")
	player_data.connect("remove_hp", self, "_on_remove_hp")

func damage(amount):
	player_data.damage(amount)

func _on_dead():
	$Anim.play("dead")
	$Collision.disabled = true
	$Timer.stop()

func _on_Timer_timeout():
	if is_frozen:
		return
	
	if Main.result == Main.Result.WIN:
		$Timer.stop()
	
	var bullet = player_bullet.instance()
	bullet.global_position = $Sprite/SpawnBullet.global_position
	bullet.damage = player_data.attack
	get_parent().get_parent().add_child(bullet)
	
func _on_remove_hp(amount):
	SoundManager.play(SoundManager.Sound.PLAYER_DAMAGE1)
	