class_name SnakeyEnemy extends Enemy

func _init():
	display_name = "Snakeoil Seller"
	hp = 20
	hp_max = hp
	image_path = "res://images/snakey.png"


func take_turn(_enemies: Array, player: Player, dice: Array[IndividualDie]):
	if !stunned:
		var damage = randi_range(2, 5)
		player.take_damage(damage)
		attacked.emit(damage)
		var room = player.max_banked_dice - len(dice)
		if room > 1:
			pass
			#var new_die = IndividualDie.new()
			#new_die.set_value(1)
			#dice.append(new_die)
			# Do that twice, and then send it back to the dungeon visual T_T how? Make dice_list its own thing that cna  be passed around
	stunned = false

# TODO: how to communicate dice changes to dungeon_visual?
