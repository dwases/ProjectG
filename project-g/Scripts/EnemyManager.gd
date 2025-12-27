extends Node

var enemies: Array[Enemy]
var localEnemies = enemies.duplicate()

func add_enemy(enemy: Enemy) -> void:
	enemies.append(enemy)

func move_enemies() -> void:
	localEnemies = enemies.duplicate()
	while localEnemies.size() > 0:
		localEnemies[0].EnemyMove()
		while(localEnemies[0].moving):
			await get_tree().process_frame
		localEnemies.remove_at(0)
