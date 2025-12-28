class_name Enemy extends Unit

# Lista kierunków do losowania
var MoveOpportunities: Array[String] = ["left", "right", "down", "up"]


@onready var stats_component: StatsComponent = $StatsComponent

@export var base_stats: BaseStats

func _ready() -> void:
	# KLUCZOWE: Wywołujemy _ready rodzica (Unit), żeby:
	# 1. Zarejestrować się w GridManagerze (słowniku).
	# 2. Przysnapować się idealnie do siatki.
	super._ready()
	stats_component.base_stats=base_stats
	stats_component.initialize_stats()
	stats_component.connect("died",death)
	# Rejestracja w managerze wrogów (zgodnie z Twoim systemem)
	EnemyManager.add_enemy(self)

func _exit_tree() -> void:
	# Sprzątanie po sobie w EnemyManagerze
	EnemyManager.remove_enemy(self)
	# Unit posprząta po sobie w GridManagerze automatycznie w swoim _exit_tree
	super._exit_tree()

func death() -> void:
	print("Śmierć")
	var player: Player = %Player
	player.B_Window.canvas_layer.hide()
	player.is_in_combat = false
	# Musisz usunąć obiekt, żeby GridManager zwolnił pole w słowniku (poprzez _exit_tree)
	_exit_tree()
	queue_free()

# Logika walki 1:1 taka jak Twoja
func attack(player_component) -> void:
	if not stats_component.is_dead():
		print("Atakuję gracza") # Usunąłem ten specyficzny print ;)
		var attacks: Array[String] = ["light", "light", "light", "medium", "medium", "heavy"]
		var selected_attack: String = attacks.pick_random()
		
		if stats_component.try_hit(selected_attack, player_component.current_dex):
			if !player_component.try_dodge():
				player_component.take_damage(stats_component.calculate_damage(selected_attack))

func EnemyMove() -> void:
	# Mapa kierunków do wektorów (słownik dla szybkości zapisu)
	var dir_vectors = {
		"up": Vector2i.UP,
		"down": Vector2i.DOWN,
		"left": Vector2i.LEFT,
		"right": Vector2i.RIGHT
	}
	
	# KROK 1: Sprawdź, czy Gracz jest na sąsiednim polu (Priorytet Ataku)
	for direction in MoveOpportunities:
		var offset = dir_vectors[direction]
		var target_pos = grid_pos + offset
		
		# Pytamy Managera: "Kto tam stoi?"
		var entity = GridManager.get_entity_at(target_pos)
		
		# Jeśli to Gracz -> Próbujemy w niego wejść!
		if entity is Player:
			print("Gracz namierzony! Próba ataku w kierunku: ", direction)
			move(direction) # To zwróci false, ale wywoła interakcję (atak)
			return # Kończymy turę, nie chcemy się już nigdzie indziej ruszać

	# KROK 2: Jeśli Gracza nie ma obok -> Losowy spacer (Twoja stara logika)
	var attempts = MoveOpportunities.duplicate()
	attempts.shuffle()
	
	for direction in attempts:
		if move(direction):
			break
func _on_interaction(entity: Node2D) -> void:
	if entity is Player:
		start_combat(entity)
func start_combat(player: Player) -> void:
	print("Enemy wykrył kolizję z: ", player.name)
	
	# Twoja logika inicjalizacji walki:
	player.B_Window = player.battle_window_scene.instantiate()
	player.AddBattleWindow(player.B_Window)
	
	# UWAGA: Przekazujemy 'enemy_instance' (konkretną rybę), 
	# a nie 'Enemy' (nazwę klasy/typu).
	player.B_Window.initialize(player, self)
	
	player.is_in_combat = true
	
	# Opcjonalnie: Zatrzymaj input gracza, żeby nie mógł chodzić w tle
	set_process_input(false)
