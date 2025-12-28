class_name ArtifactBradsword
extends BaseArtifactScript

var current_enemy: Enemy
var last_hp_value: int
const healing_multiplier: float = 0.1

func setup_listeners() -> void:
	var player = owner as Player
	if !player.begin_battle.is_connected(_on_battle_begin):
		player.begin_battle.connect(_on_battle_begin)

func _on_battle_begin(battleWindow: BattleWindow) -> void:
	current_enemy = battleWindow.enemyref
	current_enemy.stats_component.health_changed.connect(_on_enemy_damaged)
	last_hp_value = current_enemy.stats_component.current_hp

func _on_enemy_damaged(current: int, max: int):
	if current_enemy == null:
		return
	if last_hp_value - current > 0:
		var lost_hp = last_hp_value - current
		var player = owner as Player
		player.stats_component.heal(healing_multiplier * base_artifact.stacks as float * lost_hp as float)
		print("BROADSWORD: Healed for %d hp" % [healing_multiplier * base_artifact.stacks as float * lost_hp as float])
	last_hp_value = current
