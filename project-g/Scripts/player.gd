class_name Player extends Unit

var inventory: Array = [] # [ ArtifactData ]
#@onready var map_battle_window: BattleWindow = %MapBattleWindow
var B_Window : BattleWindow
@onready var battle_window_scene = preload("res://Nodes/battle_window.tscn")
@onready
var stats_component: StatsComponent = $StatsComponent

var is_in_combat : bool = false

func _ready() -> void:
	AmIPlayer()
	stats_component.connect("died",death)

func death() -> void:
	is_in_combat = true
	await get_tree().create_timer(1.0).timeout
	#get_tree().change_scene_to_file("res://Levels/map_1.tscn")
	get_tree().change_scene_to_file("res://Levels/game_over.tscn")
	
func attack(_player_component: StatsComponent) -> void:
	pass
func _on_interaction(entity: Node2D) -> void:
	# Sprawdzamy czy to, na co wpadliśmy, to przeciwnik
	if entity is Enemy:
		start_combat(entity)
func start_combat(enemy_instance: Enemy) -> void:
	print("Grid wykrył kolizję z: ", enemy_instance.name)
	
	# Twoja logika inicjalizacji walki:
	B_Window = battle_window_scene.instantiate()
	
	
	# UWAGA: Przekazujemy 'enemy_instance' (konkretną rybę), 
	# a nie 'Enemy' (nazwę klasy/typu).
	B_Window.initialize(self, enemy_instance)
	
	is_in_combat = true
	AddBattleWindow(B_Window)
	# Opcjonalnie: Zatrzymaj input gracza, żeby nie mógł chodzić w tle
	set_process_input(false)

func add_artifact(artifact: ArtifactData):
	artifact.setOwner(self)
	if inventory.has(artifact):
		print("Adding 1 more stack of an artifact: %s\n" %[artifact.display_name])
		artifact.addStacks()
	else:
		print("Adding new artifact to collection: %s\n" %[artifact.display_name])
		inventory.append(artifact)
	
#	apply_artifact_effect(artifact)
func _process(_delta):
	if Input.is_action_just_pressed("take_damage_test"):
		stats_component.take_damage(10)
	if Input.is_action_just_pressed("add_artifact"):
		add_artifact(ArtifactList.artifacts["bomb"])
	if Input.is_action_just_pressed("add_artifact2"):
		add_artifact(ArtifactList.artifacts["collar"])
	if is_in_combat or is_moving:
		return 
	if Input.is_action_just_pressed("move_right"):
		is_moving = true
		if(move("right")):
			EnemyManager.move_enemies()
			await get_tree().create_timer(0.1).timeout
			is_moving = false
	elif Input.is_action_just_pressed("move_left"):
		is_moving = true
		if(move("left")):
			EnemyManager.move_enemies()
			await get_tree().create_timer(0.1).timeout
			is_moving = false
	elif Input.is_action_just_pressed("move_up"):
		is_moving = true
		if(move("up")):
			EnemyManager.move_enemies()
			await get_tree().create_timer(0.1).timeout
			is_moving = false
	elif Input.is_action_just_pressed("move_down"):
		is_moving = true
		if(move("down")):
			EnemyManager.move_enemies()
			await get_tree().create_timer(0.1).timeout
			is_moving = false
	is_moving = false	
	
	#if Input.is_action_just_pressed()

	


func _on_area_2d_area_entered(area: Area2D) -> void:
	#var B_Window = battle_window_scene.instantiate()
	get_parent().add_child(B_Window)
	B_Window.initialize(self as Player, area.owner as Enemy)
	#B_Window.canvas_layer.show()
	is_in_combat = true
	
	#var parent = get_parent()
	#var battle_window : BattleWindow = BattleWindow.new()
	#add_child(battle_window)
	
	#parent.add_child(battle_window)
	
	#battle_window.instantiate()
	
	#var new_camera = $"../BattleWindow/BattleCamera"
	#new_camera.make_current()
func AddBattleWindow(BWindow) -> void:
	get_parent().add_child(BWindow)
	BWindow.BindToMap()
