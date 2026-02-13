extends CharacterBody3D

class_name Player

@export var _jumpPower : float = 9.8;
@export var _moveSpeed : float = 10;

@onready var _animationPlayer : AnimationPlayer = $AnimationPlayer

var GRAVITY : float = ProjectSettings.get("physics/3d/default_gravity")

func _JumpFallVelocityProcess(delta : float):
	if is_on_floor():
		velocity.y = _jumpPower
	else:
		velocity.y -= GRAVITY * delta

func _Move():
	var moveVector : Vector2 = Vector2.ZERO;
	if Input.is_action_pressed("move_up"): moveVector += Vector2.UP
	if Input.is_action_pressed("move_down"): moveVector += Vector2.DOWN
	if Input.is_action_pressed("move_left"): moveVector += Vector2.LEFT
	if Input.is_action_pressed("move_right"): moveVector += Vector2.RIGHT

	moveVector *= _moveSpeed

	velocity.x = moveVector.x
	velocity.z = moveVector.y

func _physics_process(delta: float) -> void:
	_JumpFallVelocityProcess(delta)
	_Move()
	if velocity.y > 0:
		_animationPlayer.play("jump")
	else:
		_animationPlayer.play("fall")
		
	move_and_slide()
