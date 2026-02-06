@tool
class_name Spike
extends Area2D


func _ready() -> void:
	GameManager.reset.connect(_on_reset)


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not (body as Player).is_invincible:
		SoundManager.HitSpikeSound.play()
		GameManager.reset.emit()


func _on_reset() -> void:
	self.queue_free()
