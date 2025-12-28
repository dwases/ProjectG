class_name ArtifactBomb
extends BaseArtifactScript

var current_enemy: Enemy
var last_hp_value: int
var total_lost: int
const lost_threshold: int = 15
const damage_multiplier: float = 0.5

func setup_listeners() -> void:
	if !stats_component.health_changed.is_connected(_on_health_lost):
		stats_component.health_changed.connect(_on_health_lost)
		last_hp_value = stats_component.current_hp
	var player = owner as Player
	if !player.begin_battle.is_connected(_on_battle_begin):
		player.begin_battle.connect(_on_battle_begin)

func _on_health_lost(current: int, max: int) -> void:
	if current_enemy == null:
		return
	if last_hp_value - current > 0:
		total_lost += last_hp_value - current
		print("Bomb charge: %d/%d damage taken" %[total_lost, lost_threshold])
		if total_lost >= lost_threshold:
			explode()
			total_lost = 0
	last_hp_value = current

func explode() -> void:
	if current_enemy == null:
		return
	current_enemy.get_node("StatsComponent").take_damage(damage_multiplier * total_lost as float * base_artifact.stacks as float)
	print("BOMB: EXPLODE FOR %d DAMAGE" % [damage_multiplier * total_lost as float * base_artifact.stacks as float])

func _on_battle_begin(battleWindow: BattleWindow) -> void:
	current_enemy = battleWindow.enemyref
