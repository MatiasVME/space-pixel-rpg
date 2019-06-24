extends GEnemy

func _on_HitArea_body_entered(body):
	if body is PlayerBullet:
		body.queue_free()
		dead()
