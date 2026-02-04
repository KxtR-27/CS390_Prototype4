# class_name GameManager - loaded globally, so no class name
extends Node


@warning_ignore_start("unused_signal")
# emitted by and connected to other scripts
signal increment_score
signal reset
@warning_ignore_restore("unused_signal")


var score := 0


func _on_increment_score() -> void:
	score += 1


func _on_reset() -> void:
	score = 0
