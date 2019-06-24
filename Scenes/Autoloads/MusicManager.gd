extends Node

var current_music

enum Music {
	CRAZY,
	FLY,
	MARCH,
	SOMETHING,
	UNDERGROUND,
	SUNLESS,
	INVASION
}

func play(sound):
	if not Main.MUSIC_ENABLE:
		return
	
	if current_music:
		current_music.stop()
	
	match sound:
		Music.CRAZY:
			current_music = $Crazy
		Music.FLY:
			current_music = $Fly
		Music.MARCH:
			current_music = $Invasion
		Music.SOMETHING:
			current_music = $March
		Music.UNDERGROUND:
			current_music = $Something
		Music.SUNLESS:
			current_music = $Sunless
		Music.INVASION:
			current_music = $Underground
	
	current_music.play()
	
func random_music():
	randomize()
	var rand = int(round(rand_range(0, 6)))
	play(rand)

