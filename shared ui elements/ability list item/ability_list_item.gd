class_name AbilityListItem extends Control

signal pressed

@export var ability: Ability:
	set(value):
		ability = value
		%TargetsLabel.text = str(Ability.TargetType.keys()[ability.target_type])
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
