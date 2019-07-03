extends GEnemy

export (bool) var is_frail = false

func _ready():
	if is_frail:
		frail_mode()

func damage(amount):
	hp -= amount
	emit_signal("damage")
	
	if hp <= 0:
		emit_signal("mark_to_death")
#		$Collision.disabled = true
		is_mark_to_dead = true
		SoundManager.play(SoundManager.Sound.BOX_DEATH1)
		.dead()

func frail_mode():
	hp = 1
	$Sprite.self_modulate = Color("711c91")

func _on_HitArea_body_entered(body):
	if body is PlayerBullet:
		var initial_hp = hp
		damage(body.damage)
		
		body.damage -= initial_hp
		if body.damage <= 0:
				body.free()

