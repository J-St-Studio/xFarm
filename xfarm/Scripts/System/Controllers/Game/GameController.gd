# GameController.gd
# controls many aspects of the game world
# emits signals for game world / game systems
class_name GameController extends Controller
var EC = System.GetEventController()
var LC = System.GetLogController()
var Scenes = EnvironmentScenes
var oneShot: OneShot = OneShot.new()

# class controllers
var enemyController: EnemyController
var timeController: TimeController
# environment conroller? lmao. maybe.

# class variables
var GlobalDelta: float
static var CurrentGameState: int;
var spawn_controllers: bool = true

enum GameState {
	MainMenu,
	Paused,
	UnPaused
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	CurrentGameState = GameState.UnPaused
	ConnectSignals({
		EC.game_paused: PauseGame,
	})

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDelta = delta
	if (System.IsOnline()):
		GenerateGameWorld().once = true
		UpdateGameWorld()

func GenerateGameWorld() -> OneShot:
	if (oneShot.once): return oneShot
	LC.message(self, "generating game world")
	# GenerateSurface()
	GeneratePlants(1000, Vector2(100 * 100, 100 * 100))
	# GenerateBuildings()
	# GenerateEnemySpawnPoints()
	# GenerateItems()
	# GenerateMisc ...
	return oneShot

func UpdateGameWorld() -> bool:
	# don't update the game world if game is paused (time/enemies?/etc)
	if (CurrentGameState != GameState.UnPaused): return false
	if (CurrentGameState == GameState.MainMenu):
		#go_to_main_menu.emit()
		System.GetEventController().go_to_main_menu.emit()
		return false
	return true

func SpawnEntity(entity: Entity, parameters: EntityParams) -> Node2D:
	var new_entity = entity.instantiate()
	return new_entity

func SpawnScene(scene: Resource, location: Vector2) -> Node2D:
	var new_scene = scene.instantiate()
	new_scene.global_position = location
	add_child(new_scene)
	return new_scene

func GeneratePlants(quantity: int, spawnRange: Vector2) -> void:
	var x = int(spawnRange.x)
	var y = int(spawnRange.y)
	var plant: Resource = Scenes.Plant
	SpawnScene(plant, Vector2(100, 100))
	for  i in range(0, quantity):
		var shouldNegate = randi_range(0, 1)
		if (shouldNegate):
			shouldNegate = -1
		else:
			shouldNegate = 1
		SpawnScene(plant, Vector2(
			randi() % x + 1 * shouldNegate, 
			randi() % y + 1 * shouldNegate
		))
	pass
pass

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
		EC.set_control_type.emit(InputTypes.Types.PLAYER)
	elif (GameUnPaused()):
		SetCurrentGameState(GameState.Paused)
		EC.set_control_type.emit(InputTypes.Types.UI)
	pass
