extends Node

var PLATFORM_SCENE : PackedScene = preload("res://Scenes/Platform/Platform.tscn")
	
func _calculate_new_platform_pos(oldPlatformPos : Vector3) -> Vector3:
	return oldPlatformPos + Vector3(-2,3,-2)
	
func _create_platform(pos : Vector3):
	var platform : Platform = PLATFORM_SCENE.instantiate()
	platform.platform_collide.connect(_on_platform_collide)
	add_child(platform)
	platform.global_position = pos
	EventBus.emit_on_platform_create(pos)
	
func _on_platform_collide(platformPos : Vector3):
	var newPlatformPosition : Vector3 = _calculate_new_platform_pos(platformPos)
	_create_platform(newPlatformPosition)
