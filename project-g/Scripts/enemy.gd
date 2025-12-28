class_name Enemy extends Unit

var MoveOpportunities = ["left","right","down","up"]
var moving: bool = false
signal move_finished

@onready
var stats_component: StatsComponent = $StatsComponent

func _ready() -> void:
	EnemyManager.add_enemy(self)

func death() -> void:
	pass
	
func attack(player_component) -> void:
	print("Michal jest gejem")
	var attacks: Array[String] = ["light","light","light","medium","medium","heavy"]
	var selected_attack : String = attacks.pick_random()
	if stats_component.try_hit(selected_attack,player_component.current_dex):
		if !player_component.try_dodge():
			player_component.take_damage(stats_component.calculate_damage(selected_attack))
	

func EnemyMove() -> void:
	var DuplicateMove = MoveOpportunities.duplicate()
	moving = true
	while !DuplicateMove.is_empty():
		var i = randi_range(0,len(DuplicateMove)-1)
		if move(DuplicateMove.pop_at(i)):
			break;
	moving = false
		
