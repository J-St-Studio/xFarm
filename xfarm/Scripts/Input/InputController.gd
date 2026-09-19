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

const UI_CANCEL = "ui_cancel"

@export var InteractInput = {
	InputTypes.Types.PLAYER: KEY_E, 
	InputTypes.Types.UI: KEY_E
};
@export var LeftInput = {
	InputTypes.Types.PLAYER: KEY_A, 
	InputTypes.Types.UI: KEY_A
};
@export var UpInput = {
	InputTypes.Types.PLAYER: KEY_W,
	InputTypes.Types.UI: KEY_W,
};
@export var DownInput = {
	InputTypes.Types.PLAYER: KEY_S,
	InputTypes.Types.UI: KEY_S
};
@export var RightInput = {
	InputTypes.Types.PLAYER: KEY_D,
	InputTypes.Types.UI: KEY_D
};

@export var BackInput = {
	InputTypes.Types.PLAYER: UI_CANCEL,
	InputTypes.Types.UI: UI_CANCEL
};

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
	LeftMouseButton()
	Interact()
	Up()
	Down()
	Left()
	Right()

func LeftMouseButton() -> bool:
	# update for re-bindable inputs
	var is_left = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)                              
	if (is_left):                                                                                                     
		left_mouse_press.emit()                                                                                       
	return is_left
	
func PauseKeyPressed() -> bool:
	var pause_pressed = Input.is_action_just_pressed(BackInput[InputController.GetControlType()])
	if (pause_pressed):
		pause_button_pressed.emit()
	return pause_pressed

func Up() -> bool:
	var is_up = Input.is_key_pressed(UpInput[InputController.GetControlType()])
	if is_up:
		up_pressed.emit()
	return is_up

func Down() -> bool:
	var is_down = Input.is_key_pressed(DownInput[InputController.GetControlType()])
	if is_down:
		down_pressed.emit()
	return is_down

func Left() -> bool:
	var is_left = Input.is_key_pressed(LeftInput[InputController.GetControlType()])
	if is_left:
		left_pressed.emit()
	return is_left

func Right() -> bool:
	var is_right = Input.is_key_pressed(RightInput[InputController.GetControlType()])
	if is_right:
		right_pressed.emit()
	return is_right

func Interact():
	var confirm = Input.is_physical_key_pressed(InteractInput[InputController.GetControlType()])
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
