extends Resource
class_name ArtifactData

@export var id: String = ""
@export var display_name: String = ""
@export var icon: Texture2D
@export var description: String = ""
# Tutaj możesz dodać skrypt, który definiuje zachowanie (Logic)
#@export var effect_script: GDScript
@export var effect_script: BaseArtifactScript

var owner: Node = null

func _init(getOwner, getId, getName, getIcon, getDesc, getScript) -> void:
	print("Creating new artifact...\n%s\n%s\n%s\n" %[getOwner, getId, getScript])
	owner = getOwner
	id = getId
	display_name = getName
	icon = getIcon
	description = getDesc
	effect_script = getScript
	
	# Powiadom ArtifactScript o jego przynależności
	effect_script.set_artifact_owner(owner)
