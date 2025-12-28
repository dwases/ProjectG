class_name Unit extends Node2D

var grid_pos: Vector2i
@onready var wall_check: RayCast2D = $RayCastWall

func _ready() -> void:
	# Używamy nowej funkcji do obliczenia startowej pozycji na siatce
	grid_pos = GridManager.world_to_grid(global_position)
	
	# Snapujemy postać wizualnie do idealnego środka pola
	global_position = GridManager.grid_to_world(grid_pos)
	
	GridManager.register_unit(self, grid_pos)

func animate_move(target_grid_pos: Vector2i) -> void:
	var tween = create_tween()
	# Tutaj też używamy funkcji konwertującej
	var target_world_pos = GridManager.grid_to_world(target_grid_pos)
	
	tween.tween_property(self, "global_position", target_world_pos, 0.1).set_trans(Tween.TRANS_SINE)

# ... funkcja move() pozostaje bez zmian ...
var AmPlayer: bool = false

func AmIPlayer()->void:
	AmPlayer=true
# W pliku Unit.gd

func move(direction: String) -> bool:
	var dir_vec = Vector2i.ZERO
	match direction:
		"up": dir_vec = Vector2i.UP
		"down": dir_vec = Vector2i.DOWN
		"left": dir_vec = Vector2i.LEFT
		"right": dir_vec = Vector2i.RIGHT
	
	# Sprawdzanie ścian (fizyka)
	if is_wall_blocking(dir_vec):
		return false
	
	var target_grid_pos = grid_pos + dir_vec
	
	# 1. Próba ruchu na wolne pole
	if GridManager.request_move(self, grid_pos, target_grid_pos):
		grid_pos = target_grid_pos
		animate_move(target_grid_pos)
		return true # Ruch wykonany -> EnemyManager ruszy wrogami
	
	# 2. Ruch zablokowany - sprawdzamy co tam stoi
	var blocker = GridManager.get_entity_at(target_grid_pos)
	
	if blocker:
		# Wywołujemy funkcję, którą nadpisze Player
		_on_interaction(blocker)
		
	return false # Ruch NIE wykonany -> EnemyManager NIE ruszy wrogami
	
func _on_interaction(entity: Node2D) -> void:
	pass

func _exit_tree() -> void:
	# AUTOMATYCZNE czyszczenie slota przy usunięciu obiektu (np. queue_free)
	GridManager.unregister_unit(grid_pos)

func is_wall_blocking(dir: Vector2i) -> bool:
	# Obracamy jeden RayCast w stronę ruchu - oszczędność zasobów
	wall_check.target_position = Vector2(dir) * GridManager.TILE_SIZE
	wall_check.force_raycast_update()
	return wall_check.is_colliding()
