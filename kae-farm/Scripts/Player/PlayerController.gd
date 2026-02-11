# PlayerController.gd

extends Node2D

@onready var InputController = preload("res://Scripts/Input/InputController.gd");
@onready var InputTypes = preload("res://Scripts/Input/InputTypes.gd");
@onready var PlayerStatus = preload("res://Scripts/Player/PlayerStatus.gd");
@onready var GameController = preload("res://Scripts/System/GameController.gd")
@onready var LogController = preload("res://Scripts/System/LogController.gd")

@onready var player: CharacterBody2D = $"../CharacterBody2D"
@onready var PlayerCollision: CollisionShape2D = $"../CharacterBody2D/CollisionShape2D"

#@onready var player: Sprite2D = $"../PlayerSprite"
@onready var GlobalDeltaTime: float = 0;
@onready var CurrentMovementSpeed: int;
@onready var MovementSpeedMultiplier: int;
static var CurrentPlayerState: int;
static var CurrentPlayerDirection: int;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LogController.LogInputType(self)
	LogController.LogMessage(self, "Changing Input Type...")
	InputController.UpdateControlType(InputTypes.Types.PLAYER);
	LogController.LogInputType(self)
	LogController.LogPlayerState(self)
	
	CurrentMovementSpeed = 300;
	MovementSpeedMultiplier = 1;
	SetPlayerState(PlayerStatus.State.Idle);
	SetPlayerDirection(PlayerStatus.Direction.Left);
	
	#PlayerStatus.Health = 100
	#PlayerStatus.MaxHealth = 100
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# logic guard, if game is paused, the player ceases
	if (GameController.GetCurrentGameState() == GameController.GameState.Paused): return
	
	GlobalDeltaTime = delta;
	HandleInput();

	if (InputController.GetControlType() == InputTypes.Types.UI && GameController.GetCurrentGameState() == GameController.GameState.UnPaused):
		InputController.UpdateControlType(InputTypes.Types.PLAYER)
	pass;
	
func TakeDamage(DamageValue: float) -> void:
	pass

# ProcessPlayerInput: Handles logic for moving the player.
# NOTE: Pressing 3 movement options at once doesn't behave as desired but
#		not sure if it's really a problem worth solving. At the moment the player
#		just stops. That's fine for now.
func ProcessPlayerInput() -> void:
	ProcessPlayerMovement() #PlayerMovement.ProcessMovement()?
	ProcessPlayerActions() #PlayerMovement.ProcessActions()? // dont over-architect/over-design
	
func ProcessPlayerActions():
	#actions include interacting with items/objects
	if (InputController.Interact()):
		# context, need to know what was interacted with
		# Interact with overlapping object/item
		# 	What if overlapping with more than one? Most recent overlap?
		#	How to find overlapping collision shapes?
		#PlayerCollision.sweep
		
		pass
	pass

func ProcessPlayerMovement():
	if (InputController.LeftRightAndDown()):
		MoveDown()
	elif (InputController.LeftRightAndUp()):
		MoveUp()
	elif (InputController.UpDownAndLeft()):
		MoveLeft()
	elif (InputController.UpDownAndRight()):
		MoveRight()
	elif (InputController.UpAndDown()):
		SetPlayerState(PlayerStatus.State.Idle)
	elif (InputController.LeftAndRight()):
		SetPlayerState(PlayerStatus.State.Idle) 
	elif (InputController.UpAndLeft()):
		MoveUpAndLeft()
	elif (InputController.UpAndRight()):
		MoveUpAndRight()
	elif (InputController.DownAndLeft()):
		MoveDownAndLeft()
	elif (InputController.DownAndRight()):
		MoveDownAndRight()
	elif (InputController.Up()):
		MoveUp()
	elif (InputController.Left()):
		MoveLeft()
	elif (InputController.Right()):
		MoveRight()
	elif (InputController.Down()):
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
	LogController.LogInputType(self, HandleInput, "test")
	if (InputController.GetControlType() == InputTypes.Types.PLAYER):
		ProcessPlayerInput();
	elif (InputController.GetControlType() == InputTypes.Types.UI):
		ProcessUserInterfaceInput();
	elif (InputController.GetControlType() == InputTypes.Types.NONE):
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
