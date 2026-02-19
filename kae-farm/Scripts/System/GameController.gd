# GameController.gd
# controls many aspects of the game world


class_name GameController extends Node2D
@onready var home: Node2D = $"../.."

var LogController = preload("res://Scripts/System/LogController.gd")
var InputController = preload("res://Scripts/Input/InputController.gd")
#var InputTypes = preload("res://Scripts/Input/InputTypes.gd")

var GlobalDelta: float

@onready var spinner_sprite: Sprite2D = $"../../TestingSprites/SpinnerSprite"


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
	SpawnItem("Corn", Vector2(20, 20), home)
	pass # Replace with namefunction body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDelta = delta
	CheckForGamePause()
	UpdateGameWorld()
	
func UpdateGameWorld():
	# don't update the game world if game is paused (time/enemies?/etc)
	if (CurrentGameState == GameState.Paused): return
	
	spinner_sprite.rotate(PI * 2 * GlobalDelta)
	# maybe handle things in here?
	# Game time logic?
	# Plant growth?
	# World events?

func CheckForGamePause() -> void:
	if (InputController.PauseKeyPressed() && GamePaused()):
		LogController.LogMessage(self, "Game Unpaused")
		SetCurrentGameState(GameState.UnPaused)
		InputController.UpdateControlType(InputTypes.Types.PLAYER)
	elif (InputController.PauseKeyPressed() && GameUnPaused()):
		LogController.LogMessage(self, "Game Paused")
		SetCurrentGameState(GameState.Paused)
		InputController.UpdateControlType(InputTypes.Types.UI)

func SpawnItem(name: String, position: Vector2, parentNode: Node) -> Item:
	var new_item: Item = Item.new()
	new_item.SetName(name)
	parentNode.add_child(new_item)
	new_item.position = position
	return new_item

static func GetCurrentGameState() -> int:
	return CurrentGameState

static func SetCurrentGameState(state: int) -> void:
	CurrentGameState = state
	
static func GamePaused() -> bool:
	return CurrentGameState == GameState.Paused

static func GameUnPaused() -> bool:
	return CurrentGameState == GameState.UnPaused
	
