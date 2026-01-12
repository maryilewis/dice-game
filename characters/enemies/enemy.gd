@abstract
class_name Enemy extends Character

signal voice_lined(String)

var image_path: String
var display_name: String


@abstract
func take_turn(enemies: Array, player: Player)

func voice_line(line: String):
	voice_lined.emit(line)
