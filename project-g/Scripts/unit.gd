@abstract 
class_name Unit extends Node2D

@abstract
func death() -> void
	
@abstract
func attack() -> void
	
func _init() -> void:
	var is_in_combat = false
	
func move():
	pass
	
