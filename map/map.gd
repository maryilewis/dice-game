extends Node

signal selection_made(selection)


func reset_current():
	for button in $Buttons.get_children():
		if button.has_property("current"):
			button.current  = false


func _on_dungeon_1_pressed():
	selection_made.emit("dungeon1")


func _on_saloon_pressed():
	pass # Replace with function body.
