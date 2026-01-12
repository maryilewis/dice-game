class_name RerollAbility extends Ability

var modifier: int = 1

func _init():
	display_name = "Lucky Bullet"
	description = "Re-roll 1 die."
	uses_per_turn = 1 # 0 for infinite
	number_of_dice = 1 # if an ability has infinite uses, it cannot have 0 cost
	target_type = TargetType.DICE


func check_dice(dice_values: Array) -> bool:
	if len(dice_values) == number_of_dice:
		return true
	return false


func _execute_on_targets(_targets: Array, dice: Array[IndividualDie]):
	for die in dice:
		die.roll()
	for die in dice:
		die.consumed = false
		
