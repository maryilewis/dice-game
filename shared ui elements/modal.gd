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


func _ready():
	%Yes.grab_focus()


func _on_no_pressed():
	cancel_pressed.emit()


func _on_yes_pressed():
	ok_pressed.emit()


func _on_visibility_changed():
	if %Yes.is_inside_tree() and visible:
		%Yes.grab_focus()
