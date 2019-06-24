extends GEnemy

func damage(amount):
	hp -= amount
	
	if hp <= 0:
		emit_signal("mark_to_death")
		$Collision.disabled = true
		is_mark_to_dead = true
		SoundManager.play(SoundManager.Sound.BOX_DEATH1)
		.dead()
		
func _on_HitArea_body_entered(body):
	if body is PlayerBullet:
		damage(body.damage)
		body.queue_free()
		
