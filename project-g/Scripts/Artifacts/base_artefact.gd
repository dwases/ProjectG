extends Resource
class_name ArtifactData

@export var id: String = ""
@export var display_name: String = ""
@export var icon: Texture2D
@export var description: String = ""
# Tutaj możesz dodać skrypt, który definiuje zachowanie (Logic)
@export var effect_script: BaseArtifactScript

var stacks: int = 1
var owner: Node = null

signal artifact_stacks_gained(gained: int, current_stacks: int)

# !!! NIE DODWAWAĆ _INIT !!!

# Powiadom ArtifactScript o jego przynależności
func setOwner(getOwner: Node) -> void:
	owner = getOwner
	effect_script.set_artifact_owner(owner, self)

func setData(getOwner, getId, getName, getIcon, getDesc, getScript) -> void:
	print("Creating new artifact...\n")
	owner = getOwner
	id = getId
	display_name = getName
	icon = getIcon
	description = getDesc
	effect_script = getScript
	setOwner(owner)

func addStacks(add: int = 1) -> void:
	stacks += add
	artifact_stacks_gained.emit(add, stacks)
