extends Control

var stats_component: StatsComponent 

@onready var health_bar: ProgressBar = $Layout/HealthBar
@onready var stats_label: Label = $Layout/Stats/StatsLabel

func connect_signals() -> void:
	# Podłączamy się pod sygnały z komponentu
	stats_component.health_changed.connect(_on_health_changed)
	stats_component.stats_changed.connect(_on_stats_changed)

func initialize_ui() -> void:
	# Wymuszamy pierwsze odświeżenie, żeby UI nie było puste na starcie
	# (Zakładamy, że stats_component jest już po swoim _ready)
	if stats_component:
		_on_health_changed(stats_component.current_hp, stats_component.base_stats.max_hp)
		_on_stats_changed()
		stats_component.stats_changed.connect(_on_stats_changed)
		stats_component.health_changed.connect(_on_health_changed)
	else:
		push_error("Nie znaleziono komponentu statystyk!")

# --- Reakcje na sygnały ---

func _on_health_changed(current: int, max_val: int) -> void:
	health_bar.max_value = max_val
	health_bar.value = current
	# Opcjonalnie tekst na pasku:
	# $HealthBar/Label.text = "%d / %d" % [current, max_val]

func _on_stats_changed() -> void:
	# Pobieramy aktualne wartości bezpośrednio z komponentu
	# Możesz tu użyć get_stats_dict(), które napisałem wyżej, albo odwołać się wprost
	var txt = "STR: %d\nDEX: %d\nLCK: %d" % [
		stats_component.current_str,
		stats_component.current_dex,
		stats_component.current_lck
	]
	stats_label.text = txt

func setup(player: Node2D) -> void:
	stats_component = player.get_node("StatsComponent")
	initialize_ui()
