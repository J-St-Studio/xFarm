# InputController.gd
# might re-work this idea/mess

extends Node2D
var InputTypes = preload("res://Scripts/Input/InputTypes.gd")
var LogController = preload("res://Scripts/System/LogController.gd")

static var ControlType: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ControlType = InputTypes.Types.UI
	LogController.LogInputType(self)
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
	
static func UpdateControlType(_ControlType: int) -> void:
	ControlType = _ControlType;
	
static func GetControlType() -> int:
	return ControlType;
	
static func PauseKeyPressed() -> bool:
	return Input.is_action_just_pressed("ui_cancel")


# rename all bool return functions to Is naming convention
# ie: IsMovingUp()
# Should refactor naming to be input generic? PressingUp() etc..
# Different logic for UI? (is_action_just_pressed better for UI and others for movement?)
static func Up() -> bool:
	return Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)

static func Down() -> bool:
	return Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)

static func Left() -> bool:
	return Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)

static func Right() -> bool:
	return Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)

static func LeftAndRight() -> bool:
	return Left() && Right()

static func UpAndDown() -> bool:
	return Up() && Down()

static func UpAndRight() -> bool:
	return Up() && Right()

static func UpAndLeft() -> bool:
	return Up() && Left()

static func DownAndLeft() -> bool:
	return Down() && Left()

static func DownAndRight() -> bool:
	return Down() && Right()

static func LeftRightAndDown() -> bool:
	return Left() && Right() && Down()

static func LeftRightAndUp() -> bool:
	return Left() && Right() && Up()

static func UpDownAndLeft() -> bool:
	return Up() && Down() && Left()

static func UpDownAndRight() -> bool:
	return Up() && Down() && Right()

static func Interact():
	return Input.is_action_pressed("ui_accept") || Input.is_physical_key_pressed(KEY_E)
	
	
	
	
	
