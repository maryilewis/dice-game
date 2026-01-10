class_name DynamiteAbility extends Ability

var modifier: int = 1

func _init():
	display_name = "Dynamite"
	description = "Cost: any dice. Does n² damage (number of dice squared) to everyone, including player"
	uses_per_turn = 1 # 0 for infinite
	number_of_dice = 5 # TODO: how to have unlimited dice?
	single_use = true
	target_type = TargetType.EVERYONE


func check_dice(_dice_values: Array) -> bool:
	return true


func _execute_on_targets(_targets: Array, dice_values: Array):
	for target in targets:
		target.take_damage(pow(len(dice_values), 2))
