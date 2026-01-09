extends PanelContainer
const DIE = preload("uid://b7tillw5s46vh")

func set_ability(ability: Ability):
	%NameLabel.text = ability.display_name
	%DescriptionLabel.text = ability.description
	if ability.number_of_dice > 0:
		for i in range(0, ability.number_of_dice):
			var die = DIE.instantiate()
			%DiceContainer.add_child(die)

func _on_cancel_button_pressed():
	# TODO put back any dice that were used
	queue_free()
