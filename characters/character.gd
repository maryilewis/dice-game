class_name Character extends Node

var hp: int = 20
var hp_max: int = 20
var armor: int = 0


func take_damage(amt: int, ignore_armor: bool = false):
	if amt == 0:
		return
	if not ignore_armor:
		amt -= armor
	hp -= amt
	if hp <= 0:
		print("u died bro")


# Generic change HP by this amount function
func change_hp(amt):
	hp += amt
	if hp > hp_max:
		hp = hp_max
	if hp <= 0:
		print("u died bro")
	# TODO tell status bar when hp changes
