class_name AbilityListItem extends Control

@export var ability: Ability:
	set(value):
		ability = value
		%TargetsLabel.text = ability.target_type
		%NameLabel.text = ability.display_name
		%DescriptionLabel.text = ability.description
		if ability.single_use:
			%UsesLabel.text = "Single"
		else:
			%UsesLabel.text = ability.uses_per_turn
	get():
		return ability
