class_name RegularEnemy extends Enemy


func _init():
	display_name = "Snakeoil Seller"
	hp = 20
	hp_max = hp
	image_path = "res://images/snakey.png"


func take_turn(_enemies: Array, player: Player):
	player.take_damage(randi_range(2, 5))
