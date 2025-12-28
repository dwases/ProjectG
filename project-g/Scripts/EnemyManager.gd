extends Node

var enemies: Array[Enemy]
var localEnemies = enemies.duplicate()

func add_enemy(enemy: Enemy) -> void:
	enemies.append(enemy)
func remove_enemy(enemy: Enemy)->void:
	enemies.remove_at(enemies.find(enemy))

func move_enemies() -> void:
	localEnemies = enemies.duplicate()
	while localEnemies.size() > 0:
		localEnemies[0].EnemyMove()
		localEnemies.remove_at(0)
