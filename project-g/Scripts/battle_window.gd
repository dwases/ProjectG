extends Node2D

@onready var battle_camera: Camera2D = $BattleCamera


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	battle_camera.make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
