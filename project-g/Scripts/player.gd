class_name Player extends Unit

var inventory: Dictionary = {} # { ArtifactData: int }

@onready
var stats_component: StatsComponent = $StatsComponent

func _ready() -> void:
	AmIPlayer()

func death() -> void:
	pass
	
func attack() -> void:
	pass



func add_artifact(artifact: ArtifactData):
	if inventory.has(artifact):
		inventory[artifact] += 1
	else:
		inventory[artifact] = 1
	
#	apply_artifact_effect(artifact)

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
