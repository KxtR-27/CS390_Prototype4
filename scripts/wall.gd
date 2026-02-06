class_name Wall
extends StaticBody2D


const SPIKE_SCENE: PackedScene = preload("res://components/spike.tscn")


func put_spike(collision: KinematicCollision2D) -> void:
	var new_spike: Spike = SPIKE_SCENE.instantiate()
	self.add_child(new_spike)
	
	new_spike.global_position = collision.get_position()
	new_spike.rotation = collision.get_angle(Vector2(1, 1))
	
	
