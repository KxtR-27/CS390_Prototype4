class_name Player
extends CharacterBody2D


@export var can_move := false

@export var horizontal_speed := 300.0

@export var vertical_strength := 750.0

@export var max_vertical_speed := 1000.0

@export var gravity := 2000.0


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and !can_move:
		can_move = true
		self.velocity.x = horizontal_speed


func _physics_process(delta: float) -> void:
	if !can_move:
		return
	
	if Input.is_action_just_pressed("jump"):
		self.velocity.y = -vertical_strength
	
	self.velocity.y += delta * gravity
	
	self.velocity.y = clamp(self.velocity.y, -max_vertical_speed, max_vertical_speed)
	
	var collision := move_and_collide(self.velocity * delta)
	
	if collision:
		if collision.get_collider() is Wall:
			self.velocity = self.velocity.bounce(collision.get_normal())
