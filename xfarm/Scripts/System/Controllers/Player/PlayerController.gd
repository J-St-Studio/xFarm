# PlayerController.gd
class_name PlayerController extends Controller
var system: System = System.Get()

var event: EventController
var game: GameController

@onready var player_scene = preload("res://Scenes/player.tscn");

var playerLocationOneShot: OneShot;
var GlobalDeltaTime: float = 0;
var CurrentMovementSpeed: int;
var MovementSpeedMultiplier: int;
var CurrentPlayerState: int;
var CurrentPlayerDirection: int;

var player: Player = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	Initialize()
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if (GC.GamePaused()): return
	SpawnPlayer()
	GlobalDeltaTime = delta;
	return
	
func Initialize() -> Controller.State:
	if (!system):
		state = Controller.State.FAIL
		return state
	
	event = system.GetEventController()
	game = system.GetGameController()
	
	if (!event or !game):
		state = Controller.State.FAIL
		return state
	
	ConnectSignals ({
		event.input_confirm_pressed: OnConfirmPressed,
		event.input_escape_pressed: OnEscapePressed,
		event.input_up_pressed: OnUpPressed,
		event.input_down_pressed: OnDownPressed,
		event.input_left_pressed: OnLeftPressed,
		event.input_right_pressed: OnRightPressed,
		event.input_left_mouse_pressed: OnLeftMousePressed,
		event.input_right_mouse_pressed: OnRightMousePressed
	})
	
	state = Controller.State.ONLINE
	return state
	
func SpawnPlayer() -> void:
	if (player): return
	player = player_scene.instantiate()
	add_child(player)
	SetPlayerState(Player.State.Idle);
	SetPlayerDirection(Player.Direction.Left);

func ProcessPlayerActions():
	#actions include interacting with items/objects
	var current_mouse_position: Vector2 = Vector2.ZERO
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		current_mouse_position = system.GetInputController().GetMousePosition()
	# Calculate the direction vector from player to mouse position
	var aim_direction: Vector2 = current_mouse_position - global_position
	#print(aim_direction)
	pass

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
	return player.MoveSpeed * player.MoveSpeedM * GlobalDeltaTime;

func OnConfirmPressed() -> void:
	return

func OnEscapePressed() -> void:
	#ask_to_pause_game.emit()
	pass # Replace with function body.

func OnUpPressed() -> void:
	if (system.GetGameController().GameUnPaused()):
		player.translate(Vector2(0, -1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(player.State.Moving, player.Direction.Up)

func OnDownPressed() -> void:
	if (game.GameUnPaused()):
		player.translate(Vector2(0, 1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(player.State.Moving, player.Direction.Down)

func OnRightPressed() -> void:
	if (game.GameUnPaused()):
		player.translate(Vector2(1, 0) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(player.State.Moving, player.Direction.Right)

func OnLeftPressed() -> void:
	if (game.GameUnPaused()):
		player.translate(Vector2(-1, 0) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(player.State.Moving, player.Direction.Left)

func OnLeftMousePressed() -> void:
	#EC.BroadcastSpawnItem(item, location)
	pass # Replace with function body.

func OnRightMousePressed() -> void:
	return
