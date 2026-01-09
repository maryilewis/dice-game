@tool
class_name Modal extends PanelContainer

signal cancel_pressed
signal ok_pressed


@export_multiline var body_text: String:
	set(value):
		body_text = value
		%BodyLabel.text = value
	get:
		return body_text


@export var confirmation_text: String:
	set(value):
		confirmation_text = value
		%ConfirmLabel.text = value
	get:
		return confirmation_text


func _on_no_pressed():
	cancel_pressed.emit()


func _on_yes_pressed():
	ok_pressed.emit()
