class_name BasicDamageAbility extends Ability

var modifier: int = 1

func _init():
	display_name = "Called Shot"
	description = "Cost: 1 die. Does x + " + str(modifier) + " damage."
	uses_per_turn = 1 # 0 for infinite
	number_of_dice = 1 # if an ability has infinite uses, it cannot have 0 cost
	target_type = TargetType.ENEMY


func check_dice(dice_values: Array) -> bool:
	if len(dice_values) == number_of_dice:
		return true
	return false


func _execute_on_targets(_targets: Array, dice_values: Array):
	var damage = 0
	for die in dice_values:
		damage += die
	for target in targets:
		target.take_damage(damage + modifier)
		
