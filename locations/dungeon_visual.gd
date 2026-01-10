class_name DungeonVisual extends Node

const DIE = preload("uid://b7tillw5s46vh")
const ABILITY_SUMMARY = preload("uid://c4y33hfvqujok")
const ABILITY_LIST_ITEM = preload("uid://bv2jb61ljkhrv")

@export var player: Player
@export var dungeon: Dungeon
var dice: Array[int] = []
var visible_ability_summary: AbilitySummary


func _ready():
	_list_abilities()
	_on_turn_start()


func _list_abilities():
	for ability in player.abilities:
		ability.turn_reset()
		var ability_button = ABILITY_LIST_ITEM.instantiate()
		ability_button.ability = ability
		ability_button.pressed.connect(_select_ability.bind(ability))
		%AbilityButtons.add_child(ability_button)


func _select_ability(ability: Ability):
	if visible_ability_summary != null:
		_close_ability_summary()
		if visible_ability_summary.ability == ability:
			return

	visible_ability_summary = ABILITY_SUMMARY.instantiate()
	add_child(visible_ability_summary)
	visible_ability_summary.set_ability(ability)
	visible_ability_summary.die_removed.connect(_on_die_returned)
	visible_ability_summary.close_requested.connect(_close_ability_summary)


func _close_ability_summary():
	print(_close_ability_summary)
	if visible_ability_summary != null:
		for value in visible_ability_summary.get_die_values():
			_on_die_returned(value)
		visible_ability_summary.queue_free()


func _on_end_turn_button_pressed():
	_close_ability_summary()
	%EndTurnButton.disabled = true
	for enemy in dungeon.enemies:
		enemy.take_turn(dungeon.enemies, player)
	%EndTurnButton.disabled = false
	_on_turn_start()


func _on_turn_start():
	var num_to_roll = min(player.num_dice, player.max_banked_dice - len(dice))
	for i in range(0, num_to_roll):
		dice.append(randi_range(1, 6))
	for child in %DiceContainer.get_children():
		child.queue_free()
	for num in dice:
		var die: IndividualDie = DIE.instantiate()
		die.set_value(num)
		%DiceContainer.add_child(die)
		die.pressed.connect(_on_die_clicked.bind(die))


func _on_die_returned(value: int):
	print("returning", value)
	for child: IndividualDie in %DiceContainer.get_children():
		if child.value == null:
			child.set_value(value)
			return


func _on_die_clicked(die: IndividualDie):
	if visible_ability_summary != null:
		var sent = visible_ability_summary.add_die(die.value)
		if sent:
			die.clear_value()
