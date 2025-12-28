extends Node2D

# To przeciągnij w Inspektorze! Wskaż plik .tscn swojego StatsUI
@export var stats_ui_scene: PackedScene 

@onready var player = $Player
@onready var hud = $HUD
@onready var player_ui = $HUD/StatsUI # Zakładam, że to UI Gracza już tam wisi

# Zmienna do trzymania UI przeciwnika, żeby móc je potem usunąć
var current_enemy_ui: Control = null

func _ready():
	# Setup gracza bez zmian
	player_ui.setup(player)

# Funkcja wywoływana, gdy zaczyna się walka
func create_enemy_hud(enemy_unit: Node2D) -> void:
	# Jeśli jakieś stare UI wisiało, usuń je
	remove_enemy_hud()
	
	if not stats_ui_scene:
		push_error("Zapomniałeś przypisać stats_ui_scene w Inspektorze Mapy!")
		return

	# 1. Tworzymy nową instancję UI z pliku
	var new_ui = stats_ui_scene.instantiate()

	# 2. Dodajemy do HUDu
	hud.add_child(new_ui)
	
	# 1. Ustawienie Presetu na TOP_RIGHT
	# Ta funkcja ustawia zarówno kotwice (anchors) jak i pozycję (offsets)
	new_ui.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT)
	new_ui.custom_minimum_size.x = 300
	new_ui.position += Vector2(-300, 0)
	new_ui.set_alignment_right()
	
	# 2. (Opcjonalnie) Korekta Marginesu
	# Domyślnie przyklei się idealnie do krawędzi (0,0). 
	# Warto dodać mały margines, żeby nie dotykało ramki ekranu.
	# Przesuwamy w LEWO (minus na X) i w DÓŁ (plus na Y)


	new_ui.setup(enemy_unit)
	current_enemy_ui = new_ui

# Funkcja do sprzątania po walce
func remove_enemy_hud() -> void:
	if current_enemy_ui != null:
		current_enemy_ui.queue_free()
		current_enemy_ui = null
	#sprawdzanie warunku zwyciestwa gry
	var children = get_children()
	for child in children:
		if child is Enemy:
			return
	get_tree().change_scene_to_file("res://Levels/victory_screen.tscn")
