@abstract 
class_name Unit extends Node2D

@onready var rc_down: RayCast2D = $RCDown
@onready var rc_left: RayCast2D = $RCLeft
@onready var rc_right: RayCast2D = $RCRight
@onready var rc_up: RayCast2D = $RCUp


@abstract
func death() -> void
	
@abstract
func attack() -> void
	
func _init() -> void:
	var is_in_combat = false

func move(direction):
	if direction == "right":
		if rc_right.is_colliding():
			position.x += 32
	elif direction == "left":
		if rc_left.is_colliding():	
			position.x -= 32
	elif direction == "up":
		if rc_up.is_colliding():
			position.y -= 32
	elif direction == "down":
		if rc_down.is_colliding():
			position.y += 32
