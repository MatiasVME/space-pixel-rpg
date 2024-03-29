extends GBullet

class_name EnemyBullet

var dest := Vector2()
var velocity := 100

func _ready():
	origin_pos = global_position
	dir = (dest - global_position).normalized()
	
	SoundManager.play(SoundManager.Sound.LASER1)

func _process(delta):
	move_and_slide(dir * velocity)
	$Sprite.rotation_degrees += delta * 600

func get_class_name():
	return "EnemyBullet"

func _on_CollisionArea_body_entered(body):
	if body is GPlayer:
		body.damage(damage)
		queue_free()