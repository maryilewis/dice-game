class_name Character extends Node

signal hp_changed(int)
signal died
signal voice_lined(String)
signal attacked(int)
signal armored(int)
signal blocked(int)
signal took_damage(int)
signal healed(int)

var image_path: String
var display_name: String

var hp: int = 20
var hp_max: int = 20
var armor: int = 0
var block: int = 0
var stunned = false
var dead = false


func turn_reset():
	block = 0


func take_damage(amt: int, ignore_armor: bool = false):
	if amt == 0:
		return
	if not ignore_armor and armor > 0:
		amt -= armor
		print("armor reduced damage by " + str(armor))
	if block > 0:
		var amt_before_block = amt
		amt -= block
		print("blocked " + str(block))
		blocked.emit(min(block, amt_before_block))
		block -= amt_before_block
		block = max(block, 0)
	if amt <= 0:
		return
	took_damage.emit(amt)
	change_hp_by_amt(-amt)


# Generic change HP by this amount function
func change_hp_by_amt(amt):
	hp += amt
	if hp > hp_max:
		hp = hp_max
	if hp <= 0:
		dead = true
		died.emit()
	hp_changed.emit(hp)


func set_hp(amt):
	hp = amt
	hp_changed.emit(hp)


func gain_block(amt):
	block += amt


func set_armor(amt):
	armor = amt


func gain_armor(amt):
	armor += amt


func stun():
	stunned = true


func voice_line(line: String):
	voice_lined.emit(line)
