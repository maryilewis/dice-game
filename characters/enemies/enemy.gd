@abstract
class_name Enemy extends Character

var image_path: String
var display_name: String

@abstract
func take_turn(enemies: Array, player: Player)
