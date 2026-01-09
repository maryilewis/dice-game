class_name RegularEnemy extends Enemy


func take_turn(_enemies: Array, player: Player):
	player.take_damage(randi_range(2, 5))
