extends Node2D

func _on_DeleteButton_pressed():
	SoundManager.play(SoundManager.Sound.BUTTON1)
	$AreYouSure.visible = true
	
func _on_AreYouSure_confirmed():
	DataManager.remove_all_data()
	get_tree().quit()
