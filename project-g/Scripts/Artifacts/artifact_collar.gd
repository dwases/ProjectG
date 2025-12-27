class_name ArtifactCollar
extends BaseArtifactScript

var last_hp_value: int

func setup_listeners() -> void:
	print("Setting up listener...\n%s\n" %[stats_component])
	stats_component.health_changed.connect(_on_health_lost)

func _on_health_lost(current: int, max: int) -> void:
	print("Health changed")
