# InputController.gd
# Emits input signals for the rest of the program

class_name InputController extends Node2D

signal up_pressed
signal down_pressed
signal left_pressed
signal right_pressed
signal confirm_pressed
signal pause_button_pressed
signal left_mouse_press
signal right_mouse_press

static var ControlType: InputTypes.Types = InputTypes.Types.UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ControlType = InputTypes.Types.UI
	LogController.LogInputType(self)
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	ProcessInput();
	pass
	
static func UpdateControlType(_ControlType: InputTypes.Types) -> void:
	ControlType = _ControlType;
	
static func GetControlType() -> int:
	return ControlType;
	
func ProcessInput() -> void:
	PauseKeyPressed()
	Interact()
	Up()
	Down()
	Left()
	Right()
	
func PauseKeyPressed() -> bool:
	var pause_pressed = Input.is_action_just_pressed("ui_cancel")
	if (pause_pressed):
		pause_button_pressed.emit()
	return pause_pressed

func Up() -> bool:
	var is_up = Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)
	if is_up:
		up_pressed.emit()
	return is_up

func Down() -> bool:
	var is_down = Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)
	if is_down:
		down_pressed.emit()
	return is_down

func Left() -> bool:
	var is_left = Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)
	if is_left:
		left_pressed.emit()
	return is_left

func Right() -> bool:
	var is_right = Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)
	if is_right:
		right_pressed.emit()
	return is_right

func Interact():
	var confirm = Input.is_physical_key_pressed(KEY_E)
	if (confirm):
		confirm_pressed.emit()
	return confirm

func GetMousePosition() -> Vector2:
	return get_global_mouse_position()
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		print(event)

func _on_game_controller_set_control_type(ControlType: InputTypes.Types) -> void:
	UpdateControlType(ControlType)
	pass # Replace with function body.
