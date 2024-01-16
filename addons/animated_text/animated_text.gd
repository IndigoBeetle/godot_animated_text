tool
class_name IB_Animated_Text
extends Node2D


signal completed


export(bool) var snapshot := false setget _set_snapshot
export(bool) var reset := false setget _set_reset
export(float) var duration : float = 2.0
export(float, 0.0, 1.0) var shift := 0.0
export(bool) var playing : bool = false setget _set_playing
export(bool) var loop : bool = true
export(Array) var initial_state := []
export(Array, NodePath) var effects : Array = [] setget _set_effects
export(int) var current_effect : int setget _set_current_effect


var _time : float = 0.0

var _effects : Array = []
var _current_effect : Node2D 


func _ready() -> void:
	self.effects = effects
	self.current_effect = current_effect


func _process(delta: float) -> void:
	if playing:
		_time += delta
		_update_text_at_time(_time)
		if _time > duration:
			if not loop:
				self.playing = false
				emit_signal("completed")
			else:
				_time = 0.0



func _update_text_at_time(time : float) -> void:
	var character_duration : float = duration
	var character_delay : float = 0.0
	if shift > 0.0:
		character_duration = (duration / ($Characters.get_child_count() + 1)) / shift
		character_delay = (duration - character_duration) / ($Characters.get_child_count())
#	print(character_duration, ", ", character_delay)
	for index in $Characters.get_child_count():
		var letter : Node2D = $Characters.get_child(index) as Node2D
		var t2 := min(max(time - (character_delay * index), 0.0), character_duration) / character_duration
		var t : float = IB_Easing.Sine.easeOut(t2, 0.0, 1.0, 1.0)
#		print(index, ", ", time, ", ", t2, ", ", t)
		if _current_effect:
			for fx in _current_effect.get_children():
				if fx.has_method("apply"):
					fx.apply(t, index, letter, self)


func _set_snapshot(value : bool) -> void:
	if value:
		initial_state = []
		for child in $Characters.get_children():
			initial_state.append({
				"position": child.position,
				"scale": child.scale,
				"modulate.a": modulate.a,
			})


func _set_reset(value : bool) -> void:
	if value:
		for index in $Characters.get_child_count():
			var child : Node2D = $Characters.get_child(index)
			var state : Dictionary = initial_state[index]
			if state:
				child.position = state["position"]
				child.scale = state["scale"]
				child.modulate.a = state["modulate.a"]


func _set_playing(value : bool) -> void:
	var previous := playing
	playing = value
	_time = 0.0
	property_list_changed_notify()
	if playing and not previous and _current_effect:
		for fx in _current_effect.get_children():
			if (fx as Node).has_method("reset"):
				fx.reset()


func _set_effects(value : Array) -> void:
	effects = value
	_effects = []
	for np in effects:
		if np is NodePath and has_node(np):
			_effects.append(get_node(np))


func _set_current_effect(value : int) -> void:
	current_effect = value
	if value >= 0 and value < _effects.size():
		_current_effect = _effects[value]
