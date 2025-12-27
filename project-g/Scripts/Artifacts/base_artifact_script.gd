class_name BaseArtifactScript extends Resource

var player_stats = preload("uid://dtgvrioaqwptt")

func apply_constant_stat_changes(stats_component : StatsComponent, strength_change : int,
dexterity_change : int, luck_change : int) -> void:
	stats_component.modify_stat("strength", strength_change)
	stats_component.modify_stat("dexterity", dexterity_change)
	stats_component.modify_stat("luck", luck_change)
