class_name Enemy extends Unit

var MoveOpportunities = ["left","right","down","up"]
var moving: bool = false
signal move_finished

func _ready() -> void:
	EnemyManager.add_enemy(self)

func death() -> void:
	pass
	
func attack() -> void:
	pass
	

func EnemyMove() -> void:
	var DuplicateMove = MoveOpportunities.duplicate()
	moving = true
	while !DuplicateMove.is_empty():
		var i = randi_range(0,len(DuplicateMove)-1)
		if move(DuplicateMove.pop_at(i)):
			break;
	moving = false
		
