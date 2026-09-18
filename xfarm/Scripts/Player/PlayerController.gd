# PlayerController.gd

extends Node2D

@onready var PlayerStatus = preload("res://Scripts/Player/PlayerStatus.gd");
@onready var GameController = preload("res://Scripts/System/GameController.gd")

@onready var player: CharacterBody2D = $"../CharacterBody2D"
@onready var PlayerCollision: CollisionShape2D = $"../CharacterBody2D/CollisionShape2D"

#@onready var player: Sprite2D = $"../PlayerSprite"
@onready var GlobalDeltaTime: float = 0;
@onready var CurrentMovementSpeed: int;
@onready var MovementSpeedMultiplier: int;
static var CurrentPlayerState: int;
static var CurrentPlayerDirection: int;

var logger = LogController


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameController.log.LogInputType(self)
	GameController.logGameController.log.LogMessage(self, "Changing Input Type...")
	GameController.input.UpdateControlType(InputTypes.Types.PLAYER);
	GameController.log.LogInputType(self)
	GameController.log.LogPlayerState(self)
	
	CurrentMovementSpeed = 300;
	MovementSpeedMultiplier = 1;
	SetPlayerState(PlayerStatus.State.Idle);
	SetPlayerDirection(PlayerStatus.Direction.Left);
	
	#PlayerStatus.Health = 100
	#PlayerStatus.MaxHealth = 100
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	HandleInput();
	
	# logic guard, if game is paused, the player ceases
	if (GameController.GamePaused()): return
	
	GlobalDeltaTime = delta;

	if (GameController.input.GetControlType() == InputTypes.Types.UI && GameController.GetCurrentGameState() == GameController.GameState.UnPaused):
		GameController.input.UpdateControlType(InputTypes.Types.PLAYER)
	pass;
	
func TakeDamage(DamageValue: float) -> void:
	PlayerStatus.Health -= DamageValue
	if (PlayerStatus.Health <= 0.0):
		PlayerStatus.Health = 0.0;
		pass # dead
	
	pass

# ProcessPlayerInput: Handles logic for moving the player.
# NOTE: Pressing 3 movement options at once doesn't behave as desired but
#		not sure if it's really a problem worth solving. At the moment the player
#		just stops. That's fine for now.
func ProcessPlayerActions():
	#actions include interacting with items/objects
	var current_mouse_position: Vector2 = Vector2.ZERO
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		current_mouse_position = GameController.input.GetMousePosition()

	# Calculate the direction vector from player to mouse position
	var aim_direction: Vector2 = current_mouse_position - global_position
	print(aim_direction)
	if (GameController.input.Interact()):
		logger.LogMessage(self, "test")
		# context, need to know what was interacted with
		# Interact with overlapping object/item
		# 	What if overlapping with more than one? Most recent overlap?
		#	How to find overlapping collision shapes?
		#PlayerCollision.sweep
	pass
		
	pass

func ProcessPlayerMovement():
	if (GameController.input.LeftRightAndDown()):
		MoveDown()
	elif (GameController.input.LeftRightAndUp()):
		MoveUp()
	elif (GameController.input.UpDownAndLeft()):
		MoveLeft()
	elif (GameController.input.UpDownAndRight()):
		MoveRight()
	elif (GameController.input.UpAndDown()):
		SetPlayerState(PlayerStatus.State.Idle)
	elif (GameController.input.LeftAndRight()):
		SetPlayerState(PlayerStatus.State.Idle) 
	elif (GameController.input.UpAndLeft()):
		MoveUpAndLeft()
	elif (GameController.input.UpAndRight()):
		MoveUpAndRight()
	elif (GameController.input.DownAndLeft()):
		MoveDownAndLeft()
	elif (GameController.input.DownAndRight()):
		MoveDownAndRight()
	elif (GameController.input.Up()):
		MoveUp()
	elif (GameController.input.Left()):
		MoveLeft()
	elif (GameController.input.Right()):
		MoveRight()
	elif (GameController.input.Down()):
		MoveDown()
	else:
		SetPlayerState(PlayerStatus.State.Idle);
	pass;

func MoveUp() -> void:
	player.translate(Vector2(0, -1) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Up)

func MoveDown() -> void:
	player.translate(Vector2(0, 1) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Down)

func MoveLeft() -> void:
	player.translate(Vector2(-1, 0) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Left)

func MoveRight() -> void:
	player.translate(Vector2(1, 0) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Right)
	
func MoveUpAndRight() -> void:
	player.translate(Vector2(1, -1) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Right)

func MoveUpAndLeft() -> void:
	player.translate(Vector2(-1, -1) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Left)
	
func MoveDownAndRight() -> void:
	player.translate(Vector2(1, 1) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Right)
	
func MoveDownAndLeft() -> void:
	player.translate(Vector2(-1, 1) * PlayerSpeedCalculation())
	SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Left)

func ProcessUserInterfaceInput() -> void:
	if (Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)):
		# UI controller responsible for this? no?
		# log message for now
		LogController.LogMessage(self, "UI up pressed")
		pass
	elif (Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)):
		LogController.LogMessage(self, "UI left pressed")
		pass
	elif (Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)):
		LogController.LogMessage(self, "UI right pressed")
		pass
	elif (Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)):
		LogController.LogMessage(self, "UI down pressed")
		pass
	else:
		pass
	pass;

# Determines where input will be focused (ie controlling the player or navigating UI)
func HandleInput() -> void:
	#LogController.LogInputType(self, "test")
	if (GameController.input.GetControlType() == InputTypes.Types.PLAYER):
		ProcessPlayerMovement();
	elif (GameController.input.GetControlType() == InputTypes.Types.UI):
		ProcessUserInterfaceInput();
	elif (GameController.input.GetControlType() == InputTypes.Types.NONE):
		pass;
	pass;

func GetPlayerDirection() -> int:
	return CurrentPlayerDirection;

static func GetPlayerState() -> int:
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
