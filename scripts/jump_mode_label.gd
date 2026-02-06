extends Label


@export var player: Player


func _ready() -> void:
	if not player:
		player = get_node("/root/Main/Player")
	if player:
		_update_text()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch_jump_mode"):
		if player:
			_update_text()


func _update_text() -> void:
	self.text = "Jump Mode - %s" % ("Subtractive" if player.jump_mode == 0 else "Constant")
