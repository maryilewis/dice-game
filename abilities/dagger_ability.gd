class_name DaggerAbility extends Ability

func _init():
	display_name = "Punch"
	description = "Cost: 1 die. Always does 1 damage."
	uses_per_turn = 0 # 0 for infinite
	number_of_dice = 1 # if an ability has infinite uses, it cannot have 0 cost
	target_type = TargetType.ENEMY


func check_dice(dice_values: Array) -> bool:
	if len(dice_values) == number_of_dice:
		return true
	return false


func _execute_on_targets(_targets: Array, dice: Array):
	for target: Character in targets:
		target.take_damage(1)
	for die in dice:
		die.consumed = true
