extends Node3D

class_name Platform

@onready var _timer : Timer = $Timer
@onready var _playerDetector : Area3D = $Area3D
@onready var _animPlayer : AnimationPlayer = $AnimationPlayer

@export var WAIT_TIME : float = 5.0;
@export var WAIT_TIME_VAR : float = 1.5;

signal platform_collide(platformPos : Vector3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_timer.wait_time = WAIT_TIME + randf_range(-WAIT_TIME_VAR,WAIT_TIME_VAR)
	_playerDetector.body_entered.connect(on_body_entered)
	_timer.timeout.connect(on_time_out)
	
func on_body_entered(body : Node3D):
	if body is Player:
		_timer.start()
		platform_collide.emit(global_position)
		_playerDetector.body_entered.disconnect(on_body_entered)
		
func on_time_out():
	_animPlayer.play("vanish")
