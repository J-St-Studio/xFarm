# GameController.gd
# controls many aspects of the game world
class_name GameController extends Node2D
@onready var Home: Node2D = $"../.."

var InputController = preload("res://Scripts/Input/InputController.gd")
const LogController = preload("res://Scripts/System/LogController.gd")

var precision = preload("res://Scripts/System/precision.gd")

const PLAYER = preload("res://Scenes/player.tscn")
var GlobalDelta: float

@export var PLANT_ITEM: PackedScene = preload("res://Scenes/Items/PlantItem.tscn")

var Plants: PlantData = PlantData.new()
var WorldTime: float = 0.0;
const WorldTimeReportInterval: int = 1;
var LastLoggedSecond: int = -1; # Tracks the last integer second logged to prevent skipping ticks

const Minute: int = 60.0;
const Hour: int = Minute * 60;
const Day: int = Hour * 24;

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
	SpawnPlant(Plants.Watermelon, Vector2(20, 20))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDelta = delta
	CheckForGamePause()
	UpdateGameWorld()
	
# Removed PrintWorldTime function as its logic was flawed and replaced by direct logging in UpdateGameWorld().
	

func GetWorldTimeAsString(_precision: int = 0) -> String:
	return precision.of(WorldTime, _precision)

func GetWorldTime() -> float:
	return WorldTime

func UpdateGameWorld():
	# don't update the game world if game is paused (time/enemies?/etc)
	if (CurrentGameState == GameState.Paused): return
	
	# Time advancement logic
	var old_world_time = WorldTime;
	WorldTime += 1 * GlobalDelta;
	spinner_sprite.rotate(PI * 2 * GlobalDelta)
	# Check if we have crossed an integer second boundary since the last log
	var current_second = floor(WorldTime);
	if (current_second > LastLoggedSecond):
		LogController.LogMessage(self, "WorldTime: ", GetWorldTimeAsString(2));
		LastLoggedSecond = int(current_second);
	pass

func CheckForGamePause() -> void:
	if (InputController.PauseKeyPressed() && GamePaused()):
		LogController.LogMessage(self, "Game Unpaused")
		SetCurrentGameState(GameState.UnPaused)
		InputController.UpdateControlType(InputTypes.Types.PLAYER)
	elif (InputController.PauseKeyPressed() && GameUnPaused()):
		LogController.LogMessage(self, "Game Paused")
		SetCurrentGameState(GameState.Paused)
		InputController.UpdateControlType(InputTypes.Types.UI)

func SpawnPlant(Plant: Dictionary, Position: Vector2) -> PlantItem:
	var NewPlant = PlantItem.new(Plant)
	var plant = PLANT_ITEM.instantiate() as Node2D
	Home.add_child(plant)
	plant.position = Position
	return NewPlant
	
func SpawnTool(Tool: Dictionary) -> ToolItem:
	return ToolItem.new(Tool)

static func GetCurrentGameState() -> int:
	return CurrentGameState

static func SetCurrentGameState(state: int) -> void:
	CurrentGameState = state
	
static func GamePaused() -> bool:
	return CurrentGameState == GameState.Paused

static func GameUnPaused() -> bool:
	return CurrentGameState == GameState.UnPaused
