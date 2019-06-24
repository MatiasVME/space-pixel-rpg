extends GEnemy

func _on_HitArea_body_entered(body):
	if body is PlayerBullet:
		SoundManager.play(SoundManager.Sound.BOX_DEATH1)
		emit_signal("mark_to_death")
		body.queue_free()
		dead()
