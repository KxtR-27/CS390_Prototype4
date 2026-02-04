@tool
class_name Spike
extends Area2D


@export_enum("Left", "Right") var pointing_direction := 1:
	set(new_dir):
		pointing_direction = new_dir
		var target_scale: float = absf(self.scale.x) * (1 if new_dir == 1 else -1)
		self.scale = Vector2(target_scale, target_scale)


func _ready() -> void:
	GameManager.reset.connect(_on_reset)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.reset.emit()


func _on_reset() -> void:
	self.queue_free()
