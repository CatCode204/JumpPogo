extends Control

@export var _current_high_score_label : Label
@export var _high_score_label : Label

@export var _gameOverHud : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_high_score_label.text = "HighScore : %5d" % ScoreManager.HighScore
	_current_high_score_label.text = "%5d" % ScoreManager.CurrentHighScore

	EventBus.on_new_current_high_score.connect(_on_new_current_high_score)
	EventBus.on_new_high_score.connect(_on_new_high_score)
	
	EventBus.on_game_over.connect(_on_game_over)

func _on_new_current_high_score(newCurrentHighScore : int):
	_current_high_score_label.text = "%5d" % newCurrentHighScore
	
func _on_new_high_score(newHighScore : int):
	_high_score_label.text = "HighScore: %5d" % newHighScore
	
func _on_game_over():
	_gameOverHud.visible = true
