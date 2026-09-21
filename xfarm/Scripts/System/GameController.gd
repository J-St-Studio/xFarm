# GameController.gd
# controls many aspects of the game world
# emits signals for game world / game systems
class_name GameController extends Controller

signal game_paused
signal game_unpaused
signal game_over
signal set_control_type
signal one_second_elapsed
signal spawn_player
signal go_to_main_menu

var precision = preload("res://Scripts/System/precision.gd")
var enemy_one: PackedScene = preload("res://Scenes/Enemy.tscn")

var GlobalDelta: float
var Plants: PlantData = PlantData.new()
var WorldTime: float = 0.0;
const WorldTimeReportInterval: int = 1;
var LastLoggedSecond: int = -1; # Tracks the last integer second logged to prevent skipping ticks
const Minute: int = 60.0;
const Hour: int = Minute * 60;
const Day: int = Hour * 24;
static var CurrentGameState: int;
static var CurrentWorldTime: String; # Ideally get this represented in UI in a 24HR clock

# should game state enum be separated from GameController?
# it's own gd file? GameStatus.gd?
enum GameState {
	MainMenu,
	Paused,
	UnPaused
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SystemController.GetLogController().message(self, "online")
	CurrentGameState = GameState.UnPaused
	#spawn_player.emit()
	ConnectSignals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDelta = delta
	UpdateGameWorld()

func ConnectSignals() -> void:
	#print(PC)
	return

func UpdateGameWorld() -> bool:
	# don't update the game world if game is paused (time/enemies?/etc)
	if (CurrentGameState != GameState.UnPaused): return false
	if (CurrentGameState == GameState.MainMenu):
		go_to_main_menu.emit()
		return false
	AdvanceWorldTime()
	return true

func AdvanceWorldTime() -> void:
	var old_world_time = WorldTime;
	WorldTime += 1 * GlobalDelta;
	# Check if we have crossed an integer second boundary since the last log
	var current_second = floor(WorldTime);
	if (current_second > LastLoggedSecond):
		LastLoggedSecond = int(current_second);
		one_second_elapsed.emit()

func GetWorldTimeAsString(_precision: int = 0) -> String:
	return precision.of(WorldTime, _precision)

func GetWorldTime() -> float:
	return WorldTime

func SpawnItem(item: Resource, location: Vector2) -> Node2D:
	# get root scene$"../.."
	 # 1. Instantiate the scene/resource provided by the caller.                                                       
	var new_item = item.instantiate()                                                                        
	# 2. Set its global position in the game world.                                                                   
	new_item.global_position = location                                                                               
	# 3. Add it as a child of the GameController (the main world container).                                          
	add_child(new_item)
	print("Item Spawned: ", new_item)                                                                                   
	# 4. Return the newly spawned item instance.                                                                      
	return new_item

func SetLevel(Level: PackedScene) -> void:
	pass

static func GetCurrentGameState() -> int:
	return CurrentGameState

static func SetCurrentGameState(state: int) -> void:
	CurrentGameState = state
	
static func GamePaused() -> bool:
	return CurrentGameState == GameState.Paused

static func GameUnPaused() -> bool:
	return CurrentGameState == GameState.UnPaused

func PauseGame() -> void:
	if (GamePaused()):
		SetCurrentGameState(GameState.UnPaused)
		set_control_type.emit(InputTypes.Types.PLAYER)
	elif (GameUnPaused()):
		SetCurrentGameState(GameState.Paused)
		set_control_type.emit(InputTypes.Types.UI)
	pass
