class_name Player
extends CharacterBody2D


@export var can_move := false

## [b]Subtractive[/b] - vertical strength is substracted from [code]velocity[/code][br]
## [b]Constant[/b] - [code]velocity.y[/code] is set to vertical strength
@export_enum("Subtractive", "Constant") var jump_mode := 0

## The horizontal speed at which the player moves.
@export var horizontal_speed := 300.0

## Velocity applied when jumping. See Jump Mode for how this value is applied.
@export var vertical_strength := 750.0

## Clamps the upward and downward speed by this value.
## If Jump Mode is set to constant, and Vertical Strength is less than this value,
## this value is redundant.
@export var max_vertical_speed := 1000.0

## Gravity applied to the player
@export var gravity := 2000.0


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and !can_move:
		can_move = true
		self.velocity.x = horizontal_speed


func _physics_process(delta: float) -> void:
	if !can_move:
		self.velocity = Vector2.ZERO
		return
	
	if Input.is_action_just_pressed("jump"):
		# subtractive jump mode
		if jump_mode == 0:
			self.velocity.y -= vertical_strength
		# constant jump mode
		elif jump_mode == 1:
			self.velocity.y = -vertical_strength
	
	self.velocity.y += delta * gravity
	
	self.velocity.y = clamp(self.velocity.y, -max_vertical_speed, max_vertical_speed)
	
	var collision := move_and_collide(self.velocity * delta)
	
	if collision:
		if collision.get_collider() is Wall:
			self.velocity = self.velocity.bounce(collision.get_normal())
			GameManager.increment_score.emit()
