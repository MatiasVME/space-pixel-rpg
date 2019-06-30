extends Node2D

var boss
var hp_max

func set_boss(_boss):
	boss = _boss
	hp_max = boss.hp
	
	update_boss_bar()
	
	boss.connect("damage", self, "_on_damage")

func update_boss_bar():
	$BossBar.max_value = hp_max
	$BossBar.value = boss.hp
	
func _on_damage():
	update_boss_bar()