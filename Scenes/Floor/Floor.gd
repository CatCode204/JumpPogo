extends Area3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body : Node3D):
	if body is Player:
		EventBus.emit_on_game_over()