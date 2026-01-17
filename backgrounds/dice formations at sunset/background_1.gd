class_name Background1 extends Node2D
# The 1 and only, probably

var cloud_speed = 5

func _ready():
	pass

func _process(delta):
	var offset_x = $Parallax2D2/Clouds.offset.x + (delta * cloud_speed)
	if offset_x > 1232:
		offset_x = 0
	$Parallax2D2/Clouds.offset.x = offset_x
	$"Parallax2D4/Cloud Shadows".offset.x = offset_x
	
	pass
