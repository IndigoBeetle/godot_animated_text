tool
extends Node


export(bool) var enabled : bool = true
export(bool) var once : bool = true


var _done : bool = false


func _ready() -> void:
	_done = false


func apply(time : float, index : int, letter : Node2D, at : IB_Animated_Text) -> void:
	if not enabled:
		return
	if not once or not _done:
		_do_it(time, index, letter, at)
		_done = true


func reset() -> void:
	_done = false


func _do_it(_time : float, _index : int, _letter : Node2D, _at : IB_Animated_Text) -> void:
	pass
