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
	player_texture.texture = playerref.stats_component.current_big_texture
	enemy_texture.texture = enemyref.stats_component.current_big_texture
	
func _ready() -> void:
	print("Battle window spawned.")
	#canvas_layer.hide()
	
func attack_requested(type: String) -> void:
	if playerref.stats_component.try_hit(type,enemyref.stats_component.current_dex):
		if !enemyref.stats_component.try_dodge():
			enemyref.stats_component.take_damage(playerref.stats_component.calculate_damage(type))
	enemyref.attack(playerref.stats_component)
	
#to na dole bedzie w enemy
#var animation_name = "enemy_"
#animation_name += selected_attack
#animation_name += "_attack"
