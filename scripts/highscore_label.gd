extends Label


var _high_score := 0


func _ready() -> void:
	GameManager.increment_score.connect(_update_highscore_label)


func _update_highscore_label() -> void:
	_high_score = max(_high_score, GameManager.score)
	self.text = "Highscore: %d" % _high_score
