#
# UIController
# Responsible for rendering information as UI.
class_name UIController extends Controller

var pauseMenuResouce: PackedScene = preload("res://Scenes/Menus/PauseMenu.tscn")
var mainMenuResource: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")

var pauseMenu: CanvasLayer = null
var mainMenu: CanvasLayer = null

var event: EventController
var generator: TextureGenerator
var logger: LogController

var backgroundTexture: Texture2D

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
	allocations.append(generator)
	
	if (!event or !logger ): 
		state = Controller.State.FAIL
		return state
	
	mainMenu = mainMenuResource.instantiate()
	pauseMenu = pauseMenuResouce.instantiate()
	mainMenu.hide()
	pauseMenu.hide()
	add_child(mainMenu)
	add_child(pauseMenu)
	
	ConnectSignals({
		event.ui_render_main_menu: RenderMainMenu,
		event.ui_teardown_main_menu: TeardownMainMenu,
		event.ui_render_pause_menu: RenderPauseMenu,
		event.ui_teardown_pause_menu: TeardownPauseMenu,
	})
	
	backgroundTexture = generator.GenerateTexture({
		TextureGenerator.size: 64,
		TextureGenerator.red: 0,
		TextureGenerator.green: 0,
		TextureGenerator.blue: 1,
	})

	return state

func Update(state: GameState) -> void:
	return

func RenderMainMenu() -> void:
	logger.message(self, "rendering main menu!")
	mainMenu.show()
	
func RenderPauseMenu() -> void:
	logger.message(self, "rendering pause menu!")
	pauseMenu.show()

func TeardownMainMenu() -> void:
	logger.message(self, "tearing down main menu!")
	mainMenu.hide()
	
func TeardownPauseMenu() -> void:
	logger.message(self, "tearing down pause menu!")
	pauseMenu.hide()

static func Get() -> UIController:
	var tree: SceneTree = Engine.get_main_loop() as SceneTree
	return tree.root.get_main_looop().find_child("UIController", true, false) as UIController
