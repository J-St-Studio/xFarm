extends Node2D

var InputController = preload("res://Scripts/InputController.gd");
var InputTypes = preload("res://Scripts/InputTypes.gd");


@onready var player: Sprite2D = $"../PlayerSprite"
@onready var GlobalDeltaTime: float = 0;
@onready var CurrentMovementSpeed: int;
@onready var MovementSpeedMultiplier: int;

enum PlayerState {
	Idle,
	Moving,
	Busy,
	Dead,
}

enum PlayerDirection {
	None,
	Up,
	Down,
	Left,
	Right,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("PlayerController: Input type -> ", InputController.GetControlType());
	print("PlayerController: Changing Input Type...");
	InputController.UpdateControlType(InputTypes.Types.PLAYER);
	print("PlayerController: Input type -> ", InputController.GetControlType());
	CurrentMovementSpeed = 300;
	MovementSpeedMultiplier = 1;
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDeltaTime = delta;
	HandleInput();
	UpdatePlayerState();
	
	print("PlayerController: ", InputController.GetControlType())
	
	
	if (InputController.GetControlType() == InputTypes.Types.UI):
		InputController.UpdateControlType(InputTypes.Types.PLAYER)
	pass;
	
func UpdatePlayerState() -> void:
	pass;
	
func UpdatePlayerControlType() -> void:
	pass;

func PlayerSpeedCalculation() -> float:
	return CurrentMovementSpeed * MovementSpeedMultiplier * GlobalDeltaTime;

# NOTES: Should the player controller handle playing animations?
#		Does that make sense to couple together?
func ProcessPlayerInput() -> void:
	if (Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)):
		player.translate(Vector2(0, -1) * PlayerSpeedCalculation());
		
	if (Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)):
		player.translate(Vector2(-1, 0) * PlayerSpeedCalculation());
		
	if (Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)):
		player.translate(Vector2(1, 0) * PlayerSpeedCalculation());
		
	if (Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)):
		player.translate(Vector2(0, 1) * PlayerSpeedCalculation());
	pass;

func ProcessUserInterfaceInput() -> void:
	pass;

# Determines where input will be focused (ie controlling the player or navigating UI)
func HandleInput() -> void:
	if (InputController.GetControlType() == InputTypes.Types.PLAYER):
		ProcessPlayerInput();
	elif (InputController.GetControlType() == InputTypes.Types.UI):
		ProcessUserInterfaceInput();
	elif (InputController.GetControlType() == InputTypes.Types.NONE):
		pass;
	pass;
