extends GEnemy

func _on_HitArea_body_entered(body):
	if body is PlayerBullet:
		queue_free()
		body.queue_free()
