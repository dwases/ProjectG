extends HBoxContainer

#signal attack_requested(type: String)
@onready var animation_player: AnimationPlayer = $"../../../AnimationPlayer"


func _ready():
	# Zakładamy, że masz przycisk w scenie
	var lightAttackButton = $LightAttackButton
	var mediumAttackButton = $MediumAttackButton
	var heavyAttackButton = $HeavyAttackButton
	# Łączymy sygnał 'pressed' z funkcją w tym samym skrypcie
	lightAttackButton.pressed.connect(_on_lightAttackButton_pressed)
	mediumAttackButton.pressed.connect(_on_mediumAttackButton_pressed)
	heavyAttackButton.pressed.connect(_on_heavyAttackButton_pressed)
	

func _on_lightAttackButton_pressed():
	print("Przycisk lekki został kliknięty!")
	owner.attack_requested("light")
	animation_player.play("player_light_attack")
	# Tutaj wstawiasz swoją logikę, np. otwarcie menu artefaktów
func _on_mediumAttackButton_pressed():
	print("Przycisk średni został kliknięty!")
	owner.attack_requested("medium")
	animation_player.play("player_medium_attack")
	# Tutaj wstawiasz swoją logikę, np. otwarcie menu artefaktów
func _on_heavyAttackButton_pressed():
	print("Przycisk mocny został kliknięty!")
	owner.attack_requested("heavy")
	animation_player.play("player_heavy_attack")
	# Tutaj wstawiasz swoją logikę, np. otwarcie menu artefaktów
