class_name AbilitySummary extends Control
const DIE = preload("uid://b7tillw5s46vh")

signal die_removed(int)
signal close_requested
var ability: Ability


func set_ability(_ability: Ability):
	ability = _ability
	%NameLabel.text = ability.display_name
	%Modal.body_text = ability.description
	if ability.number_of_dice > 0:
		for i in range(0, ability.number_of_dice):
			var die = DIE.instantiate()
			die.pressed.connect(remove_die.bind(die))
			%DiceContainer.add_child(die)


func add_die(value: int) -> bool:
	# see if the die value is compatible with the ability
	var values = get_die_values()
	values.append(value)
	var ok = ability.check_dice_partial(values)
	print("ok? ", ok)
	if ok:
		# see if there is room for this die
		for die: IndividualDie in %DiceContainer.get_children():
			if die.value == null:
				die.set_value(value)
				return true
	return false


func remove_die(die: IndividualDie):
	if die.value != null:
		var val = die.value
		die.clear_value()
		die_removed.emit(val)


func get_die_values():
	var values = []
	for die: IndividualDie in %DiceContainer.get_children():
		if die.value != null:
			values.append(die.value)
	return values


func _on_cancel_button_pressed():
	close_requested.emit()
