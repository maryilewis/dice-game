class_name DungeonVisual extends Node

const DIE = preload("uid://b7tillw5s46vh")
const ABILITY_SUMMARY = preload("uid://c4y33hfvqujok")

@export var player: Player
@export var dungeon: Dungeon
var dice: Array[int] = []


func _ready():
	_list_abilities()
	_on_turn_start()


func _list_abilities():
	print(player.abilities)
	for ability in player.abilities:
		var button = Button.new()
		button.text = ability.display_name
		button.pressed.connect(_select_ability.bind(ability))
		%AbilityButtons.add_child(button)


func _select_ability(ability: Ability):
	var ability_summary = ABILITY_SUMMARY.instantiate()
	add_child(ability_summary)
	ability_summary.set_ability(ability)


func _on_end_turn_button_pressed():
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


func _on_die_clicked(die: IndividualDie):
	print(die.value)
