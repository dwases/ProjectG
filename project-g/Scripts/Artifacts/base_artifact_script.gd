@abstract
class_name BaseArtifactScript extends Resource

var player_stats = preload("uid://dtgvrioaqwptt")
var base_artifact: ArtifactData
var owner: Node
var stats_component: StatsComponent

@abstract
func setup_listeners() -> void

func set_artifact_owner(getOwner: Node, getBaseArtifact: ArtifactData) -> void:
	base_artifact = getBaseArtifact
	owner = getOwner
	stats_component = owner.get_node("StatsComponent")
	setup_listeners()

func apply_constant_stat_changes(stats_component : StatsComponent, strength_change : int,
dexterity_change : int, luck_change : int) -> void:
	stats_component.modify_stat("strength", strength_change)
	stats_component.modify_stat("dexterity", dexterity_change)
	stats_component.modify_stat("luck", luck_change)
