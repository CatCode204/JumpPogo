extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and get_tree().paused:
		EventBus.emit_on_game_restart()