class_name ArtifactCollar
extends BaseArtifactScript

var current_enemy: Enemy
var last_hp_value: int
const lost_threshold: float = 0.5
const damage_multiplier: float = 0.5
var enemy_str: int

func setup_listeners() -> void:
	if !stats_component.health_changed.is_connected(_on_health_lost):
		stats_component.health_changed.connect(_on_health_lost)
		last_hp_value = stats_component.current_hp
	var player = owner as Player
	if !player.begin_battle.is_connected(_on_battle_begin):
		player.begin_battle.connect(_on_battle_begin)

func _on_battle_begin(battleWindow: BattleWindow) -> void:
	current_enemy = battleWindow.enemyref

func _on_health_lost(current: int, max: int) -> void:
	if current_enemy == null:
		return
	if last_hp_value - current > 0:
		var lost_hp = last_hp_value - current
		print("Shock Collar: %d/%d damage taken" %[lost_hp, round(pow(lost_threshold as float, base_artifact.stacks as float) * max as float)])
		if lost_hp as int >= round(pow(lost_threshold as float, base_artifact.stacks as float) * max as float):
			debuff_enemy()
	last_hp_value = current

func debuff_enemy() -> void:
	if current_enemy == null or current_enemy.enemy_attack.is_connected(remove_debuff):
		return
	enemy_str = current_enemy.stats_component.current_str as float * damage_multiplier
	current_enemy.stats_component.modify_stat("strength", -enemy_str)
	current_enemy.enemy_attack.connect(remove_debuff)
	print("SHOCK COLLAR: Enemy strength reduced by %f for the next attack!" % [damage_multiplier])

func remove_debuff() -> void:
	if current_enemy == null:
		return
	current_enemy.enemy_attack.disconnect(remove_debuff)
	current_enemy.stats_component.modify_stat("strength", enemy_str)
	print("SHOCK COLLAR: Debuff removed...")
	
