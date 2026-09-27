# GameController.gd
# controls many aspects of the game world
# emits signals for game world / game systems
class_name GameController extends Controller
var EC = System.GetEventController()
var LC = System.GetLogController()
var world: WorldGenerator;

var GlobalDelta: float
var CurrentGameState: int
var spawn_controllers: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	CurrentGameState = GameState.UnPaused
	ConnectSignals({
		EC.input_escape_pressed: PauseGame,
	})
	world = WorldGenerator.new()
	add_child(world)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDelta = delta
	if (System.IsOnline() and world != null):
		# do stuff here eventually maybe
		pass

func SetLevel(Level: PackedScene) -> void:
	pass

func GetCurrentGameState() -> int:
	return CurrentGameState

func SetCurrentGameState(state: int) -> void:
	CurrentGameState = state

func GamePaused() -> bool:
	return CurrentGameState == GameState.Paused

func GameUnPaused() -> bool:
	return CurrentGameState == GameState.UnPaused

func PauseGame() -> void:
	if (GamePaused()):
		LC.message(self, "unpausing game ...")
		SetCurrentGameState(GameState.UnPaused)
		EC.game_set_control_type.emit(InputTypes.Types.PLAYER)
	elif (GameUnPaused()):
		LC.message(self, "pausing game ...")
		SetCurrentGameState(GameState.Paused)
		EC.game_set_control_type.emit(InputTypes.Types.UI)
	elif (CurrentGameState == GameState.MainMenu):
		LC.message(self, "game is in main menu, cannot pause")
		# initiate quit dialogue or something
	pass
