extends CharacterBody3D

@export var _jumpPower : float = 9.8;

var GRAVITY : float = ProjectSettings.get("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity.y = _jumpPower
	else:
		velocity.y -= GRAVITY * delta
		
	move_and_slide()