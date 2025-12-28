class_name Enemy extends Unit

# Lista kierunków do losowania
var MoveOpportunities: Array[String] = ["left", "right", "down", "up"]

@onready var stats_component: StatsComponent = $StatsComponent

func _ready() -> void:
	# KLUCZOWE: Wywołujemy _ready rodzica (Unit), żeby:
	# 1. Zarejestrować się w GridManagerze (słowniku).
	# 2. Przysnapować się idealnie do siatki.
	super._ready()
	
	# Rejestracja w managerze wrogów (zgodnie z Twoim systemem)
	EnemyManager.add_enemy(self)

func _exit_tree() -> void:
	# Sprzątanie po sobie w EnemyManagerze
	EnemyManager.remove_enemy(self)
	# Unit posprząta po sobie w GridManagerze automatycznie w swoim _exit_tree
	super._exit_tree()

func death() -> void:
	# Musisz usunąć obiekt, żeby GridManager zwolnił pole w słowniku (poprzez _exit_tree)
	queue_free()

# Logika walki 1:1 taka jak Twoja
func attack(player_component) -> void:
	print("Atakuję gracza") # Usunąłem ten specyficzny print ;)
	var attacks: Array[String] = ["light", "light", "light", "medium", "medium", "heavy"]
	var selected_attack: String = attacks.pick_random()
	
	if stats_component.try_hit(selected_attack, player_component.current_dex):
		if !player_component.try_dodge():
			player_component.take_damage(stats_component.calculate_damage(selected_attack))

# Logika ruchu dostosowana do nowego systemu Unit.move()
func EnemyMove() -> void:
	# Kopiujemy listę kierunków
	var attempts = MoveOpportunities.duplicate()
	# Tasujemy (Shuffle) - to informatyczny odpowiednik Twojego losowania indeksów, 
	# ale szybszy i czystszy w zapisie.
	attempts.shuffle()
	
	# Sprawdzamy po kolei kierunki
	for direction in attempts:
		# Funkcja move() z klasy Unit teraz sama sprawdza:
		# 1. Czy jest ściana (RayCastWall)
		# 2. Czy pole jest zajęte (GridManager)
		if move(direction):
			break # Jeśli udało się ruszyć (zwróciło true), przerywamy pętlę
