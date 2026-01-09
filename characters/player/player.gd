class_name Player extends Character

var display_name: String = "Demo"
var abilities: Array[Ability] = []
var gold: int = 0;
var days: int
var num_dice: int = 3
var max_banked_dice: int = 5

var location # TODO - where on he map are you?

# TODO - outside player?
func day_tick():
	days -= 1
	# TODO tell status bar
	if days == 0:
		print("uh oh she's a-coming")

func change_hp_max(amt):
	hp_max += amt
	hp += amt
	# TODO tell status bar

# can I spend this much
func check_gold(amt) -> bool:
	return (gold - amt) >= 0

# assumes you already checked affordability
func change_gold(amt):
	gold += amt
	# TODO tell status bar

func add_ability(ability: Ability):
	abilities.append(ability)

func remove_ability(ability: Ability):
	var idx = abilities.find(ability)
	abilities.remove_at(idx)

func set_location(_location: Location):
	location = _location
