extends Node

signal move_left(pressed)
signal move_right(pressed)

var left_touched = false
var right_touched = false

func _on_Left_pressed():
	left_touched = true
	emit_signal("move_left", left_touched)
	
func _on_Left_released():
	left_touched = false
	emit_signal("move_left", left_touched)

func _on_Right_pressed():
	right_touched = true
	emit_signal("move_right", right_touched)

func _on_Right_released():
	right_touched = false
	emit_signal("move_right", right_touched)