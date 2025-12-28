class_name ArtifactBomb
extends BaseArtifactScript

var last_hp_value: int = 50
var total_lost: int
const lost_threshold: int = 15

func setup_listeners() -> void:
	if !stats_component.health_changed.is_connected(_on_health_lost):
		stats_component.health_changed.connect(_on_health_lost)

func _on_health_lost(current: int, max: int) -> void:
	if last_hp_value - current > 0:
		total_lost += last_hp_value - current
		print("Bomb charge: %d/%d damage taken" %[total_lost, lost_threshold])
		if total_lost >= lost_threshold:
			explode()
			total_lost = 0
	last_hp_value = current

func explode() -> void:
	print("EXPLODE")
