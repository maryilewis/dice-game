extends Node

signal selection_made(selection)


func _on_dungeon_1_pressed():
	selection_made.emit("dungeon1")
	
