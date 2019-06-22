extends GEnemy

var player

var dir

func _process(delta):
	if player:
		dir = (player.global_position - global_position).normalized()
		move_and_slide(dir * delta * 2000)

func _on_SeekerArea_body_entered(body):
	if body is GPlayer:
		player = body
		
func _on_SeekerArea_body_exited(body):
	if body is GPlayer:
		player = null
		