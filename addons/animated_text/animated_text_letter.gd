tool
extends Node2D


export(String) var letter : String = "" setget _set_letter
export(Font) var font : Font setget _set_font


var size : Vector2


func _ready() -> void:
	pass


func _set_letter(value : String) -> void:
	letter = value
	if has_node("Label"):
		var label := get_node("Label")
		if value.length() > 0:
			label.text = value[0]
		else:
			label.text = ""
		_update_size()


func _set_font(value : Font) -> void:
	font = value
	if has_node("Label"):
		var label := get_node("Label")
		label.add_font_override("font", value)


func _update_size() -> void:
	if font != null and letter.length() > 0:
		var code := letter.ord_at(0)
		size = font.get_char_size(code)
		if has_node("Label"):
			var label := get_node("Label")
			label.rect_position = -(size / 2.0)
