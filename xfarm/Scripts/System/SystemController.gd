class_name SystemController extends Controller

static var game: GameController
static var log: LogController
static var input: InputController
static var player: PlayerController
static var UI: UIController
static var audio: AudioController

static var Controllers: Array

func _ready() -> void:
	Initialize()

func Initialize() -> void:
	print("System online, initializing controllers...\n")
	log = InitializeController(LogController)
	game = InitializeController(GameController)
	input = InitializeController(InputController)
	audio = InitializeController(AudioController)
	UI = InitializeController(UIController)
	player = InitializeController(PlayerController)
	
	PrintSystemReport()
	return

func InitializeController(ControllerType: Variant) -> Controller:
	var controller: Controller = ControllerType.new()
	if (!controller):
		print(ControllerType, "failed to initialize, CRITICAL FAILURE, exiting")
		return null
	var name = controller.get_script().get_global_name()
	print("SYSTEM: Initializing [", name, "] ...")
	controller.name = name
	Controllers.append(controller)
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
	
static func GetControllers() -> Array:
	return Controllers
	
func IsSystemOnline() -> bool:
	for controller in Controllers:
		if (!controller.status):
			return false
	return true

func SystemReport() -> Dictionary:
	var ControllerStates: Dictionary;
	for controller in Controllers:
		ControllerStates[controller] = controller.GetControllerStatus();
	return ControllerStates

func PrintSystemReport() -> void:
	var report: Dictionary = SystemReport();
	var keys = report.keys()
	var max_length_ = 0
	for key in report.keys():
		max_length_ = maxi(max_length_, key.name.length())
	print("SYSTEM: CONTROLLER INITIALIZATION COMPLETE -> {")
	for key in keys:
		print("\t\t\t", key.name.rpad(max_length_), "\t", report[key])
	print("\t}\n")
	
