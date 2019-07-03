extends GEnemy

onready var player = get_tree().get_nodes_in_group("Player")

export (int) var speed = 800
export (float) var attack_timer = 0.25

var dir

func _ready():
	$Body.play("default")
	
	print(player)
	
	if player.size() > 0:
		player = player[0]
		print("encontro al jugador")
		
	$AtackTimer.wait_time = 0.25

func _process(delta):
	if is_frozen or not player:
		return
		
	dir = (player.global_position - global_position).normalized()
	move_and_slide(dir * delta * speed)

func damage(amount):
	if is_mark_to_dead:
		return
		
	$Anim.play("Damage")
	hp -= amount
	emit_signal("damage")
	
	if hp <= 0:
		emit_signal("mark_to_death")
		$Anim.play("Dead")
		$Collision.disabled = true
		is_mark_to_dead = true
		SoundManager.play(SoundManager.Sound.DEATH_SCREAM2)

func _on_HitArea_body_entered(body):
	if is_frozen:
		return
	
	if body is PlayerBullet:
		damage(body.damage)
		body.free()
	elif body is GPlayer:
		$AtackTimer.start()
		
func _on_Anim_animation_finished(anim_name):
	if anim_name == "Dead":
		.dead()

func _on_AtackTimer_timeout():
	player.damage(attack)
	$Anim.play("Attack")

func _on_HitArea_body_exited(body):
	if body is GPlayer:
		$AtackTimer.stop()