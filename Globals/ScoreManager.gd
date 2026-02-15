extends Node

var _high_score : int = HighScoreResource.read_file()
var _current_high_score : int = 0

var HighScore:
	get:
		return _high_score

var CurrentHighScore:
	get:
		return _current_high_score

func _enter_tree() -> void:
	EventBus.on_player_new_height_reached.connect(_on_player_new_height_reached)
	EventBus.on_game_restart.connect(_on_game_restart)
	
func _check_and_update_score(score : int):
	if score > _current_high_score:
		_current_high_score = score
		EventBus.emit_on_new_current_high_score(_current_high_score)
		
	if _current_high_score > _high_score:
		_high_score = _current_high_score
		EventBus.emit_on_new_high_score(_high_score)
		HighScoreResource.save_file(_high_score)
		
func _on_player_new_height_reached(new_height : float):
	var score : int = int(new_height)
	_check_and_update_score(score)

func _on_game_restart():
	_current_high_score = 0
