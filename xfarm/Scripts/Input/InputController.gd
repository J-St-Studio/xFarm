# InputController.gd
# might re-work this idea/mess

class_name InputController extends Node2D

var ControlType: int = 0 # Initialize it for safety

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ControlType = InputTypes.Types.UI
	LogController.LogInputType(self)
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
	
func UpdateControlType(_ControlType: int) -> void:
	ControlType = _ControlType;
	
func GetControlType() -> int:
	return ControlType;
	
func PauseKeyPressed() -> bool:
	return Input.is_action_just_pressed("ui_cancel")


# rename all bool return functions to Is naming convention
# ie: IsMovingUp()
# Should refactor naming to be input generic? PressingUp() etc..
# Different logic for UI? (is_action_just_pressed better for UI and others for movement?)
func Up() -> bool:
	return Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)

func Down() -> bool:
	return Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)

func Left() -> bool:
	return Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)

func Right() -> bool:
	return Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)

func LeftAndRight() -> bool:
	return Left() && Right()

func UpAndDown() -> bool:
	return Up() && Down()

func UpAndRight() -> bool:
	return Up() && Right()

func UpAndLeft() -> bool:
	return Up() && Left()

func DownAndLeft() -> bool:
	return Down() && Left()

func DownAndRight() -> bool:
	return Down() && Right()

func LeftRightAndDown() -> bool:
	return Left() && Right() && Down()

func LeftRightAndUp() -> bool:
	return Left() && Right() && Up()

func UpDownAndLeft() -> bool:
	return Up() && Down() && Left()

func UpDownAndRight() -> bool:
	return Up() && Down() && Right()

func Interact():
	return Input.is_physical_key_pressed(KEY_E)

func GetMousePosition() -> Vector2:
	return get_global_mouse_position()
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		print(event)
