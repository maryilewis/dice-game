class_name CharacterVisual extends Node

signal pressed

var character: Character:
	set(value):
		character = value
		%Name.text = character.display_name
		%HP.text = str(character.hp) + "/" + str(character.hp_max)
		%Sprite2D.texture = load(character.image_path)
		_init_progress_bar()
		character.hp_changed.connect(_update_hp)
		character.voice_lined.connect(voice_line)
		# add signals for character attack, take damage, block, armor, heal,
		# and then hook all that up to visualizations
	get():
		return character

var selectable: bool = false:
	set(value):
		selectable = value
		


func _init_progress_bar():
	%ProgressBar.custom_minimum_size.x = character.hp_max * 5
	%ProgressBar.min_value = 0
	%ProgressBar.max_value = character.hp_max
	%ProgressBar.value = character.hp_max


func _on_button_pressed():
	pressed.emit()


func _update_hp(_amt):
	%HP.text = str(character.hp) + "/" + str(character.hp_max)
	%ProgressBar.value = character.hp


func voice_line(line: String):
	%Speech.text = line
	%Speech.show()
	# TODO set timer to hide
	
