class_name AbilityListItem extends Control

signal pressed

const ROLLING_DICES = preload("uid://6btq7grfxhtv")
const CROSSHAIR = preload("uid://k2x6ff2w27ab")
const BULLET_IMPACTS = preload("uid://ydwpp1pdlt8q")
const BARREL = preload("uid://bj7djaqr7eb6n")
const LASER_SPARKS = preload("uid://luk5sv7xwq7d")


@export var ability: Ability:
	set(value):
		ability = value
		%TargetsLabel.text = str(Ability.TargetType.keys()[ability.target_type])
		match ability.target_type:
			Ability.TargetType.DICE:
				%TargetsIcon.texture = ROLLING_DICES
			Ability.TargetType.PLAYER:
				%TargetsIcon.texture = BARREL
			Ability.TargetType.ENEMY:
				%TargetsIcon.texture = CROSSHAIR
			Ability.TargetType.ALL_ENEMIES:
				%TargetsIcon.texture = BULLET_IMPACTS
			Ability.TargetType.EVERYONE:
				%TargetsIcon.texture = LASER_SPARKS
		%NameLabel.text = ability.display_name
		%DescriptionLabel.text = ability.description
		if ability.single_use:
			%UsesLabel.text = "Single"
		else:
			%UsesLabel.text = str(ability.uses_left) + "/" + str(ability.uses_per_turn)
	get():
		return ability


func _used_up():
	print("this ability should look disabled now")


func _restored():
	print("this ability is all better now")


func _on_button_pressed():
	pressed.emit()
