extends Node

signal on_platform_create(platformPos : Vector3)

signal on_player_new_height_reached(new_height : float)

signal on_new_high_score(new_high_score : int)

signal on_new_current_high_score(new_current_high_score : int)

signal on_game_over()

signal on_game_restart()

func emit_on_platform_create(platformPos : Vector3):
	on_platform_create.emit(platformPos)
	
func emit_on_player_new_height_reached(new_height : float):
	on_player_new_height_reached.emit(new_height)
	
func emit_on_new_high_score(new_high_score : int):
	on_new_high_score.emit(new_high_score)
	
func emit_on_new_current_high_score(new_current_high_score : int):
	on_new_current_high_score.emit(new_current_high_score)
	
func emit_on_game_over():
	on_game_over.emit()
	
func emit_on_game_restart():
	on_game_restart.emit()