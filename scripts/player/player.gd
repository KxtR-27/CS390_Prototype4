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

var is_invincible := false


func _ready() -> void:
	GameManager.reset.connect(_reset)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		if not can_move:
			can_move = true
			self.velocity.x = horizontal_speed
		else:
			# subtractive jump mode
			if jump_mode == 0:
				self.velocity.y -= vertical_strength
				SoundManager.JumpSound.pitch_scale = 1.0
				SoundManager.JumpSound.play()
			# constant jump mode
			elif jump_mode == 1:
				self.velocity.y = -vertical_strength
				SoundManager.JumpSound.pitch_scale = 2.0
				SoundManager.JumpSound.play()
			
	if Input.is_action_just_pressed("switch_jump_mode"):
		jump_mode = 1 - jump_mode
		SoundManager.SwitchJumpModeSound.play()


func _physics_process(delta: float) -> void:
	if !can_move:
		self.velocity = Vector2.ZERO
		return
	
	if self.velocity.x < 0:
		self.velocity.x = -horizontal_speed
	elif self.velocity.x > 0:
		self.velocity.x = horizontal_speed
	
	self.velocity.y += delta * gravity
	self.velocity.y = clamp(self.velocity.y, -max_vertical_speed, max_vertical_speed)
	
	var collision := move_and_collide(self.velocity * delta)
	
	if collision:
		var collider := collision.get_collider()
		
		if collider is Wall: 
			var wall := collider as Wall
			wall.put_spike(collision.get_position())
			_bounce(collision)
			SoundManager.BounceSound.play()
		# elif collider is Spike:
			# spike is an Area2D that handles that itself


func _bounce(collision: KinematicCollision2D) -> void:
	self.velocity = self.velocity.bounce(collision.get_normal())
	GameManager.increment_score.emit()


func _reset() -> void:
	self.can_move = false
	self.position = get_viewport_rect().size / 2
