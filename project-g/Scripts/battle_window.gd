class_name BattleWindow extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@export var playerref: Player
@export var enemyref: Enemy
# Called when the node enters the scene tree for the first time.
func _init(player: Player, enemy: Enemy) -> void:
	playerref=player
	enemyref=enemy
func _ready() -> void:
	print("Battle window spawned.")
	canvas_layer.hide()
	
