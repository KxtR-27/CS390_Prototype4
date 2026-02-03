extends VisibleOnScreenNotifier2D


@onready var player: Player = self.get_parent()


func _on_screen_exited() -> void:
	player.can_move = false
	player.position = get_viewport_rect().size / 2
