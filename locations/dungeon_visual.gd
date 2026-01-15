class_name DungeonVisual extends Node

const DIE = preload("uid://b7tillw5s46vh")
const ABILITY_SUMMARY = preload("uid://c4y33hfvqujok")
const ABILITY_LIST_ITEM = preload("uid://bv2jb61ljkhrv")
const ENEMY_VISUAL = preload("uid://br8030cxjs20k")

# true if you win, false if you lose
signal dungeon_complete(bool)


@export var player: Player
@export var dungeon: Dungeon
var visible_ability_summary: AbilitySummary
var selecting_targets: bool = false:
	set(value):
		selecting_targets = value
		%ChooseTargetLabel.visible = value
	get():
		return selecting_targets


func _ready():
	_show_enemies()
	_list_abilities()
	_on_turn_start()


func _show_enemies():
	var enemy_index = 0
	for enemy in dungeon.enemies:
		var vis = ENEMY_VISUAL.instantiate()
		vis.character = enemy as Character
		%EnemySpots.get_child(enemy_index).add_child(vis)
		enemy_index += 1
		vis.pressed.connect(_select_target.bind(vis))
		enemy.died.connect(_on_enemy_died.bind(enemy, vis))


func _list_abilities():
	for ability in player.abilities:
		ability.turn_reset()
		ability.enemies = dungeon.enemies
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
	visible_ability_summary.ability_activated.connect(_activate_ability)


func _activate_ability():
	if visible_ability_summary == null:
		return
	if visible_ability_summary.ability.target_type != Ability.TargetType.ENEMY:
		_complete_ability()
	else:
		selecting_targets = true
		visible_ability_summary.hide()
		%AbilityButtons.hide()


func _select_target(vis: CharacterVisual):
	if !selecting_targets:
		return
	visible_ability_summary.ability.set_target(vis.character)
	_complete_ability()
	selecting_targets = false


func _complete_ability():
	%AbilityButtons.show()
	if visible_ability_summary == null:
		return
	var ability_dice := visible_ability_summary.get_dice()
	visible_ability_summary.ability.execute(ability_dice)
	visible_ability_summary.queue_free()
	# give dice back if needed (dice ability)
	for die in ability_dice:
		if !die.consumed:
			_on_die_returned(die.value)
	# TODO update corresponding list item to reflect that an ability has been used


# Cancel - close abilty without executing
func _close_ability_summary():
	%AbilityButtons.show()
	selecting_targets = false
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
	# Reset player abilities
	for a in player.abilities:
		a.turn_reset()
	# roll new dice
	var dice_values = []
	
	# tracked banked dice and clear visuals
	for child: IndividualDie in %DiceContainer.get_children():
		if child.value != null and not child.consumed:
			dice_values.append(child.value)
		child.queue_free()

	var num_to_roll = min(player.num_dice, player.max_banked_dice - len(dice_values))
	
	# roll additional dice
	for i in range(0, num_to_roll):
		dice_values.append(randi_range(1, 6))
	
	# recreate visuals
	for num in dice_values:
		var die: IndividualDie = DIE.instantiate()
		die.set_value(num)
		%DiceContainer.add_child(die)
		die.pressed.connect(_on_die_clicked.bind(die))
	# show empty slots
	if len(dice_values) < player.max_banked_dice:
		for i in range (len(dice_values), player.max_banked_dice):
			var die: IndividualDie = DIE.instantiate()
			%DiceContainer.add_child(die)
			die.pressed.connect(_on_die_clicked.bind(die))


func _on_die_returned(value: int):
	for child: IndividualDie in %DiceContainer.get_children():
		if child.value == null:
			child.set_value(value)
			return


func _on_die_clicked(die: IndividualDie):
	if visible_ability_summary != null:
		var sent = visible_ability_summary.add_die(die)
		if sent:
			die.clear_value()


func _on_enemy_died(enemy: Enemy, vis: CharacterVisual):
	print("rip " +str(enemy.display_name))
	var idx := dungeon.enemies.find(enemy)
	dungeon.enemies.remove_at(idx)
	vis.queue_free()
	enemy.queue_free()
	
	if len(dungeon.enemies) == 0:
		on_fight_won()


func on_fight_won():
	# TODO spoils
	%WinModal.show()


func _on_player_died():
	print("rip Johnny Showdown")
	%LoseModal.show()


func _on_win_modal_ok_pressed():
	dungeon_complete.emit(true)


func _on_lose_modal_ok_pressed():
	dungeon_complete.emit(false)
