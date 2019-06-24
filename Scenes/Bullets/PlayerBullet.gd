extends GBullet

class_name PlayerBullet

func _ready():
	origin_pos = global_position
	dir = (center - global_position).normalized()
	
	SoundManager.play(SoundManager.Sound.LASER2)

func _process(delta):
	move_and_slide(dir * 200)
	$Sprite.rotation_degrees += delta * 600