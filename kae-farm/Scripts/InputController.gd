extends Node2D

var InputTypes = preload("res://Scripts/InputTypes.gd")

# controls where input is going to be directed (player or UI)

# basically this script will be responsible for housing the variables
# that all other controllers will access for knowing what is going on with input

# IE the player controller will pull from here to update it's "CurrentControlType"

static var ControlType: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ControlType = InputTypes.Types.UI
	print("InputController: Control type -> ", ControlType)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
static func UpdateControlType(_ControlType: int) -> void:
	ControlType = _ControlType;
	
static func GetControlType() -> int:
	return ControlType;
