extends Control
class_name StatsUI # Nadajemy nazwę klasy, by łatwiej typować

@onready var layout: VBoxContainer = $Layout

@onready var health_bar: ProgressBar = $Layout/HealthBar
@onready var stats_label: Label = $Layout/Stats/StatsLabel
@onready var corner_texture: TextureRect = $AspectRatioContainer/TextureRect
var connected_component: StatsComponent

func setup(unit: Node2D) -> void:
	var component = unit.get_node_or_null("StatsComponent")
	if not component:
		push_error("Brak StatsComponent u: " + unit.name)
		return

	connected_component = component
	
	# 1. Rozłącz stare sygnały (jeśli jakieś były - np. przy recyklingu UI)
	_disconnect_signals()
	
	# 2. Podłącz nowe
	connected_component.health_changed.connect(_on_health_changed)
	connected_component.stats_changed.connect(_on_stats_changed)
	
	# 3. Wymuś pierwsze odświeżenie wyglądu
	_on_health_changed(component.current_hp, component.base_stats.max_hp)
	_on_stats_changed()
	health_bar.custom_minimum_size.x = 250

func _disconnect_signals() -> void:
	if connected_component:
		if connected_component.health_changed.is_connected(_on_health_changed):
			connected_component.health_changed.disconnect(_on_health_changed)
		if connected_component.stats_changed.is_connected(_on_stats_changed):
			connected_component.stats_changed.disconnect(_on_stats_changed)

func _on_health_changed(current: int, max_val: int) -> void:
	health_bar.max_value = max_val
	health_bar.value = current

func _on_stats_changed() -> void:
	# Używamy zmiennej connected_component zamiast szukać get_node za każdym razem
	var txt = "STR: %d\nDEX: %d\nLCK: %d" % [
		connected_component.current_str,
		connected_component.current_dex,
		connected_component.current_lck
	]
	stats_label.text = txt

func set_alignment_right() -> void:
	# 1. Przestawiamy tekst w Labelu na prawą stronę
	stats_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	corner_texture.flip_h = true
	health_bar.fill_mode = ProgressBar.FILL_END_TO_BEGIN
	
	# 2. (Opcjonalnie) Jeśli chcesz, żeby pasek życia malał w drugą stronę (od prawej do lewej)
	# health_bar.fill_mode = ProgressBar.FILL_END_TO_BEGIN
