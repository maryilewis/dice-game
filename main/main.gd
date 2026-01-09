extends Control

const DUNGEON_VISUAL = preload("uid://cqelnplfpmwub")

var player: Player


func _ready():
	player = Player.new()
	player.abilities = [ShortswordAbility.new(), DaggerAbility.new(), FlurryOfBlowsAbility.new()]


# TODO link player and status bar


func _on_instructions_modal_ok_pressed():
	%InstructionsModal.hide()
	%Map.show()


func _on_map_selection_made(_selection):
	for child in %Location.get_children():
		child.queue_free()
	var dungeon = Dungeon.new()
	var enemy = RegularEnemy.new()
	var enemy_array: Array[Enemy] = []
	enemy_array.append(enemy)
	dungeon.enemies = enemy_array
	var dungeon_visual: DungeonVisual = DUNGEON_VISUAL.instantiate()
	dungeon_visual.dungeon = dungeon
	dungeon_visual.player = player
	%Location.add_child(dungeon_visual)
	%Map.hide()
	%Location.show()
