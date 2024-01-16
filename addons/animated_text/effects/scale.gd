tool
extends Node


export(bool) var enabled : bool = true
export(Curve) var scale_curve : Curve


func _ready() -> void:
	pass


func apply(time : float, _index : int, letter : Node2D, _at : IB_Animated_Text) -> void:
	if not enabled:
		return
	var value : float = scale_curve.interpolate(time)
	letter.scale = Vector2(value, value)
