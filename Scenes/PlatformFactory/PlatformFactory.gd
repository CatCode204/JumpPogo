extends Node

enum PLATFORM_MODELS {
	ICE_ISLAND,
	BOUNCER,
	BOUNCER1,
	THREE_LAYER,
	ISLAND
}

var PLATFORM_SCENES : Dictionary = {
	PLATFORM_MODELS.ICE_ISLAND : preload("res://Scenes/Platform/IceIslandPlatform.tscn"),
	PLATFORM_MODELS.ISLAND : preload("res://Scenes/Platform/IslandPlatform.tscn"),
	PLATFORM_MODELS.BOUNCER : preload("res://Scenes/Platform/BouncerPlatform.tscn"),
	PLATFORM_MODELS.BOUNCER1 : preload("res://Scenes/Platform/BouncerPlatform1.tscn"),
	PLATFORM_MODELS.THREE_LAYER : preload("res://Scenes/Platform/3LayerPlatform.tscn")
}

const OFFSET_UP : Vector2 = Vector2(2.5,4)
const OFFSET_SIDE : Vector2 = Vector2(1.7,3.7)
	
func _ready() -> void:
	_create_platform(Vector3(0,0,0))
	
func _calculate_new_platform_pos(oldPlatformPos : Vector3) -> Vector3:
	var offsetY : float = randf_range(OFFSET_UP.x,OFFSET_UP.y)
	var offsetX : float = randf_range(OFFSET_SIDE.x,OFFSET_SIDE.y) * ((randi() % 2) * 2 - 1)
	var offsetZ : float = randf_range(OFFSET_SIDE.x,OFFSET_SIDE.y) * ((randi() % 2) * 2 - 1)
	return oldPlatformPos + Vector3(offsetX,offsetY,offsetZ)
	
func _create_platform(pos : Vector3):
	var platformScene : PackedScene = PLATFORM_SCENES[PLATFORM_MODELS.values().pick_random()]
	var platform : Platform = platformScene.instantiate()
	platform.platform_collide.connect(_on_platform_collide)
	add_child(platform)
	platform.global_position = pos
	EventBus.emit_on_platform_create(pos)
	
func _on_platform_collide(platformPos : Vector3):
	var newPlatformPosition : Vector3 = _calculate_new_platform_pos(platformPos)
	_create_platform(newPlatformPosition)
