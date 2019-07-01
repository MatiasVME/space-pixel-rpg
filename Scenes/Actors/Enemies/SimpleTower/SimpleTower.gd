extends GEnemy

export (float) var fire_rate = 1.0

var enemy_bullet = preload("res://Scenes/Bullets/EnemyBullet.tscn")

func _ready():
	randomize()
	
	$CanFire.wait_time = rand_range(4, 8)
	$CanFire.start()
	
	$FireRate.wait_time = fire_rate
	$FireRate.start()
	
func fire():
	if not can_fire or is_frozen or is_mark_to_dead:
		return
		
	var enemy_bullet_object = enemy_bullet.instance()
	enemy_bullet_object.global_position = $Sprite.global_position
	enemy_bullet_object.dest = $Sprite.global_position + Vector2(rand_range(-1, 1), rand_range(-1, 1))
	enemy_bullet_object.damage = attack
	enemy_bullet_object.velocity = 45
	get_parent().get_parent().add_child(enemy_bullet_object)

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
		SoundManager.play(SoundManager.Sound.DEATH_SCREAM6)

func _on_FireRate_timeout():
	fire()
	
func _on_CanFire_timeout():
	can_fire = not can_fire

func _on_HitArea_body_entered(body):
	if body is PlayerBullet:
		damage(body.damage)
		body.queue_free()

func _on_Anim_animation_finished(anim_name):
	if anim_name == "Dead":
		.dead()
