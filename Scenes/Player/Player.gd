extends CharacterBody3D

class_name Player

@onready var _landSoundEffect : AudioStreamPlayer3D = $LandSoundEffect
@onready var _animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var _fallSoundEffect : AudioStreamPlayer3D = $FallEffect

@export var _jumpPower : float = 9.8
@export var _moveSpeed : float = 10.0
@export var _rotationSpeed : float = 5

var _last_landed_y : float = -10

var _highest_y : float = 0

const LAND_BUFFER : float = 1.0
const FALLEN_THRESH_HOLD : float = -40;

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

func _rotate(delta : float):
	if Input.is_action_pressed("move_left"):
		rotate_y(deg_to_rad(_rotationSpeed * delta))
	if Input.is_action_pressed("move_right"):
		rotate_y(deg_to_rad(-_rotationSpeed * delta))
	
func _animation_process():
	if velocity.y > 0:
		_animationPlayer.play("jump")
	else:
		_animationPlayer.play("fall")

func _sound_effect_process():
	if is_on_floor() and global_position.y > _last_landed_y:
		_last_landed_y = global_position.y + LAND_BUFFER
		_landSoundEffect.play()
		
	if velocity.y < 0 and position.y < FALLEN_THRESH_HOLD and not _fallSoundEffect.playing:
		_fallSoundEffect.play()

func _check_and_update_highest_y():
	if global_position.y > _highest_y:
		_highest_y = global_position.y
		EventBus.emit_on_player_new_height_reached(_highest_y)

func _physics_process(delta: float) -> void:
	_JumpFallVelocityProcess(delta)
	_Move()
	_rotate(delta)
	_animation_process()
	_sound_effect_process()
	_check_and_update_highest_y()
	
	move_and_slide()