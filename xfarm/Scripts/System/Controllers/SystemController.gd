class_name System extends Controller

var game: GameController
var logger: LogController
var input: InputController
var player: PlayerController
var UI: UIController
var audio: AudioController
var event: EventController
var time: TimeController
var enemy: EnemyController

var SystemControllers: Array[Controller]

func _ready() -> void:
	Initialize()

func Initialize() -> Controller.State:
	print("Core online, initializing system controllers...\n")
	logger = InitializeController(LogController)
	event = InitializeController(EventController)
	input = InitializeController(InputController)
	audio = InitializeController(AudioController)
	UI = InitializeController(UIController)
	game = InitializeController(GameController)
	player = InitializeController(PlayerController)
	time = InitializeController(TimeController)
	enemy = InitializeController(EnemyController)
	PrintSystemReport()
	
	state = IsOnline()
	
	if (state == Controller.State.ONLINE):
		print("SYSTEM: all system-level controllers initialized successfully")
	else:
		print("CRITICAL SYSTEM FAILURE. ABORTING.")
		
	return state

func InitializeController(ControllerType: Variant) -> Controller:
	var controller: Controller = ControllerType.new()
	if (!controller):
		print(ControllerType, "failed to initialize, CRITICAL FAILURE, exiting")
		return null
	controller.name = controller.get_script().get_global_name()
	#controller.state = Controller.State.ONLINE
	print("SYSTEM: Initializing [", controller.name, "] ...")
	SystemControllers.append(controller)
	allocations.append(controller)
	add_child(controller)
	print("SYSTEM: ", controller.name, " initialized!\n")
	return controller

func GetGameController() -> GameController:
	return game

func GetLogController() -> LogController:
	return logger

func GetInputController() -> InputController:
	return input

func GetAudioController() -> AudioController:
	return audio

func GetUIController() -> UIController:
	return UI

func GetPlayerController() -> PlayerController:
	return player
	
func GetEventController() -> EventController:
	return event

func GetTimeController() -> TimeController:
	return time

func GetEnemyController() -> EnemyController:
	return enemy
	
func GetControllers() -> Array[Controller]:
	return SystemControllers

static func Get() -> System:
	var tree: SceneTree = Engine.get_main_loop() as SceneTree
	return tree.root.find_child("System", true, false) as System
	
func IsOnline() -> Controller.State:
	for controller in SystemControllers:
		if (controller == null):
			return Controller.State.FAIL
	return Controller.State.ONLINE

func GetSystemReport() -> Dictionary:
	var ControllerStates: Dictionary
	for controller in SystemControllers:
		ControllerStates[controller] = controller.GetState()
	return ControllerStates

func PrintSystemReport() -> void:
	var report: Dictionary = GetSystemReport()
	var keys = report.keys()
	var max_length_ = 0
	for key in report.keys():
		max_length_ = maxi(max_length_, key.name.length())
	print("SYSTEM: SYSTEM CONTROLLER INITIALIZATION COMPLETE -> {")
	for key in keys:
		print("\t\t\t", key.name.rpad(max_length_), "\t", report[key] as Controller.State)
	print("\t}\n")

func GetController(controller: Controller) -> Controller:
	if controller in SystemControllers:
		return controller
	else:
		return null

func shutdown() -> int:
	return super.shutdown()
