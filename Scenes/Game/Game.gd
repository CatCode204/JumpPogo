extends Node

func _ready() -> void:
	EventBus.on_game_over.connect(_on_game_over)
	EventBus.on_game_restart.connect(_on_game_restart)
	get_tree().paused = false

func _on_game_over():
	get_tree().paused = true
	
func _on_game_restart():
	print("HERE")
	get_tree().reload_current_scene()