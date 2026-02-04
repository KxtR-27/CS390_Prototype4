extends Timer


@onready var player: Player = self.get_parent()


func _ready() -> void:
	GameManager.increment_score.connect(_on_score)
	GameManager.reset.connect(_on_reset)


func _on_score() -> void:
	player.is_invincible = true
	self.start()


func _on_reset() -> void:
	player.is_invincible = false
	self.stop()


func _on_timeout() -> void:
	player.is_invincible = false
