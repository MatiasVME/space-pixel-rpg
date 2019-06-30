extends GBullet

class_name PlayerBullet

var explosion = preload("res://Scenes/Bullets/BulletExplosion.tscn")

func _ready():
	origin_pos = global_position
	dir = (center - global_position).normalized()
	
	SoundManager.play(SoundManager.Sound.LASER2)

func _process(delta):
	move_and_slide(dir * 200)
	$Sprite.rotation_degrees += delta * 600
	
func _on_CollisionArea_body_entered(body):	
	if body.has_method("get_class_name") and body.get_class_name() == "EnemyBullet" and body.is_explosive and is_explosive:
		var my_explosion = explosion.instance()
		get_parent().add_child(my_explosion)
		my_explosion.global_position = global_position
		body.queue_free()
		queue_free()