class_name Enemy extends Unit

var MoveOpportunities = ["left","right","down","up"]

func _ready() -> void:
	var player = %Player
	player.on_player_move.connect(EnemyMove)

func death() -> void:
	pass
	
func attack() -> void:
	pass
	

func EnemyMove() -> void:
	var DuplicateMove = MoveOpportunities.duplicate()
	while !DuplicateMove.is_empty():
		var i = randi_range(0,len(DuplicateMove)-1)
		if move(DuplicateMove.pop_at(i)):
			break;
			
