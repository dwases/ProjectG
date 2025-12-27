class_name Player extends Unit

func death() -> void:
	pass
	
func attack() -> void:
	pass

func _process(delta):
	if Input.is_action_just_pressed("move_right"):
		move("right")
	elif Input.is_action_just_pressed("move_left"):
		move("left")
	elif Input.is_action_just_pressed("move_up"):
		move("up")
	elif Input.is_action_just_pressed("move_down"):
		move("down")
	
	#if Input.is_action_just_pressed()

	


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Interakcja") # Replace with function body.
