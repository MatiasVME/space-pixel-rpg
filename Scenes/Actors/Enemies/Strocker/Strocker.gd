extends GEnemy

var objective
var dir

func _process(delta):
	if objective and not is_mark_to_dead:
		dir = (objective.global_position - global_position).normalized()
		move_and_slide(dir * delta * 2000)

func damage(amount):
	$Anim.play("Damage")
	hp -= amount
	
	if hp <= 0:
		$Anim.play("Dead")
		$Collision.disabled = true
		is_mark_to_dead = true
		SoundManager.play(SoundManager.Sound.DEATH_SCREAM1)
		
func _on_SeekerArea_body_entered(body):
	if body is GPlayer:
		objective = body
		
func _on_SeekerArea_body_exited(body):
	if body is GPlayer:
		objective = null
		
func _on_HitArea_body_entered(body):
	if is_mark_to_dead:
		return
	
	if body is GPlayer:
		body.damage(attack)
		$Anim.play("Attack")
	elif body is PlayerBullet:
		damage(body.damage)
		body.queue_free()

func _on_Anim_animation_finished(anim_name):
	if anim_name == "Dead":
		.dead()
