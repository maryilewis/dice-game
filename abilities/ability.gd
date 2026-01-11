## Represents an instance of an ability
@abstract
class_name Ability extends Node

enum TargetType { PLAYER, ENEMY, ALL_ENEMIES, EVERYONE }

signal remove_permanently
signal out_of_uses

# who is in the current fight
@export var player: Player
@export var enemies: Array

var display_name: String = "Ability Name"
var description: String = "How to use Ability"
var uses_per_turn: int = 1 # 0 for infinite
var uses_left: int = 1
var number_of_dice: int = 1 # if an ability has infinite uses, it cannot have 0 cost
var single_use: bool = false
var target_type: TargetType = TargetType.ENEMY
var targets: Array = []


## Array of ints
@abstract
func check_dice(dice_values: Array) -> bool


func check_dice_partial(_dice_values: Array) -> bool:
	return true


func needs_target():
	return target_type == TargetType.ENEMY and len(targets) == 0;


func set_target(enemy: Enemy):
	targets = [enemy]


## Array of ints
func execute(dice_values: Array):
	print(targets)
	if target_type == TargetType.PLAYER:
		targets = [player]
	elif target_type == TargetType.ALL_ENEMIES:
		targets = enemies
	elif target_type == TargetType.EVERYONE:
		targets = []
		for e in enemies:
			targets.append(e)
		targets.append(player)
	_execute_on_targets(targets, dice_values)
	targets = []
	if single_use:
		remove_permanently.emit()
	else:
		uses_left -= 1
	if uses_left == 0:
		out_of_uses.emit()


func turn_reset():
	uses_left = uses_per_turn


# _targets is an array of Characters (enemy or player)
@abstract
func _execute_on_targets(_targets: Array, dice_values: Array)
