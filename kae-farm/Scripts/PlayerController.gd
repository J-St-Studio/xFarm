extends Node2D

var InputController = preload("res://Scripts/InputController.gd");
var InputTypes = preload("res://Scripts/InputTypes.gd");
var PlayerStatus = preload("res://Scripts/PlayerStatus.gd");

@onready var player: Sprite2D = $"../PlayerSprite"
@onready var GlobalDeltaTime: float = 0;
@onready var CurrentMovementSpeed: int;
@onready var MovementSpeedMultiplier: int;
@onready var CurrentPlayerState: int;
@onready var CurrentPlayerDirection: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("PlayerController: Input type -> ", InputController.GetControlType());
	print("PlayerController: Changing Input Type...");

	InputController.UpdateControlType(InputTypes.Types.PLAYER);
	print("PlayerController: Input type -> ", InputController.GetControlType());

	CurrentMovementSpeed = 300;
	MovementSpeedMultiplier = 1;
	SetPlayerState(PlayerStatus.State.Idle);
	SetPlayerDirection(PlayerStatus.Direction.Left);
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDeltaTime = delta;
	HandleInput();
	
	#print("PlayerController: ", InputController.GetControlType())
	print("PlayerState: ", CurrentPlayerState)
	print("PlayerDirection: ", CurrentPlayerDirection)

	if (InputController.GetControlType() == InputTypes.Types.UI):
		InputController.UpdateControlType(InputTypes.Types.PLAYER)
	pass;

# ProcessPlayerInput: Handles logic for moving the player.
# NOTE: Pressing 3 movement options at once doesn't behave as desired but
#		not sure if it's really a problem worth solving. At the moment the player
#		just stops. That's fine for now.
func ProcessPlayerInput() -> void:
	if (InputController.MovingUpAndDown()):
		SetPlayerState(PlayerStatus.State.Idle)
	
	elif (InputController.MovingLeftAndRight()):
		SetPlayerState(PlayerStatus.State.Idle)

	elif (InputController.MovingUpAndLeft()):
		player.translate(Vector2(-1, -1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Left)

	elif (InputController.MovingUpAndRight()):
		player.translate(Vector2(1, -1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Right)

	elif (InputController.MovingDownAndLeft()):
		player.translate(Vector2(-1, 1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Left)

	elif (InputController.MovingDownAndRight()):
		player.translate(Vector2(1, 1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Right)

	elif (InputController.MovingUp()):
		MovePlayerUp()

	elif (InputController.MovingLeft()):
		MovePlayerLeft()
		
	elif (InputController.MovingRight()):
		MovePlayerRight()

	elif (InputController.MovingDown()):
		MovePlayerDown()

	else:
		SetPlayerState(PlayerStatus.State.Idle);
	pass;

func MovePlayerUp() -> void:
	player.translate(Vector2(0, -1) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Up)

func MovePlayerDown() -> void:
	player.translate(Vector2(0, 1) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Down)

func MovePlayerLeft() -> void:
	player.translate(Vector2(-1, 0) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Left)

func MovePlayerRight() -> void:
	player.translate(Vector2(1, 0) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Right)

func ProcessUserInterfaceInput() -> void:
	if (Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)):
		pass
	elif (Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)):
		pass
	elif (Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)):
		pass
	elif (Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)):
		pass
	else:
		pass
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

func GetPlayerDirection() -> int:
	return CurrentPlayerDirection;

func GetPlayerState() -> int:
	return CurrentPlayerState;

func SetPlayerState(state: int) -> void:
	CurrentPlayerState = state;

func SetPlayerDirection(direction: int) -> void:
	CurrentPlayerDirection = direction;

func SetPlayerStateAndDirection(state: int, direction: int) -> void:
	CurrentPlayerState = state;
	CurrentPlayerDirection = direction;
	pass;

func PlayerSpeedCalculation() -> float:
	return CurrentMovementSpeed * MovementSpeedMultiplier * GlobalDeltaTime;
