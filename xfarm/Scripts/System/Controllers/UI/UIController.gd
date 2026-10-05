#
# UIController
# Responsible for rendering information as UI.
class_name UIController extends Controller

var pauseMenuResouce: PackedScene = preload("res://Scenes/UI/Menus/PauseMenu.tscn")
var mainMenuResource: PackedScene = preload("res://Scenes/UI/Menus/MainMenu.tscn")

var pauseMenu	: CanvasLayer = null
var mainMenu	: CanvasLayer = null

var quitButton			: Button = null
var mainMenuQuitButton	: Button = null
var mainMenuStartButton	: Button = null
var settingsButton		: Button = null
var resumeButton		: Button = null
var pauseMenuQuitButton	: Button = null

var event		: EventController 	= null
var generator	: TextureGenerator 	= null
var logger		: LogController 	= null

var backgroundTexture	: Texture2D = null

var mainMenuRendered	: bool = false

var PauseMenuAllocations	: Array
var MainMenuAllocations		: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	Initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if the game is unpaused, no UI control? -> what about in-game menu?
	return

## Initialization code blocks
func Initialize() -> Controller.State:
	MakeAllocations()
	state = VerifyAllocations()
	SetupMenus()
	ConnectSignals({})
	CreateBackgroundTexture()
	
	return state

func CreateBackgroundTexture() -> void:
	backgroundTexture = generator.GenerateTexture({
		TextureGenerator.size: 64,
		TextureGenerator.red: 0,
		TextureGenerator.green: 0,
		TextureGenerator.blue: 1,
	})

func ConnectSignals(_map: Dictionary) -> void:
	super.ConnectSignals({
		event.ui_render_main_menu: RenderMainMenu,
		event.ui_teardown_main_menu: TeardownMainMenu,
		event.ui_render_pause_menu: RenderPauseMenu,
		event.ui_teardown_pause_menu: TeardownPauseMenu,
		quitButton.button_up: QuitButtonPressed
	})

func SetupMenus() -> void:
	mainMenu = mainMenuResource.instantiate()
	pauseMenu = pauseMenuResouce.instantiate()
	mainMenu.hide()
	pauseMenu.hide()
	add_child(mainMenu)
	add_child(pauseMenu)
	var QuitControl: Control = mainMenu.get_node("./Control/Quit")
	quitButton = QuitControl.get_node("./QuitButton")

func MakeAllocations() -> void:
	event = system.GetEventController()
	logger = system.GetLogController()
	generator = TextureGenerator.new(1)
	allocations.append(generator)

func VerifyAllocations() -> Controller.State:
	if (!event or !logger ): 
		return Controller.State.FAIL
	return Controller.State.ONLINE
## end initialization

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

func QuitButtonPressed() -> void:
	system.shutdown()
	
