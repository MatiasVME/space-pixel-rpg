extends GEnemy

var objective
var dir

var is_fire_area := false
var fire_objective

var rotator_acum = 0.0

var enemy_bullet = preload("res://Scenes/Bullets/EnemyBullet.tscn")

func _ready():
	is_boss = true

func _process(delta):
	if is_frozen:
		return
	
	if fire_objective is GPlayer and fire_objective.player_data.is_dead:
		can_fire = false
		return 
	
	if objective and not is_mark_to_dead and not is_fire_area:
		dir = (objective.global_position - global_position).normalized()
		move_and_slide(dir * delta * 2000)
	elif can_fire and fire_objective and not is_mark_to_dead:
		$Sprite.look_at(fire_objective.global_position)
		rotator_acum += delta * 300
		$Sprite.rotation_degrees += rotator_acum
		
		$Canon2.look_at(fire_objective.global_position)
		rotator_acum += delta * 300
		$Canon2.rotation_degrees += rotator_acum * 2
	
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

func _on_DetectPlayerArea_body_entered(body):
	if body is GPlayer:
		objective = body
		$Body.play("move")
		
func _on_DetectPlayerArea_body_exited(body):
	if body is GPlayer:
		objective = null
		$Body.stop()

func _on_FireArea_body_entered(body):
	if body is GPlayer:
		is_fire_area = true
		fire_objective = body
		$Body.stop()
		can_fire = true

func _on_FireArea_body_exited(body):
	if body is GPlayer:
		is_fire_area = false
		fire_objective = body
		$Body.play("move")
		can_fire = false

func _on_Fire_timeout():
	if is_frozen:
		return
	
	if not can_fire or is_mark_to_dead:
		return
	
	var enemy_bullet_object = enemy_bullet.instance()
	enemy_bullet_object.is_explosive = false
	enemy_bullet_object.dest = $Sprite/Dest.global_position
	enemy_bullet_object.global_position = $Sprite/Origin.global_position
	enemy_bullet_object.damage = attack
	enemy_bullet_object.velocity = 40
	get_parent().get_parent().add_child(enemy_bullet_object)
	
	var enemy_bullet_object2 = enemy_bullet.instance()
	enemy_bullet_object2.is_explosive = true
	enemy_bullet_object2.dest = $Canon2/Dest.global_position
	enemy_bullet_object2.global_position = $Canon2/Origin.global_position
	enemy_bullet_object2.damage = attack
	enemy_bullet_object2.velocity = 40
	get_parent().get_parent().add_child(enemy_bullet_object2)

	
func _on_HitArea_body_entered(body):
	if body is PlayerBullet:
		damage(body.damage)
		body.queue_free()

func _on_Anim_animation_finished(anim_name):
	if anim_name == "Dead":
		.dead()