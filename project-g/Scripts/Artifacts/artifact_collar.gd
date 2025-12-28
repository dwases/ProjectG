class_name ArtifactCollar
extends BaseArtifactScript

var last_hp_value: int

func setup_listeners() -> void:
	if !stats_component.health_changed.is_connected(_on_health_lost):
		print("TEST1")
		stats_component.health_changed.connect(_on_health_lost)
	if !base_artifact.artifact_stacks_gained.is_connected(_on_stack_gain):
		print("TEST2")
		base_artifact.artifact_stacks_gained.connect(_on_stack_gain)

func _on_health_lost(current: int, max: int) -> void:
	print("Health changed")

func _on_stack_gain(gained: int, current_stacks: int) -> void:
	print("Stacks gained: %d\nCurrent stacks: %d" %[gained, current_stacks])
