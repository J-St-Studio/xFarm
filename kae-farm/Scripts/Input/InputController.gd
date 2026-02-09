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
static func MovingUp() -> bool:
	return Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)

static func MovingDown() -> bool:
	return Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)

static func MovingLeft() -> bool:
	return Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)

static func MovingRight() -> bool:
	return Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)

static func MovingLeftAndRight() -> bool:
	return MovingLeft() && MovingRight()

static func MovingUpAndDown() -> bool:
	return MovingUp() && MovingDown()

static func MovingUpAndRight() -> bool:
	return MovingUp() && MovingRight()

static func MovingUpAndLeft() -> bool:
	return MovingUp() && MovingLeft()

static func MovingDownAndLeft() -> bool:
	return MovingDown() && MovingLeft()

static func MovingDownAndRight() -> bool:
	return MovingDown() && MovingRight()

static func MovingLeftRightAndDown() -> bool:
	return MovingLeft() && MovingRight() && MovingDown()

static func MovingLeftRightAndUp() -> bool:
	return MovingLeft() && MovingRight() && MovingUp()

static func MovingUpDownAndLeft() -> bool:
	return MovingUp() && MovingDown() && MovingLeft()

static func MovingUpDownAndRight() -> bool:
	return MovingUp() && MovingDown() && MovingRight()

static func Interact():
	return Input.is_action_pressed("ui_accept") || Input.is_physical_key_pressed(KEY_E)
	
	
	
	
	
