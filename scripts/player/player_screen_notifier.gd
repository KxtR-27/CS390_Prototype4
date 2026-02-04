extends VisibleOnScreenNotifier2D


@onready var player: Player = self.get_parent()


func _on_screen_exited() -> void:
	GameManager.reset.emit()
