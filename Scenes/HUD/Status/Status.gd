extends Node2D

onready var player_data = DataManager.players[0]

func _ready():
	update_hp()
	update_xp()
	update_lvl()

	player_data.connect("level_up", self, "_on_level_up")
	player_data.connect("add_xp", self, "_on_add_xp")
	player_data.connect("add_hp", self, "_on_add_hp")
	player_data.connect("remove_hp", self, "_on_remove_hp")
	
func update_hp():
	$HP/HPProgress.max_value = player_data.max_hp
	$HP/HPProgress.value = player_data.hp
	
func update_xp():
	$XP/XPProgress.max_value = player_data.get_xp_required(player_data.level + 1)
	$XP/XPProgress.value = player_data.xp

func update_lvl():
	$Level/Label.text = str(player_data.level)

func _on_level_up(current_level):
	update_lvl()
	SoundManager.play(SoundManager.Sound.LEVEL_UP1)	
	
func _on_add_xp(amount):
	update_xp()

func _on_add_hp(amount):
	update_hp()
	
func _on_remove_hp(amount):
	update_hp()

