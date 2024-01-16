tool
extends Node


export(bool) var enabled : bool = true
export(NodePath) var path_node : NodePath


var _path : Path2D


func _ready() -> void:
	if has_node(path_node) and get_node(path_node) is Path2D:
		_path = get_node(path_node)


func apply(time : float, index : int, letter : Node2D, at : IB_Animated_Text) -> void:
	if not enabled:
		return
	if Engine.editor_hint:
		if has_node(path_node) and get_node(path_node) is Path2D:
			_path = get_node(path_node)
	if _path != null:
		var available_length := _path.curve.get_baked_length()
		var distance : float = available_length * time
		letter.position = at.initial_state[index]["position"]
		var position : Vector2 = letter.get_parent().to_local(_path.to_global(_path.curve.interpolate_baked(distance)))
		letter.position += position
