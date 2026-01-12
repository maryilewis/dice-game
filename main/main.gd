extends Control

const DUNGEON_VISUAL = preload("uid://cqelnplfpmwub")
const EnemySnakey = preload("uid://blj8h2c3quyhk")


var player: Player
@onready var status_bar: StatusBar = %StatusBar

func _ready():
	player = Player.new()
	# DaggerAbility.new(), 
	var abilities = [BasicDamageAbility.new(), MatchDamageAbility.new(), BlockAbility.new(), DynamiteAbility.new()]
	for a in abilities:
		player.add_ability(a)
	# link player and status bar
	player.gold_changed.connect(status_bar.set_gold)
	player.hp_changed.connect(status_bar.set_hp)
	player.max_hp_changed.connect(status_bar.set_max_hp)
	player.set_hp_max(20)
	player.set_hp(20)
	
	
	# TODO: Remove. here for testing purposes.
	_on_instructions_modal_ok_pressed()
	_on_map_selection_made("anything")


func _on_instructions_modal_ok_pressed():
	%InstructionsModal.hide()
	%Map.show()


func _on_map_selection_made(_selection):
	for child in %Location.get_children():
		child.queue_free()
	var dungeon = Dungeon.new()
	var enemy = SnakeyEnemy.new()
	var enemy_array: Array[Enemy] = []
	enemy_array.append(enemy)
	dungeon.enemies = enemy_array
	var dungeon_visual: DungeonVisual = DUNGEON_VISUAL.instantiate()
	dungeon_visual.dungeon = dungeon
	dungeon_visual.player = player
	dungeon_visual.dungeon_complete.connect(_return_to_map.bind(dungeon_visual))
	%Location.add_child(dungeon_visual)
	%Map.hide()
	%Location.show()

func _return_to_map(victorious: bool, dungeon: DungeonVisual):
	%Map.show()
	%Location.hide()
	dungeon.queue_free()
	if !victorious:
		pass
		# TODO: go to the inn, lose some money
	
	
	
