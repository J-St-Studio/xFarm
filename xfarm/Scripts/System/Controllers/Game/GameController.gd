# GameController.gd
# controls many aspects of the game world
# emits signals for game world / game systems
class_name GameController extends Controller

var event: EventController
var logger: LogController
var world: WorldGenerator;

var GlobalDelta: float
static var CurrentGameState: int = GameState.MainMenu
var CurrentLevel: int = GameState.MainMenu

var mainMenuRendered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	Initialize()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDelta = delta
	if (!system.IsOnline() or world == null):
		# do stuff here eventually maybe
		state = Controller.State.FAIL
		return
	if (!mainMenuRendered and CurrentGameState == GameState.MainMenu):
		event.BroadcastUIRenderMainMenu()
		mainMenuRendered = true
	elif(mainMenuRendered and CurrentGameState == GameState.UnPaused):
		event.BroadcastUITeardownMainMenu()
		mainMenuRendered = false

func Initialize() -> int:
	if (!system):
		state = Controller.State.FAIL
		return state
	
	event = system.GetEventController()
	logger = system.GetLogController()
	world = WorldGenerator.new()
	allocations.append(world)
	
	if (!event or !logger or !world):
		state = Controller.State.FAIL
		return state
	
	CurrentGameState = GameState.MainMenu
	ConnectSignals({
		event.input_escape_pressed: PauseGame,
	})
	add_child(world)
	
	state = Controller.State.ONLINE
	return state

func SetCurrentLevel(Level: int) -> void:
	CurrentLevel = Level
	pass

func GetCurrentLevel() -> int:
	return CurrentLevel

func GetCurrentGameState() -> int:
	return CurrentGameState

func SetCurrentGameState(state_: int) -> void:
	CurrentGameState = state_

func GamePaused() -> bool:
	return CurrentGameState == GameState.Paused

func GameUnPaused() -> bool:
	return CurrentGameState == GameState.UnPaused

func GetWorld() -> WorldGenerator:
	return world
	
func StartGame() -> void:
	CurrentGameState = GameState.UnPaused

func PauseGame() -> void:
	if (GamePaused()):
		logger.message(self, "unpausing game ...")
		SetCurrentGameState(GameState.UnPaused)
		event.game_set_control_type.emit(InputTypes.Types.PLAYER)
		event.BroadcastUITeardownPauseMenu()

	elif (GameUnPaused()):
		logger.message(self, "pausing game ...")
		SetCurrentGameState(GameState.Paused)
		event.game_set_control_type.emit(InputTypes.Types.UI)
		event.BroadcastUIRenderPauseMenu()

	elif (CurrentGameState == GameState.MainMenu):
		logger.message(self, "game is in main menu, unpausing")
		SetCurrentGameState(GameState.UnPaused)
		event.game_set_control_type.emit(InputTypes.Types.PLAYER)
		event.BroadcastUITeardownPauseMenu()
		event.BroadcastUIRenderMainMenu()

func QuitGame() -> void:
	# do stuff
	event.BroadcastUIRenderMainMenu()
	return

func shutdown() -> Controller.State:
	if (world):
		world.free()
	return super.shutdown()
