class_name Wall
extends StaticBody2D


const SPIKE_SCENE: PackedScene = preload("res://components/spike.tscn")

@export_enum("Left", "Right") var spikes_point := 1


func put_spike(at_position: Vector2) -> void:
	var new_spike: Spike = SPIKE_SCENE.instantiate()
	new_spike.pointing_direction = self.spikes_point
	self.add_child(new_spike)
	new_spike.global_position = at_position
