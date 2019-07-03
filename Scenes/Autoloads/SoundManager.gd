extends Node

enum Sound {
	BUTTON1,
	DEATH_SCREAM1,
	DEATH_SCREAM2,
	DEATH_SCREAM3,
	DEATH_SCREAM4,
	DEATH_SCREAM5,
	DEATH_SCREAM6,
	LASER1,
	LASER2,
	LEVEL_UP1,
	PLAYER_DAMAGE1,
	PLAYER_DEATH1,
	BOX_DEATH1,
	SPACESHIP_FLY_MENU1,
	SPACESHIP_FLY_MENU2,
	READY1,
	YOU_WIN1,
	YOU_LOSE1,
	BULLET_EXPLOSION1,
	HIT1,
	HIT2,
	HIT3,
	HIT4
}

func _ready():
	randomize()

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
		Sound.DEATH_SCREAM5:
			$DeathScream5.play()
		Sound.DEATH_SCREAM6:
			$DeathScream6.play()
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
		Sound.BOX_DEATH1:
			$BoxDeath1.play()
		Sound.SPACESHIP_FLY_MENU1:
			$SpaceshipFlyMenu1.play()
		Sound.SPACESHIP_FLY_MENU2:
			$SpaceshipFlyMenu2.play()
		Sound.READY1:
			$Ready1.play()
		Sound.YOU_WIN1:
			$YouWin1.play()
		Sound.YOU_LOSE1:
			$YouLose1.play()
		Sound.BULLET_EXPLOSION1:
			$BulletExplosion1.play()
		Sound.HIT1:
			$Hit1.play()
		Sound.HIT2:
			$Hit2.play()
		Sound.HIT3:
			$Hit3.play()
		Sound.HIT4:
			$Hit4.play()

func play_rand_hit():
	var rand_num = int(round(rand_range(Sound.HIT1, Sound.HIT2)))
	play(rand_num)