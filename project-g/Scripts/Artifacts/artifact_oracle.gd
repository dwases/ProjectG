class_name ArtifactOracle
extends BaseArtifactScript

var last_hp_value: int

func setup_listeners() -> void:
	if !stats_component.health_changed.is_connected(_on_health_lost):
		stats_component.health_changed.connect(_on_health_lost)

func _on_health_lost(current: int, max: int) -> void:
	print("Health changed")
