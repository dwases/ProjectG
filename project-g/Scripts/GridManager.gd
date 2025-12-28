extends Node

# Konfiguracja
const TILE_SIZE: int = 32
# Tutaj wpisujesz swoją korektę. Skoro masz -16px, to prawdopodobnie
# musisz dodać 16px (połowę kafelka), żeby wycentrować postać.
const GRID_OFFSET: Vector2 = Vector2(-16, -16)

# Główna baza danych: Klucz (Vector2i) -> Wartość (Unit/Node2D)
var _occupied_cells: Dictionary = {}

# --- PUBLIC API ---

# Rejestracja jednostki przy spawnie
func register_unit(unit: Node2D, grid_pos: Vector2i) -> void:
	if _occupied_cells.has(grid_pos):
		push_warning("GridManager: Próba nadpisania zajętego pola %s przez %s" % [grid_pos, unit.name])
		# Opcjonalnie: unit.queue_free() lub przesunięcie na wolne pole
	
	_occupied_cells[grid_pos] = unit

# Wyrejestrowanie (np. przy śmierci)
func unregister_unit(grid_pos: Vector2i) -> void:
	if _occupied_cells.has(grid_pos):
		_occupied_cells.erase(grid_pos)

# Próba wykonania ruchu (Atomowa operacja)
func request_move(unit: Node2D, old_pos: Vector2i, new_pos: Vector2i) -> bool:
	# 1. Sprawdź czy pole jest wolne w danych
	if _occupied_cells.has(new_pos):
		return false
	
	# 2. Wykonaj transakcję
	_occupied_cells.erase(old_pos)
	_occupied_cells[new_pos] = unit
	return true

# Helper do walki: "Co stoi na tym polu?"
func get_entity_at(grid_pos: Vector2i) -> Node2D:
	return _occupied_cells.get(grid_pos, null)

# Debug (opcjonalnie)
func _input(event):
	if event.is_action_pressed("ui_focus_next"): # TAB
		print("Aktualny stan gridu: ", _occupied_cells)
		
# Zamienia logiczny index (2, 5) na pozycję w świecie gry (80px, 176px) z uwzględnieniem offsetu
func grid_to_world(grid_pos: Vector2i) -> Vector2:
	return (Vector2(grid_pos) * TILE_SIZE) + GRID_OFFSET

# Zamienia pozycję w świecie na index (dla snapowania przy starcie)
func world_to_grid(world_pos: Vector2) -> Vector2i:
	return Vector2i((world_pos - GRID_OFFSET) / TILE_SIZE)
