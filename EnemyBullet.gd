extends GBullet

class_name EnemyBullet

var dest := Vector2()

func _ready():
	origin_pos = global_position
	dir = (dest - global_position).normalized()
	
	SoundManager.play(SoundManager.Sound.LASER1)

func _process(delta):
	move_and_slide(dir * 100)
	$Sprite.rotation_degrees += delta * 600

func _on_CollisionArea_body_entered(body):
	if body is GPlayer:
		body.damage(damage)
		queue_free()
