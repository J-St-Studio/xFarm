# PlayerController.gd

class_name PlayerController extends Node2D
var System = preload("res://Scripts/System/SystemController.gd")

@onready var PlayerState = preload("res://Scripts/Player/PlayerStatus.gd").new();
@onready var player: CharacterBody2D = $CharacterBody2D
@onready var PlayerCollision: CollisionShape2D = $"../CharacterBody2D/CollisionShape2D"

#@onready var player: Sprite2D = $"../PlayerSprite"
@onready var GlobalDeltaTime: float = 0;
@onready var CurrentMovementSpeed: int;
@onready var MovementSpeedMultiplier: int;
static var CurrentPlayerState: int;
static var CurrentPlayerDirection: int;

var log: LogController = LogController.new()
var Game: GameController = System.GetGameController()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	log.LogInputType(self)
	log.message(self, "Changing Input Type...")
	#GameController.input.UpdateControlType(InputTypes.Types.PLAYER);
	log.LogInputType(self)
	log.LogPlayerState(self)
	#CurrentMovementSpeed = PlayerStatus.MoveSpeed;
	MovementSpeedMultiplier = 1;
	SetPlayerState(PlayerStatus.State.Idle);
	SetPlayerDirection(PlayerStatus.Direction.Left);
	
	#PlayerStatus.Health = 100
	#PlayerStatus.MaxHealth = 100
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#HandleInput();
	# logic guard, if game is paused, the player ceases
	if (GameController.GamePaused()): return
	GlobalDeltaTime = delta;
	if (InputController.GetControlType() == InputTypes.Types.UI && GameController.GetCurrentGameState() == GameController.GameState.UnPaused):
		InputController.UpdateControlType(InputTypes.Types.PLAYER)
	pass;
	
func TakeDamage(DamageValue: float) -> void:
	PlayerState.Health -= DamageValue
	if (PlayerState.Health <= 0.0):
		PlayerState.Health = 0.0;
		pass # dead
	pass

func ProcessPlayerActions():
	#actions include interacting with items/objects
	var current_mouse_position: Vector2 = Vector2.ZERO
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		current_mouse_position = InputController.new().GetMousePosition()

	# Calculate the direction vector from player to mouse position
	var aim_direction: Vector2 = current_mouse_position - global_position
	print(aim_direction)
	if (InputController.new().Interact()):
		self.log.LogMessage(self, "test")
		# context, need to know what was interacted with
		# Interact with overlapping object/item
		# 	What if overlapping with more than one? Most recent overlap?
		#	How to find overlapping collision shapes?
		#PlayerCollision.sweep
	pass

func ProcessUserInterfaceInput() -> void:
	if (Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)):
		# UI controller responsible for this? no?
		# log message for now
		self.log.message(self, "UI up pressed")
		pass
	elif (Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)):
		self.log.message(self, "UI left pressed")
		pass
	elif (Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)):
		self.log.message(self, "UI right pressed")
		pass
	elif (Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)):
		self.log.message(self, "UI down pressed")
		pass
	else:
		pass
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
	return PlayerState.MoveSpeed * PlayerState.MoveSpeedM * GlobalDeltaTime;

func _on_game_controller_game_paused() -> void:
	print("game paused")
	pass # Replace with function body.

func _on_input_controller_up_pressed() -> void:
	if (GameController.GameUnPaused()):
		player.translate(Vector2(0, -1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Up)
	
func _on_input_controller_right_pressed() -> void:
	if (GameController.GameUnPaused()):
		player.translate(Vector2(1, 0) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Right)

func _on_input_controller_left_pressed() -> void:
	if (GameController.GameUnPaused()):
		player.translate(Vector2(-1, 0) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Left)

func _on_input_controller_down_pressed() -> void:
	if (GameController.GameUnPaused()):
		player.translate(Vector2(0, 1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(PlayerStatus.State.Moving, PlayerStatus.Direction.Down)

func _on_input_controller_left_mouse_press() -> void:
	print("left mouse button clicked!!")
	var item = preload("res://Scenes/Items/Item.tscn")
	var location = Vector2(0, 0)
	Game.SpawnItem(item, location)
	pass # Replace with function body.
