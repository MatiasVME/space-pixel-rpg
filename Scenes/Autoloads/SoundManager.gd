extends Node

enum Sound {
	BUTTON1,
	DEATH_SCREAM1,
	DEATH_SCREAM2,
	DEATH_SCREAM3,
	DEATH_SCREAM4,
	LASER1,
	LASER2,
	LEVEL_UP1,
	PLAYER_DAMAGE1,
	PLAYER_DEATH1,
	WIN1,
	LOSE1
}

func play(sound):
	if not Main.SOUND_ENABLE:
		return
	
	match sound:
		Sound.BUTTON1:
			$Button1.play()
		Sound.DEATH_SCREAM1:
			$DeathScream1.play()
		Sound.DEATH_SCREAM2:
			$DeathScream2.play()
		Sound.DEATH_SCREAM3:
			$DeathScream3.play()
		Sound.DEATH_SCREAM4:
			$DeathScream4.play()
		Sound.LASER1:
			$Laser1.play()
		Sound.LASER2:
			$Laser2.play()
		Sound.LEVEL_UP1:
			$LevelUP1.play()
		Sound.PLAYER_DAMAGE1:
			$PlayerDamage1.play()
		Sound.PLAYER_DEATH1:
			$PlayerDeath1.play()
		Sound.WIN1:
			$Win1.play()
		Sound.LOSE1:
			$Lose1.play()