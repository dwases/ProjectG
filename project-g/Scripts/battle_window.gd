class_name BattleWindow extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@export var playerref: Player
@export var enemyref: Enemy

@onready var enemy_texture: Sprite2D = $CanvasLayer/ColorRect/EnemyTexture
@onready var player_texture: Sprite2D = $CanvasLayer/ColorRect/PlayerTexture


# Called when the node enters the scene tree for the first time.
func initialize(player: Player, enemy: Enemy) -> void:
	playerref=player
	enemyref=enemy
	#player_texture.texture(playerref.stats_component.current_big_texture)
	
func _ready() -> void:
	print("Battle window spawned.")
	#canvas_layer.hide()
	
