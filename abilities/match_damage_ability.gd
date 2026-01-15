class_name MatchDamageAbility extends Ability

func _init():
	display_name = "Bullet Time"
	description = "■ ■ (matching.)  Does 6 damage to all enemies."
	uses_per_turn = 1 # 0 for infinite
	number_of_dice = 2 # if an ability has infinite uses, it cannot have 0 cost
	target_type = TargetType.ALL_ENEMIES


func check_dice_partial(dice_values: Array) -> bool:
	return _all_match(dice_values)


func check_dice(dice_values: Array) -> bool:
	if len(dice_values) == number_of_dice and _all_match(dice_values):
		return true
	return false


# move to Ability if useful for other abilities
func _all_match(dice_values: Array) -> bool:
	if len(dice_values) == 0:
		return true # They don't not match, I guess?
	var test_value = dice_values[0]
	for d in dice_values:
		if d != test_value:
			return false
	return true

# TODO: sending targets is redundant? we set that globally?
func _execute_on_targets(_targets: Array, dice: Array[IndividualDie]):
	print(targets)
	print(_targets)
	for target in targets:
		target.take_damage(6)
	for die in dice:
		die.consumed = true
