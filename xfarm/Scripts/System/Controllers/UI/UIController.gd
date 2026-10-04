#
# UIController
# Responsible for rendering information as UI.
class_name UIController extends Controller

var event: EventController
var generator: TextureGenerator
var logger: LogController

var pauseMenuCanvas: CanvasLayer
var mainMenuCanvas: CanvasLayer

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

var PauseMenuAllocations: Array
var MainMenuAllocations: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	Initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if the game is unpaused, no UI control? -> what about in-game menu?
	return
	
func Initialize() -> Controller.State:
	state = Controller.State.ONLINE
	event = system.GetEventController()
	logger = system.GetLogController()
	generator = TextureGenerator.new(1)
	pauseMenuCanvas = CanvasLayer.new()
	mainMenuCanvas = CanvasLayer.new()
	allocations.append(pauseMenuCanvas)
	allocations.append(mainMenuCanvas)
	allocations.append(generator)
	
	if (!event or !logger or !pauseMenuCanvas or !mainMenuCanvas): 
		state = Controller.State.FAIL
		return state
	
	add_child(pauseMenuCanvas)
	add_child(mainMenuCanvas)

	pauseMenuCanvas.hide()
	mainMenuCanvas.show()
	
	ConnectSignals({
		event.ui_render_main_menu: RenderMainMenu,
		event.ui_teardown_main_menu: TeardownMainMenu,
		event.ui_render_pause_menu: RenderPauseMenu,
		event.ui_teardown_pause_menu: TeardownPauseMenu
	})
	
	backgroundTexture = generator.GenerateTexture({
		TextureGenerator.size: 64,
		TextureGenerator.red: 0,
		TextureGenerator.green: 0,
		TextureGenerator.blue: 1,
	})

	return state

func Update(state: GameState) -> void:
	# Implementation for broadcasting inventory full message
	# update game UI
	# this is gonna be a fucker of a function, not sure I like the design.
	return

# maybe generic menu function with args passed in? Maybe.
	
func RenderMainMenu() -> void:
	logger.message(self, "rendering main menu!")
	for x in range(MapLeftBound, MapRightBound, TileStep):
		for y in range(MapUpperBound, MapLowerBound, -TileStep):
			var spawn_point: Vector2 = Vector2(x, y)
			UIMap[spawn_point] = SpawnMenuTexture(spawn_point)
	
	var mainMenuLabel: Label = Label.new()
	mainMenuCanvas.add_child(mainMenuLabel)
	return

func SpawnMenuTexture(location: Vector2) -> Tile:
	var tile: Tile = Tile.new(backgroundTexture, location)
	add_child(tile)
	allocations.append(tile)
	MainMenuAllocations.append(tile)
	return tile

func RenderPauseMenu() -> void:
	logger.message(self, "rendering pause menu!")
	var pausedLabel: Label = Label.new()
	pausedLabel.text = "PAUSED"
	pauseMenuCanvas.add_child(pausedLabel)
	pausedLabel.position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	allocations.append(pausedLabel)
	PauseMenuAllocations.append(pausedLabel)
	pauseMenuCanvas.show()
	return
	
func TeardownMainMenu() -> void:
	logger.message(self, "tearing down main menu!")
	for allocation in MainMenuAllocations:
		if (allocation):
			allocation.free()
	mainMenuCanvas.hide()

func TeardownPauseMenu() -> void:
	logger.message(self, "tearing down pause menu!")
	for allocation in PauseMenuAllocations:
		if (allocation):
			allocation.free()
	pauseMenuCanvas.hide()
	return

static func Get() -> UIController:
	var tree: SceneTree = Engine.get_main_loop() as SceneTree
	return tree.root.get_main_looop().find_child("UIController", true, false) as UIController
