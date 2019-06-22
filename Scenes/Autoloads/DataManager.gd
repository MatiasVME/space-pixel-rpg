extends Node

var current_user := "User"
var global_config # Es una referencia al diccionario de $DataGlobalConfig

# Instancias, para ser utilizadas. Instancias de RPGElements.
var players = []

# Si este numero cambia la data se borra, normalmente el numero
# debe ir incrementando
var delete_data = 3

func _ready():
	configure_persistence_node()
	create_or_load_data_if_not_exist()

func configure_persistence_node():
	if Main.DEBUG:
		$DataPlayers.mode = $DataPlayers.Mode.TEXT
		$DataGlobalConfig.mode = $DataGlobalConfig.Mode.TEXT
	else:
		$DataGlobalConfig.mode = $DataGlobalConfig.Mode.ENCRYPTED
		$DataPlayers.mode = $DataPlayers.Mode.ENCRYPTED
	
	$DataGlobalConfig.folder_name = "Global"
	
	$DataPlayers.folder_name = current_user

func create_or_load_data_if_not_exist():
	global_config = $DataGlobalConfig.get_data()
	
	if global_config.empty():
		# Crea la data
		#

		create_global_config()
		create_players()
	elif global_config["DeleteData"] != delete_data:
		remove_all_data()
		get_tree().quit()
	else:
		# Carga la data
		#
		
		# GlobalConfig ya se cargo anteriormente.
		
		load_players()

func save_all_data():
	save_players()

func create_global_config():
	global_config["DeleteData"] = delete_data
	$DataGlobalConfig.save_data()
	
func create_players():
	var temp_data
	temp_data = $DataPlayers.get_data("Players")
	
	players.append(RPGCharacter.new())
	temp_data[players.size() - 1] = inst2dict(players[players.size() - 1])
	
#	# TEMP: Crea otro player
#	players.append(PHCharacter.new())
#	temp_data[players.size() - 1] = inst2dict(players[players.size() - 1])
#	players[players.size() - 1].player_type = Enums.PlayerType.MATBOT

	$DataPlayers.save_data("Players")
	
func save_players():
	var temp_data = $DataPlayers.get_data("Players")
	temp_data.clear()
	
	for i in players.size():
		temp_data[i] = RPGElement.gdc2gd(inst2dict(players[i]))
	
	$DataPlayers.save_data("Players")
	
func load_players():
	var temp_data = $DataPlayers.get_data("Players")
	players = []

	for player in temp_data.values():
		players.append(dict2inst(player))

func remove_all_data():
	$DataGlobalConfig.remove_all_data()
	$DataPlayers.remove_all_data()