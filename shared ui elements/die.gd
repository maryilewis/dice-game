class_name IndividualDie extends Control

signal pressed
var value

func set_value(val: int):
	%ValueButton.text = str(val)
	value = val


func clear_value():
	%ValueButton.text = ""
	value = null


func _on_button_pressed():
	if value != null:
		pressed.emit()
