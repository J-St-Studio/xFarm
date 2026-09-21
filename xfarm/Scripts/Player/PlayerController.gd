# PlayerController.gd

class_name PlayerController extends Controller

var IC: InputController;

@onready var player_scene = preload("res://Scenes/player.tscn");

var GlobalDeltaTime: float = 0;
var CurrentMovementSpeed: int;
var MovementSpeedMultiplier: int;
var CurrentPlayerState: int;
var CurrentPlayerDirection: int;

var player: Player = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SystemController.GetLogController().message(self, "online")
	ConnectInputSignals()
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if (GC.GamePaused()): return
	SpawnPlayer()
	GlobalDeltaTime = delta;
	
	pass;

func ConnectInputSignals() -> void:
	var IC = SystemController.GetInputController()
	IC.up_pressed.connect(OnInputControllerUpPressed)
	IC.down_pressed.connect(OnInputControllerDownPressed)
	IC.left_pressed.connect(OnInputControllerLeftPressed)
	IC.right_pressed.connect(OnInputControllerRightPressed)
	IC.pause_button_pressed.connect(OnInputControllerPausePressed)

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
		current_mouse_position = Core.GetSystemController().GetInputController().GetMousePosition()
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

func OnInputControllerPausePressed() -> void:
	#ask_to_pause_game.emit()
	pass # Replace with function body.

func OnInputControllerUpPressed() -> void:
	if (Core.GetSystemController().GetGameController().GameUnPaused()):
		player.translate(Vector2(0, -1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(player.State.Moving, player.Direction.Up)

func OnInputControllerDownPressed() -> void:
	if (Core.GetSystemController().GetGameController().GameUnPaused()):
		player.translate(Vector2(0, 1) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(player.State.Moving, player.Direction.Down)

func OnInputControllerRightPressed() -> void:
	if (Core.GetSystemController().GetGameController().GameUnPaused()):
		player.translate(Vector2(1, 0) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(player.State.Moving, player.Direction.Right)

func OnInputControllerLeftPressed() -> void:
	if (Core.GetSystemController().GetGameController().GameUnPaused()):
		player.translate(Vector2(-1, 0) * PlayerSpeedCalculation())
		SetPlayerStateAndDirection(player.State.Moving, player.Direction.Left)

func OnInputControllerLeftMousePressed() -> void:
	print("left mouse button clicked!!")
	var item = preload("res://Scenes/Items/Item.tscn")
	var location = Vector2(0, 0)
	pass # Replace with function body.
