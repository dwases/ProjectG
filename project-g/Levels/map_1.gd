extends Node2D

@onready var player = $Player
@onready var hud = $HUD/StatsUI

func _ready():
	## Level przedstawia sobie te dwa obiekty
	##hud.stats_component = player.get_node("StatsComponent")
	
	## Musisz dodać funkcję setup() w HUD, żeby odświeżyć UI po przypisaniu
	hud.setup(player)
