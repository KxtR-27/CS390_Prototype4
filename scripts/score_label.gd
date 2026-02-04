extends Label


func _ready() -> void:
	GameManager.increment_score.connect(_update_score_label)
	GameManager.reset.connect(_update_score_label)


func _update_score_label() -> void:
	self.text = "Score: %d" % GameManager.score
