extends Node2D

func _ready():
	SoundManager.play(SoundManager.Sound.BULLET_EXPLOSION1)
	$Explosion.play("default")
	
func _process(delta):
	rotation_degrees += delta * 200

func _on_Explosion_animation_finished():
	queue_free()
