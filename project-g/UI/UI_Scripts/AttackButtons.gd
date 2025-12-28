extends HBoxContainer

#signal attack_requested(type: String)


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
	# Tutaj wstawiasz swoją logikę, np. otwarcie menu artefaktów
func _on_mediumAttackButton_pressed():
	print("Przycisk średni został kliknięty!")
	owner.attack_requested("medium")
	# Tutaj wstawiasz swoją logikę, np. otwarcie menu artefaktów
func _on_heavyAttackButton_pressed():
	print("Przycisk mocny został kliknięty!")
	owner.attack_requested("heavy")
	# Tutaj wstawiasz swoją logikę, np. otwarcie menu artefaktów
