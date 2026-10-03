#
# UIController
# Responsible for rendering information as UI.
class_name UIController extends Controller
var system: System = System.Get()
var game: GameController
var event: EventController
var generator: TextureGenerator

var backgroundTexture: Texture2D

var UIMap: Dictionary

const MapMultiplier: int = 1;
const MapSize: int = 1000;

# map bounds
const MapLeftBound: int = -MapSize * (MapMultiplier);
const MapRightBound: int = MapSize * (MapMultiplier);
const MapUpperBound: int = MapSize * (MapMultiplier);
const MapLowerBound: int = -MapSize * (MapMultiplier);
const TileStep: int = 64

var mainMenuRendered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	Initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if the game is unpaused, no UI control? -> what about in-game menu?
	if (!mainMenuRendered and game and game.CurrentGameState == GameState.MainMenu):
		event.BroadcastUIRenderMainMenu()
		mainMenuRendered = true
	elif(mainMenuRendered and game and game.CurrentGameState == GameState.UnPaused):
		event.BroadcastUITeardownMainMenu()
		mainMenuRendered = false
		
	return
	
func Initialize() -> Controller.State:
	state = Controller.State.ONLINE
	game = system.GetGameController()
	event = system.GetEventController()
	generator = TextureGenerator.new(1)
	allocations.append(generator)
	
	if (!game or !event): 
		state = Controller.State.FAIL
		return state
		
	ConnectSignals({
		event.ui_render_main_menu: RenderMainMenu,
		event.ui_teardown_main_menu: TeardownMainMenu
	})
	
	backgroundTexture = generator.GenerateTexture({
		TextureGenerator.size: 64,
		TextureGenerator.red: 1,
		TextureGenerator.green: 1,
		TextureGenerator.blue: 1,
		
		#TextureGenerator.roughness: randf_range(2, 3),
		#TextureGenerator.detail_scale: randf_range(10, 20),
		#TextureGenerator.octaves: randf_range(8, 9)
	})
	return state

func Update(state: GameState) -> void:
	# Implementation for broadcasting inventory full message
	# update game UI
	# this is gonna be a fucker of a function, not sure I like the design.
	return

# maybe generic menu function with args passed in? Maybe.
	
func RenderMainMenu() -> void:
	# somehow decide what type of tile map we're generating
	# ie: forest, desert, plains, etc
	#var camera: Camera2D = Camera2D.new()
	#camera.position = Vector2(0, 0)
	for x in range(MapLeftBound, MapRightBound, TileStep):
		for y in range(MapUpperBound, MapLowerBound, -TileStep):
			var spawn_point: Vector2 = Vector2(x, y)
			UIMap[spawn_point] = SpawnMenuTexture(spawn_point)
		pass
	pass
	#allocations.append(SpawnMenuTexture(Vector2(0, 0)))
## end

func SpawnMenuTexture(location: Vector2) -> Tile:
	var tile: Tile = Tile.new(backgroundTexture, location)
	add_child(tile)
	allocations.append(tile)
	return tile

func RenderPauseMenu() -> void:
	return
	
func TeardownMainMenu() -> void:
	for allocation in allocations:
		if (allocation):
			print("found UI allocation, freeing")
			allocation.free()
	allocations.clear()
