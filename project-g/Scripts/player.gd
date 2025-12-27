class_name Player extends Unit

var inventory: Dictionary = {} # { ArtifactData: int }
@onready var map_battle_window: BattleWindow = %MapBattleWindow

@onready
var stats_component: StatsComponent = $StatsComponent

var is_in_combat = false

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
	if is_in_combat:
		return
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
	
	
	map_battle_window.canvas_layer.show()
	is_in_combat = true
	
	#var parent = get_parent()
	#var battle_window : BattleWindow = BattleWindow.new()
	#add_child(battle_window)
	
	#parent.add_child(battle_window)
	
	#battle_window.instantiate()
	
	#var new_camera = $"../BattleWindow/BattleCamera"
	#new_camera.make_current()
