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
	var SystemStatus = Initialize()
	if (SystemStatus != 0):
		print("System Errors")

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
		PrintSystemReport()
	else:
		print("CRITICAL SYSTEM FAILURE. ABORTING.")
		return -1
	return 0

func InitializeController(ControllerType: Variant) -> Controller:
	var controller: Controller = ControllerType.new()
	if (!controller):
		print(ControllerType, "failed to initialize, CRITICAL FAILURE, exiting")
		return null
	var name = controller.get_script().get_global_name()
	print("SYSTEM: Initializing [", name, "] ...")
	controller.name = name
	SystemControllers.append(controller)
	add_child(controller)
	controller.status = ControllerStatus[ONLINE]
	print("SYSTEM: ", controller.name, " initialized!\n")
	return controller

static func GetGameController() -> GameController:
	return game

static func GetLogController() -> LogController:
	return log

static func GetInputController() -> InputController:
	return input

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
		if (!controller.status):
			return false
	return true

func SystemReport() -> Dictionary:
	var ControllerStates: Dictionary;
	for controller in SystemControllers:
		ControllerStates[controller] = controller.GetControllerStatus();
	return ControllerStates

func PrintSystemReport() -> void:
	var report: Dictionary = SystemReport();
	var keys = report.keys()
	var max_length_ = 0
	for key in report.keys():
		max_length_ = maxi(max_length_, key.name.length())
	print("SYSTEM: SYSTEM CONTROLLER INITIALIZATION COMPLETE -> {")
	for key in keys:
		print("\t\t\t", key.name.rpad(max_length_), "\t", report[key])
	print("\t}\n")
	
