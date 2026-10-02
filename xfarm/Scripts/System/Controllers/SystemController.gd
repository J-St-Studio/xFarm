class_name System extends Controller

static var game: GameController
static var log: LogController
static var input: InputController
static var player: PlayerController
static var UI: UIController
static var audio: AudioController
static var event: EventController
static var time: TimeController
static var enemy: EnemyController

static var SystemControllers: Array

func _ready() -> void:
	Initialize()
	print("SYSTEM STATE: ", state)

func Initialize() -> int:
	print("Core online, initializing system controllers...\n")
	log = InitializeController(LogController)
	event = InitializeController(EventController)
	input = InitializeController(InputController)
	audio = InitializeController(AudioController)
	UI = InitializeController(UIController)
	game = InitializeController(GameController)
	player = InitializeController(PlayerController)
	time = InitializeController(TimeController)
	enemy = InitializeController(EnemyController)
	print("SYSTEM: all system-level controllers initialized")

	if (IsOnline()):
		SystemControllers.append(self)
		PrintSystemReport()
		state = 1
	else:
		print("CRITICAL SYSTEM FAILURE. ABORTING.")
		state = -1
		
	return state

func InitializeController(ControllerType: Variant) -> Controller:
	var controller: Controller = ControllerType.new()
	if (!controller):
		print(ControllerType, "failed to initialize, CRITICAL FAILURE, exiting")
		return null
	print("SYSTEM: Initializing [", controller.name, "] ...")
	controller.name = controller.get_script().get_global_name()
	controller.state = ControllerStatus[ONLINE]
	SystemControllers.append(controller)
	add_child(controller)
	print("SYSTEM: ", controller.name, " initialized!\n")
	return controller

static func GetGameController() -> GameController:
	return game

static func GetLogController() -> LogController:
	return log

static func GetInputController() -> InputController:
	return input

static func GetAudioController() -> AudioController:
	return audio

static func GetUIController() -> UIController:
	return UI

static func GetPlayerController() -> PlayerController:
	return player
	
static func GetEventController() -> EventController:
	return event

static func GetTimeController() -> TimeController:
	return time

static func GetEnemyController() -> EnemyController:
	return enemy
	
static func GetSystemControllers() -> Array:
	return SystemControllers
	
static func IsOnline() -> bool:
	for controller in SystemControllers:
		if (!controller):
			state = ControllerState.FAIL
			return false
	return state

func SystemReport() -> Dictionary:
	var ControllerStates: Dictionary
	for controller in SystemControllers:
		ControllerStates[controller] = controller.GetControllerState()
	return ControllerStates

func PrintSystemReport() -> void:
	var report: Dictionary = SystemReport()
	var keys = report.keys()
	var max_length_ = 0
	for key in report.keys():
		max_length_ = maxi(max_length_, key.name.length())
	print("SYSTEM: SYSTEM CONTROLLER INITIALIZATION COMPLETE -> {")
	for key in keys:
		print("\t\t\t", key.name.rpad(max_length_), "\t", report[key])
	print("\t}\n")
