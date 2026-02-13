extends Camera3D

@export var _platformOffset : Vector3 = Vector3(0,3,4)
@export var _smoothSpeed : float = 2.0;

var _basePosition : Vector3 = Vector3(0,0,0)

func _enter_tree() -> void:
	EventBus.on_platform_create.connect(_on_platform_create)
	
func _ready() -> void:
	_basePosition = Vector3(0,0,0) + _platformOffset
	position = _basePosition

func _process(delta: float) -> void:
	position = position.lerp(_basePosition,_smoothSpeed * delta)
	
func _on_platform_create(platformPos : Vector3):
	_basePosition = platformPos + _platformOffset
