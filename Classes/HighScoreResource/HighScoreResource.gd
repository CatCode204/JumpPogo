extends Resource

class_name HighScoreResource

static var FILE_PATH : String = "user://score.tres"

@export var high_score : int = 0

static func read_file() -> int:
	var highScoreResource : HighScoreResource = null
	if ResourceLoader.exists(FILE_PATH):
		highScoreResource = load(FILE_PATH)
		
	if highScoreResource != null: 
		return highScoreResource.high_score 
	else:
		return 0
		
static func save_file(score : int):
	var highScoreResource : HighScoreResource = HighScoreResource.new()
	highScoreResource.high_score = score
	ResourceSaver.save(highScoreResource,FILE_PATH)