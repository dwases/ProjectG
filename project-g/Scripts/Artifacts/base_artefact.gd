extends Resource
class_name ArtifactData

@export var id: String = ""
@export var display_name: String = ""
@export var icon: Texture2D
@export var description: String = ""
# Tutaj możesz dodać skrypt, który definiuje zachowanie (Logic)
#@export var effect_script: GDScript
@export var effect_script: BaseArtifactScript
