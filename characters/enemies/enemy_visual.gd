class_name EnemyVisual extends Node2D

signal pressed

var enemy: Enemy:
	set(value):
		enemy = value
		%Name.text = enemy.display_name
		%HP.text = str(enemy.hp) + "/" + str(enemy.hp_max)
		$Sprite2D.texture = load(enemy.image_path)
		enemy.hp_changed.connect(_update_hp)
	get():
		return enemy


func _on_button_pressed():
	pressed.emit()

func _update_hp(_amt):
	%HP.text = str(enemy.hp) + "/" + str(enemy.hp_max)
