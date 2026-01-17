class_name Background1 extends Node2D
# The 1 and only, probably

var cloud_speed = 5

func _ready():
	pass

func _process(delta):
	#$Parallax2D/Clouds.offset.x -= delta * cloud_speed
	#$"Parallax2D/Cloud Shadows".offset.x -= delta * cloud_speed
	pass
