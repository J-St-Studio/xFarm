# GameController.gd
# controls many aspects of the game world


extends Node2D

var LogController = preload("res://Scripts/LogController.gd")
var InputController = preload("res://Scripts/InputController.gd")
var InputTypes = preload("res://Scripts/InputTypes.gd")

var GlobalDelta: float

@onready var chest_2: Sprite2D = $"../../Chest2"


# should game state enum be separated from GameController?
# it's own gd file? GameStatus.gd?
enum GameState {
	MainMenu,
	Paused,
	UnPaused
}

static var CurrentGameState: int;
static var CurrentWorldTime: String; # Ideally get this represented in UI in a 24HR clock

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentGameState = GameState.UnPaused
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDelta = delta
	CheckForGamePause()
	UpdateGameWorld()
	
func UpdateGameWorld():
	# don't update the game world if game is paused (time/enemies?/etc)
	if (CurrentGameState == GameState.Paused): return
	
	chest_2.rotate(PI * 2 * GlobalDelta)
	# maybe handle things in here?
	# Game time logic?
	# Plant growth?
	# World events?

func CheckForGamePause() -> void:
	if (InputController.PauseKeyPressed() && IsGamePaused()):
		LogController.LogMessage(self, "Game Unpaused")
		SetCurrentGameState(GameState.UnPaused)
		InputController.UpdateControlType(InputTypes.Types.UI)
	elif (InputController.PauseKeyPressed() && IsGameUnPaused()):
		LogController.LogMessage(self, "Game Paused")
		SetCurrentGameState(GameState.Paused)
		InputController.UpdateControlType(InputTypes.Types.PLAYER)

static func GetCurrentGameState() -> int:
	return CurrentGameState

static func SetCurrentGameState(state: int) -> void:
	CurrentGameState = state
	
static func IsGamePaused() -> bool:
	return CurrentGameState == GameState.Paused

static func IsGameUnPaused() -> bool:
	return CurrentGameState == GameState.UnPaused
	
