extends Node

var firebase

func _ready():
	if OS.get_name() != "Android":
		return
		
	init_firebase()
	
func init_firebase():
	firebase = Engine.get_singleton("FireBase")

	var file = File.new()
	file.open("res://godot-firebase-config.json", file.READ)

	var config = file.get_as_text()
	file.close()

	firebase.init(config, get_instance_id())
	firebase.set_debug(Main.DEBUG_FIREBASE)