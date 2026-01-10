class_name StatusBar extends Control

var hp: int
var hp_max: int
var gold: int
var days: int

# call from player, player is in change of amounts
func set_hp(amt):
	hp = amt
	%HP.text = str(hp) + "/" + str(hp_max)

func set_max_hp(amt):
	hp_max = amt

func set_gold(amt):
	gold = amt
	%Gold.text = "Gold: " + str(gold)

func set_days(_days):
	days = _days
	%Days.text = str(days) + " Days left"
