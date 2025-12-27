@abstract 
class_name Unit extends Node2D

@abstract
func death() -> void
	
@abstract
func attack() -> void
	
func _init() -> void:
	var is_in_combat = false

func move(direction):
	if direction == "right":
		position.x += 32
	elif direction == "left":
		position.x -= 32
	elif direction == "up":
		position.y -= 32
	elif direction == "down":
		position.y += 32
