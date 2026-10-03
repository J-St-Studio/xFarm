# InputController.gd
# Emits input signals for the rest of the program

class_name InputController extends Controller
var event: EventController

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

var ControlType: InputTypes.Types;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	Initialize()

func _process(delta: float) -> void:
	ProcessInput();
	pass
	
func Initialize() -> Controller.State:
	if (!system):
		state = Controller.State.FAIL
		return state
	event = system.GetEventController()
	if (!event):
		state = Controller.State.FAIL
		return state
		
	ControlType = InputTypes.Types.UI
	state = Controller.State.ONLINE
	return state
	
func UpdateControlType(_ControlType: InputTypes.Types) -> void:
	ControlType = _ControlType;
	
func GetControlType() -> int:
	return ControlType;
	
func ProcessInput() -> void:
	PauseKeyPressed()
	LeftMouseButton()
	Confirm()
	Up()
	Down()
	Left()
	Right()
	
func LeftMouseButton() -> bool:
	# update for re-bindable inputs
	var is_left = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)                              
	if (is_left):                                                                                                     
		event.BroadcastInputLeftMousePressed()                                                                              
	return is_left
	
func PauseKeyPressed() -> bool:
	var pause_pressed = Input.is_action_just_pressed(BackInput[GetControlType()])
	if (pause_pressed):
		event.BroadcastInputEscapePressed()
	return pause_pressed

func Up() -> bool:
	var is_up = Input.is_key_pressed(UpInput[GetControlType()])
	if is_up:
		event.BroadcastInputUpPressed()
	return is_up

func Down() -> bool:
	var is_down = Input.is_key_pressed(DownInput[GetControlType()])
	if is_down:
		event.BroadcastInputDownPressed()
	return is_down

func Left() -> bool:
	var is_left = Input.is_key_pressed(LeftInput[GetControlType()])
	if is_left:
		event.BroadcastInputLeftPressed()
	return is_left

func Right() -> bool:
	var is_right = Input.is_key_pressed(RightInput[GetControlType()])
	if is_right:
		event.BroadcastInputRightPressed()
	return is_right

func Confirm():
	var confirm = Input.is_physical_key_pressed(InteractInput[GetControlType()])
	if (confirm):
		event.BroadcastInputConfirmPressed()
	return confirm

func GetMousePosition() -> Vector2:
	return get_global_mouse_position()
	
func _unhandled_input(event):
	pass

func _on_game_controller_set_control_type(ControlType: InputTypes.Types) -> void:
	UpdateControlType(ControlType)
	pass # Replace with function body.
