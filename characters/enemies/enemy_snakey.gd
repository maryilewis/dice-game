class_name SnakeyEnemy extends Enemy

func _init():
	display_name = "Snakeoil Seller"
	hp = 20
	hp_max = hp
	image_path = "res://images/snakey.png"


func take_turn(_enemies: Array, player: Player):
	if !stunned:
		player.take_damage(randi_range(2, 5))
	stunned = false

# TODO: how to communicate dice changes to dungeon_visual?
