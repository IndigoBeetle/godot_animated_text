tool
extends Node


export(bool) var enabled : bool = true
export(Gradient) var gradient : Gradient


func _ready() -> void:
	pass


func apply(time : float, _index : int, letter : Node2D, _at : IB_Animated_Text) -> void:
	if not enabled:
		return
	if gradient != null:
		letter.modulate = gradient.interpolate(time)
	else:
		letter.modulate.a = time
