extends Node3D

var has_arrived := false
var _moving := false

@onready var _animation: AnimationPlayer = $AnimationPlayer
@onready var _area: InteractiveArea3D = $Platform/InteractiveArea3D

func _ready() -> void:
	_area.interacted.connect(_on_interacted)
	_animation.play("RESET")


func _on_interacted() -> void:
	if _moving:
		return
	_area.visible = false
	_animation.play("back" if has_arrived else "move")
	await _animation.animation_finished
	has_arrived = not has_arrived
	_area.visible = true
	_moving = false
