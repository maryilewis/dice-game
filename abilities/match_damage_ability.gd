class_name MatchDamageAbility extends Ability

func _init():
	display_name = "Bullet Time"
	description = "Cost: 3 of a kind.  Does total damage to all enemies."
	uses_per_turn = 1 # 0 for infinite
	number_of_dice = 3 # if an ability has infinite uses, it cannot have 0 cost
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


func _execute_on_targets(_targets: Array, dice_values: Array):
	var damage = 0
	for die in dice_values:
		damage += die
	for target in targets:
		target.take_damage(damage)
		
