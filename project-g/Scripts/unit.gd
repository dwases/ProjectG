@abstract 
class_name Unit extends Node2D

@onready var rc_down: RayCast2D = $RCDown
@onready var rc_left: RayCast2D = $RCLeft
@onready var rc_right: RayCast2D = $RCRight
@onready var rc_up: RayCast2D = $RCUp

signal on_player_move
var IsPlayer: bool = false

func AmIPlayer() -> void:
	IsPlayer = true

@abstract
func death() -> void
	
@abstract
func attack(player_component: StatsComponent) -> void
	
func _init() -> void:
	var is_in_combat = false

func move(direction) -> bool:
	if direction == "right":
		if !rc_right.is_colliding():
			position.x += 32
			if IsPlayer:
				EnemyManager.move_enemies()
				#on_player_move.emit()
			return true
	elif direction == "left":
		if !rc_left.is_colliding():	
			position.x -= 32
			if IsPlayer:
				EnemyManager.move_enemies()
			return true
	elif direction == "up":
		if !rc_up.is_colliding():
			position.y -= 32
			if IsPlayer:
				EnemyManager.move_enemies()
			return true
	elif direction == "down":
		if !rc_down.is_colliding():
			position.y += 32
			if IsPlayer:
				EnemyManager.move_enemies()
			return true
	return false
