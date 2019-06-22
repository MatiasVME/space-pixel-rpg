extends GEnemy

var player

var dir

func _process(delta):
	if player:
		dir = (player.global_position - global_position).normalized()
		move_and_slide(dir * delta * 2000)

func damage(amount):
	$Anim.play("Damage")
	hp -= amount
	
	if hp <= 0:
		$Anim.play("Dead")
		$Collision.disabled = true

func _on_SeekerArea_body_entered(body):
	if body is GPlayer:
		player = body
		
func _on_SeekerArea_body_exited(body):
	if body is GPlayer:
		player = null
		
func _on_HitArea_body_entered(body):
	if body is GPlayer:
		body.damage(attack)
		$Anim.play("Attack")
	elif body is PlayerBullet:
		damage(body.damage)

func _on_Anim_animation_finished(anim_name):
	if anim_name == "Dead":
		queue_free()
