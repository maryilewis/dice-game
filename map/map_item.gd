@tool
class_name MapItem extends Button


@export var display_text: String:
	set(value):
		display_text = value
		%Label.text = value


@export var texture: Texture2D:
	set(value):
		texture = value
		%TextureRect.texture = texture


@export var current: bool:
	set(value):
		current = value
		%CurrentIndicator.visible = value
