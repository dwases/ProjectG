class_name StatsComponent
extends Node

# Emitujemy sygnały, żeby UI lub animacje wiedziały co się dzieje
signal health_changed(current: int, max: int)
signal died
signal stats_changed

@export var base_stats: BaseStats

# Zmienne runtime (nie @export, bo one się zmieniają w trakcie gry)
var current_hp: int
var current_str: int
var current_dex: int
var current_lck: int
var current_small_texture: Texture2D
var current_big_texture: Texture2D

func _ready() -> void:
	if base_stats:
		initialize_stats()
	else:
		push_error("StatsComponent: Brak przypisanego BaseStats!")

func initialize_stats() -> void:
	# Kopiujemy wartości bazowe do aktualnych
	current_hp = base_stats.max_hp
	current_str = base_stats.strength
	current_dex = base_stats.dexterity
	current_lck = base_stats.luck
	current_small_texture = base_stats.small_sprite
	current_big_texture = base_stats.big_sprite
	# Emitujemy stan początkowy (np. dla paska zdrowia)
	health_changed.emit(current_hp, base_stats.max_hp)

# --- Logika Zdrowia ---

func is_dead() -> bool:
	return current_hp <= 0

func take_damage(amount: int) -> void:
	# Tutaj możesz w przyszłości dodać logikę pancerza (amount - defense)
	current_hp -= amount
	current_hp = clampi(current_hp, 0, base_stats.max_hp) # Godot 4 ma clampi dla intów
	print("Aktualne zdrowie: ", current_hp)
	health_changed.emit(current_hp, base_stats.max_hp)
	
	if current_hp == 0:
		died.emit()

func heal(amount: int) -> void:
	current_hp += amount
	current_hp = clampi(current_hp, 0, base_stats.max_hp)
	health_changed.emit(current_hp, base_stats.max_hp)

# --- Logika Atrybutów (Checki) ---

func try_hit(type: String, enemy_dex: int) -> bool:
	var base_chance: float
	match type:
		"light":
			base_chance = 85.0
		"medium":
			base_chance = 55.0
		"heavy":
			base_chance = 30.0
	var dex_ratio : float = (float(current_dex) / float(enemy_dex))
	var final_chance : float = clamp((base_chance * dex_ratio),0, 100)
	var roll = randf() * 100
	print("Czy udało się trafić = ", roll <= final_chance, " Wylosowalo: ", roll, " A masz: ", final_chance)
	return roll <= final_chance

func calculate_damage(type: String) -> int:
	var base_dmg: float
	match type:
		"light":
			base_dmg = 0.7
		"medium":
			base_dmg = 1
		"heavy":
			base_dmg = 1.5
	print("Zadane obrazenia: ", int(base_dmg * current_str))
	return int(base_dmg * current_str)

# Przykład: Funkcja sprawdzająca czy unik się udał (bazując na Zręczności i Szczęściu)
func try_dodge() -> bool:
	var dodge_chance = (current_dex * 0.1) + (current_lck * 0.1)
	return randf_range(0, 100) < dodge_chance
# Funkcja do modyfikowania atrybutów (np. po wypiciu mikstury siły)

func modify_stat(stat_name: String, value: int) -> void:
	match stat_name:
		"strength":
			current_str += value
		"dexterity":
			current_dex += value
		"luck":
			current_lck += value
		_:
			push_warning("Próba zmiany nieistniejącej statystyki: " + stat_name)
			return # Nie emitujemy sygnału, jeśli nic nie zmieniliśmy

	# TU JEST KLUCZ: Po zmianie wartości, informujemy świat
	stats_changed.emit()

# Opcjonalnie: Getter, żeby UI miało łatwiej pobrać wszystko na raz
func get_stats_dict() -> Dictionary:
	return {
		"STR": current_str,
		"DEX": current_dex,
		"LCK": current_lck
	}
