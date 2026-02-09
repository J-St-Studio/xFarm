# InputController.gd

extends Node2D
var InputTypes = preload("res://Scripts/InputTypes.gd")
var LogController = preload("res://Scripts/LogController.gd")

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
static func MovingUp() -> bool:
	return Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)

static func MovingDown() -> bool:
	return Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)

static func MovingLeft() -> bool:
	return Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)

static func MovingRight() -> bool:
	return Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)

static func MovingLeftAndRight() -> bool:
	return (Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)) && (Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D))

static func MovingUpAndDown() -> bool:
	return (Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)) && (Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S))

static func MovingUpAndRight() -> bool:
	return (Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)) && (Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D))

static func MovingUpAndLeft() -> bool:
	return (Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)) && (Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A))

static func MovingDownAndLeft() -> bool:
	return (Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)) && (Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A))

static func MovingDownAndRight() -> bool:
	return (Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)) && (Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D))

static func MovingLeftRightAndDown() -> bool:
	return (Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)) && (Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)) && (Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S))

static func MovingLeftRightAndUp() -> bool:
	return MovingLeft() && MovingRight() && MovingUp()

static func MovingUpDownAndLeft() -> bool:
	return MovingUp() && MovingDown() && MovingLeft()

static func MovingUpDownAndRight() -> bool:
	return MovingUp() && MovingDown() && MovingRight()



static func Interact():
	return Input.is_action_pressed("ui_accept") || Input.is_physical_key_pressed(KEY_E)
	
	
	
	
	
