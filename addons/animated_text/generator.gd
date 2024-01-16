tool
extends Node2D


export(bool) var regen : bool setget _set_regen
export(String) var text : String setget _set_text
export(NodePath) var character_container : NodePath
export(Font) var font : Font setget _set_font


var _character_container : Node2D
var _letter_prefab := preload("res://addons/animated_text/animated_text_letter.tscn")


func _ready() -> void:
	if has_node(character_container):
		_character_container = get_node(character_container)


func _set_regen(value : bool) -> void:
	if value:
		_regen_characters()


func _set_text(value : String) -> void:
	text = value
	_regen_characters()


func _set_font(value : Font) -> void:
	font = value
	_regen_characters()


func _regen_characters() -> void:
	var cont := _character_container
	if Engine.editor_hint:
		cont = get_node(character_container)
	if cont and _letter_prefab:
		for c in cont.get_children():
			c.queue_free()
		var x : float = 0.0
		for index in text.length():
			var l := text[index]
			var letter : Node2D = _letter_prefab.instance()
			cont.add_child(letter)
			if Engine.editor_hint:
				letter.owner = get_tree().edited_scene_root
			letter.letter = l
			letter.position = Vector2(x + letter.size.x / 2.0, 0.0)
			letter.font = font
			x += letter.size.x
