tool
extends "res://addons/animated_text/effects/function.gd"


export(NodePath) var particles : NodePath



func _do_it(_time : float, _index : int, _letter : Node2D, _at : IB_Animated_Text) -> void:
	if has_node(particles):
		var p : CPUParticles2D = get_node(particles)
		if p:
			p.emitting = true
