class_name EnemyVisual extends Node2D

var enemy: Enemy:
	set(value):
		enemy = value
		%Name.text = enemy.display_name
		%HP.text = str(enemy.hp) + "/" + str(enemy.hp_max)
		$Sprite2D.texture = load(enemy.image_path)
	get():
		return enemy
