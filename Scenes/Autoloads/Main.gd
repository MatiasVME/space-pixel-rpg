extends Node

const RES_X := 200
const RES_Y := 400

const DEBUG := false
const MUSIC_ENABLE := true
const SOUND_ENABLE := true

const LAST_LEVEL := 3  # Tiene que estar en 1

var current_level := 0

# Mantiene algunas variables para pasar del nivel a
# endlevel

var store_score = 0

# Resultado del nivel
enum Result {
	NONE,
	WIN,
	LOSE
}
var result = Result.NONE

func reset_store():
	store_score = 0