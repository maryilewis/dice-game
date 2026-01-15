class_name BlockAbility extends Ability

var modifier: int = 1

func _init():
	display_name = "Take Cover"
	description = "■ Avoid x + " + str(modifier) + " damage next turn."
	uses_per_turn = 1 # 0 for infinite
	number_of_dice = 1 # if an ability has infinite uses, it cannot have 0 cost
	target_type = TargetType.PLAYER


func check_dice(dice_values: Array) -> bool:
	if len(dice_values) == number_of_dice:
		return true
	return false


func _execute_on_targets(_targets: Array, dice: Array[IndividualDie]):
	var dice_values = dice.map(func(i: IndividualDie): return i.value)
	var block = modifier
	for val in dice_values:
		block += val
	for target in targets:
		target.gain_block(block)
	for die in dice:
		die.consumed = true
